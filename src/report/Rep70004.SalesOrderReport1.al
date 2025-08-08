report 70004 "Sales Order Report1"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'SalesHeader.rdl';

    dataset
    {
        dataitem("Sales Header"; "Sales Header")
        {
            column(No_; "No.")
            {
            }
            column(Sell_to_Customer_Name; "Sell-to Customer Name") { }
            dataitem("Sales Line"; "Sales Line")
            {
                DataItemLink = "Document Type" = field("Document Type"), "Document No." = field("No.");
                DataItemLinkReference = "Sales Header";
                column(item_No_; "No.") { }
                column(Description; Description) { }
                column(Quantity; Quantity) { }
                trigger OnAfterGetRecord()
                var
                    myInt: Integer;
                begin
                    if Quantity = 0
                    then
                        CurrReport.Skip();
                end;
            }
            trigger OnPreDataItem()

            begin
                "Sales Header".SetFilter("No.", orderno);
            end;

            trigger OnAfterGetRecord()
            var
                myInt: Integer;
            begin
                "Sales Line".Reset();
                "Sales Line".SetRange("Document Type", "Sales Header"."Document Type");
                "Sales Line".SetRange("Document No.", "Sales Header"."No.");
                "Sales Line".SetFilter(Quantity, '<>0');
                if "Sales Line".Count = 0 then begin
                    CurrReport.Skip();
                end;
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
                    field(orderno; orderno)
                    {
                        TableRelation = "Sales Header"."No." where("Document Type" = const(Order));
                    }
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
        orderno: code[100];
}