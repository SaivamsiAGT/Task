report 70702 Report
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Customer Report';
    DefaultLayout = RDLC;
    RDLCLayout = './CustomerData.rdl';

    dataset
    {
        dataitem(Customer; Customer)
        {
            RequestFilterFields = "No.";
            column(No_; "No.")
            {

            }
            column(Name; Name)
            {
            }
            column(City; City)
            {

            }


            dataitem("Cust. Ledger Entry"; "Cust. Ledger Entry")
            {
                DataItemLink = "Customer No." = field("No.");
                DataItemLinkReference = Customer;
                DataItemTableView = sorting("Customer No.");
                column(Bal__Account_No_; "Bal. Account No.") { }
                column(Original_Amount; "Original Amount") { }
                column(Sales__LCY_; "Sales (LCY)") { }
                // trigger OnAfterGetRecord()
                // begin
                //     Message('OnafterGetRecord trigger');
                // end;

                // trigger OnPostDataItem()
                // begin
                //     Message('Onpostdataitem trigger');
                // end;

                // trigger OnPreDataItem()
                // begin
                //     Message('OnPredata trigger');
                // end;
            }
            trigger OnPreDataItem()
            begin
                if customernumber <> '' then
                    Customer.SetFilter("No.", '%1', customernumber);
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
                group(Options)
                {
                    field(YES_No; YES_No)
                    {
                        ApplicationArea = all;
                    }
                    field(customernumber; customernumber)
                    {
                        TableRelation = Customer."No.";
                        ApplicationArea = all;
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
        customernumber: code[100];
        YES_No: Boolean;

    trigger OnInitReport()
    var
        myInt: Integer;
    begin

    end;
}
