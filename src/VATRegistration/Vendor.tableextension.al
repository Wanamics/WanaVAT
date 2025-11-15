namespace Wanamics.WanaVAT;

using Microsoft.Purchases.Vendor;
using Microsoft.Foundation.Address;
tableextension 87041 Vendor extends Vendor
{
    fields
    {
        modify("VAT Registration No.")
        {
            trigger OnBeforeValidate()
            var
                CountryRegion: Record "Country/Region";
            begin
                if (Rec."VAT Registration No." = '') or (Rec."Country/Region Code" <> '') then
                    exit;
                CountryRegion.SetCurrentKey("Intrastat Code");
                CountryRegion.SetRange("EU Country/Region Code", CopyStr(Rec."VAT Registration No.", 1, 2));
                if CountryRegion.FindFirst then
                    Rec.Validate("Country/Region Code", CountryRegion.Code);
            end;
        }
    }
}
