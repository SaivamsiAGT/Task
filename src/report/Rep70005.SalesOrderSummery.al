report 70005 "Sales Order Summery"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'SalesOrdersummery.rdl';

    dataset
    {
        dataitem("Sales Header"; "Sales Header")
        {
            column(No_; "No.") { }
            column(Sell_to_Customer_Name; "Sell-to Customer Name") { }
            column(Total_Amount; "Total Amount") { }
            dataitem("Sales Line"; "Sales Line")
            {
                DataItemLink = "Document Type" = field("Document Type"), "Document No." = field("No.");
                column(item_No_; "No.") { }
                column(Description; Description) { }
                column(Quantity; Quantity) { }
                column(Amount; Amount) { }
                column(MyDate; MyDate) { }
                trigger OnAfterGetRecord()
                begin
                    if "Sales Line".Quantity = 0 then
                        CurrReport.Skip();
                end;
            }

            trigger OnAfterGetRecord()
            var
                myInt: Integer;
            begin
                "Sales Line".Reset();
                "Sales Line".SetRange("Document Type", "Sales Header"."Document Type"::Order);
                "Sales Line".SetRange("Document No.", "Sales Header"."No.");
                "Sales Line".SetFilter(Quantity, '<>0');
                if "Sales Line".Count = 0 then begin
                    CurrReport.Skip();
                end
                else
                    if "Sales Line".FindSet() then
                        repeat
                            "Total Amount" += "Sales Line"."Amount";
                        until "Sales Line".Next() = 0;
            end;
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

    trigger OnPreReport()
    begin
        MyDate := Today();
    end;

    var
        "Total Amount": Decimal;
        MyDate: Date;
}