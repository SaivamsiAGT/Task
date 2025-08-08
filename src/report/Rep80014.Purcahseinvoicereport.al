report 80014 "Purcahse invoice report"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'Purcahse invoice report.rdl';

    dataset
    {
        dataitem("Purch. Rcpt. Header"; "Purch. Rcpt. Header")
        {
            column(No_; "No.") { }
            column(purchase_Order_No_; "Order No.") { }
            column(Posting_Date; "Posting Date") { }
            dataitem("Purch. Rcpt. Line"; "Purch. Rcpt. Line")
            {
                DataItemLinkReference = "Purch. Rcpt. Header";
                DataItemLink = "Document No." = field("No.");
                column(item_No_; "No.") { }
                column(Description; Description) { }
                column(Quantity; Quantity) { }
                dataitem(Vendor; Vendor)
                {
                    DataItemLinkReference = "Purch. Rcpt. Header";
                    DataItemLink = "No." = field("Buy-from Vendor No.");
                    column(vendor_Name; Name) { }
                }
            }

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
    var
        myInt: Integer;
}