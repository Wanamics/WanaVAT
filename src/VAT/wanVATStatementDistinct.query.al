namespace Wanamics.WanaVAT;

using Microsoft.Finance.VAT.Ledger;
query 87040 "wan VAT Statement Distinct"
{
    Caption = 'VAT Statement Distinct Posting';
    QueryType = Normal;

    elements
    {
        dataitem(VATEntry; "VAT Entry")
        {
            column(VATBusPostingGroup; "VAT Bus. Posting Group")
            {
            }
            column(VATProdPostingGroup; "VAT Prod. Posting Group")
            {
            }
            column("Type"; "Type")
            {
            }
            column(Count)
            {
                Method = Count;
            }
        }
    }
    trigger OnBeforeOpen()
    begin
    end;
}
