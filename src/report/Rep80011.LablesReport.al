report 80011 "Lables Report"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'labels report.rdl';

    dataset
    {
        dataitem(Item; Item)
        {
            column(No_; "No.") { }
            column(Description; Description) { }
            column(Type; Type) { }
            column(Unit_Price; "Unit Price") { }
        }
    }

    requestpage
    {
        AboutTitle = 'Teaching tip title';
        AboutText = 'Teaching tip content';
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                }
            }
        }

        actions
        {
            area(processing)
            {
                action(LayoutName)
                {

                }
            }
        }
    }


}