report 80016 "Sales order label"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'sales label.rdl';
    dataset
    {
        dataitem("Sales Header"; "Sales Header")
        {
            column(No_; "No.") { }
            column(Sell_to_Customer_No_; "Sell-to Customer No.") { }
            column(Order_Date; "Order Date") { }
            dataitem("Sales Line"; "Sales Line")
            {
                DataItemLink = "Document Type" = field("Document Type"), "Document No." = field("No.");
                column(item_No_; "No.") { }
                column(Description; Description) { }
                column(Quantity; Quantity) { }
                column(Shipment_Date; "Shipment Date") { }
                dataitem(Customer; Customer)
                {
                    DataItemLinkReference = "Sales Header";
                    DataItemLink = "No." = field("Sell-to Customer No.");
                    column(Name; Name) { }
                    column(Address; Address) { }
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