namespace Wanamics.WanaVAT;

using Microsoft.Finance.GeneralLedger.Posting;
using Microsoft.Finance.GeneralLedger.Journal;
using Microsoft.Finance.VAT.Ledger;
using Microsoft.Finance.VAT.Setup;
using Microsoft.Purchases.Document;
using Microsoft.Sales.Document;
using Microsoft.Finance.AllocationAccount.Purchase;
using Microsoft.Finance.AllocationAccount.Sales;
codeunit 87046 "WanaVAT Events"
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", OnBeforeInsertVAT, '', false, false)]
    local procedure OnBeforeInsertVAT(var GenJournalLine: Record "Gen. Journal Line"; var VATEntry: Record "VAT Entry"; var UnrealizedVAT: Boolean; var AddCurrencyCode: Code[10]; var VATPostingSetup: Record "VAT Posting Setup"; var GLEntryAmount: Decimal; var GLEntryVATAmount: Decimal; var GLEntryBaseAmount: Decimal; var SrcCurrCode: Code[10]; var SrcCurrGLEntryAmt: Decimal; var SrcCurrGLEntryVATAmt: Decimal; var SrcCurrGLEntryBaseAmt: Decimal)
    var
        MustBeCustomerOrVendorForUnrealizedVAT: Label 'must be Customer or Vendor for unrealized VAT';
    begin
        if (VATEntry."Unrealized Base" <> 0) and (VATEntry."Bill-to/Pay-to No." = '') then
            GenJournalLine.FieldError("Source Type", MustBeCustomerOrVendorForUnrealizedVAT);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales Alloc. Acc. Mgt.", OnBeforeVerifySalesLine, '', false, false)]
    local procedure OnBeforeVerifySalesLine(var SalesLine: Record "Sales Line")
    var
        Header: Record "Purchase Header";
    begin
        Header.Get(SalesLine."Document Type", SalesLine."Document No.");
        SalesLine."VAT Bus. Posting Group" := Header."VAT Bus. Posting Group";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purchase Alloc. Acc. Mgt.", OnBeforeVerifyPurchaseLine, '', false, false)]
    local procedure OnBeforeVerifyPurchaseLine(var PurchaseLine: Record "Purchase Line")
    var
        Header: Record "Purchase Header";
    begin
        Header.Get(PurchaseLine."Document Type", PurchaseLine."Document No.");
        PurchaseLine."VAT Bus. Posting Group" := Header."VAT Bus. Posting Group";
    end;

}