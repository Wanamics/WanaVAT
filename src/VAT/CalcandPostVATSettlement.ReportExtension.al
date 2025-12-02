namespace Wanamics.WanaVAT;

using Microsoft.Finance.VAT.Reporting;

reportextension 87040 "Calc. and Post VAT Settlement" extends "Calc. and Post VAT Settlement"
{
    rendering
    {
        layout(WanaVAT)
        {
            Type = Excel;
            LayoutFile = './ReportLayouts/CalcAndPostVATSettlement.xlsx';
            Caption = 'WanaVAT Settlement (Excel)';
            Summary = 'The WanaVAT Settlement (Excel) provides VAT entries details and totals by VAT Bus./Prod. posting groups.';
        }
    }
}
