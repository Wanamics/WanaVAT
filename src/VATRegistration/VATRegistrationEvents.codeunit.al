namespace Wanamics.WanaVAT;

using Microsoft.Finance.VAT.Registration;
using Microsoft.Sales.Customer;
codeunit 87042 "VAT Registration Events"
{
    [EventSubscriber(ObjectType::Table, Database::"VAT Registration Log", OnBeforeValidateField, '', false, false)]
    local procedure SplitAddress(var RecordRef: RecordRef; FieldName: Text; var Value: Text; var IsHandled: Boolean)
    var
        Dummy: Record Customer; // Address FieldIds are the same for Customer, Vendor or Contact 
        // FieldRef: FieldRef;
        i, j : Integer;
        AddressLine: Text;
        LineFeed: Text[1];
        Pos: Integer;
    begin
        if (FieldName <> Dummy.FieldName(Address)) or (Value = '') then
            exit;
        i := StrLen(Value);
        while (i > 1) and (Value[i] <> ',') and (not (Value[i] in ['0' .. '9']) or (not (Value[i - 1] in ['0' .. '9']) or not (Value[i - 2] in ['0' .. '9']))) do
            i -= 1;
        if Value[i] = ',' then
            i += 1
        else
            while (i > 1) and (Value[i - 1] in ['0' .. '9', 'A' .. 'Z', '-', '_', '.']) do
                i -= 1;
        // FieldRef := RecordRef.Field(Dummy.FieldNo(Address));
        AddressLine := Value.Substring(1, i - 2);
        LineFeed[1] := 10;
        Pos := StrPos(AddressLine, LineFeed);
        if Pos = 0 then
            RecordRef.Field(Dummy.FieldNo(Address)).Value := AddressLine
        else begin
            RecordRef.Field(Dummy.FieldNo(Address)).Value := AddressLine.Substring(1, Pos - 1);
            RecordRef.Field(Dummy.FieldNo("Address 2")).Value := AddressLine.Substring(Pos + 1).Replace(LineFeed, ' ');
        end;

        if Value[i] <> ',' then
            while (i + j < Strlen(Value)) and ((Value[i + j] <> ' ') or (Value[i + j + 1] in ['0' .. '9'])) do
                j += 1;
        // FieldRef := RecordRef.Field(Dummy.FieldNo("Post Code"));
        // FieldRef.Value := Value.Substring(i, j);
        RecordRef.Field(Dummy.FieldNo("Post Code")).Value := Value.Substring(i, j);

        i += j + 1;
        while Value[i] in [' ', '-', '_'] do
            i += 1;
        // FieldRef := RecordRef.Field(Dummy.FieldNo(City));
        // FieldRef.Value := CopyStr(Value, i, MaxStrLen(Dummy.City));
        RecordRef.Field(Dummy.FieldNo(City)).Value := CopyStr(Value.Substring(i), 1, MaxStrLen(Dummy.City));

        IsHandled := true;
    end;
}
