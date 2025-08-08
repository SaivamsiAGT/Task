report 80009 "Posted sales Invoice Report"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'posted sales report.rdl';

    dataset
    {
        dataitem("Sales Invoice Header"; "Sales Invoice Header")
        {
            column(compinfo1; companyinfo[1]) { }
            column(compinfo2; companyinfo[2]) { }
            column(compinfo3; companyinfo[3]) { }
            column(compinfo4; companyinfo[4]) { }
            column(picture_companyinfo; companyinformation.Picture) { }
            column(Subtotal; Subtotal) { }
            column(Tax; Tax) { }
            column(Total_USD; "Total USD") { }

            column(Invoice_No_; "No.") { }
            column(Sell_to_Customer_Name; "Sell-to Customer Name") { }
            column(Bill_to_Contact; "Bill-to Contact") { }
            column(Posting_Date; "Posting Date") { }
            column(Order_No_; "Order No.") { }
            column(Due_Date; "Due Date") { }
            column(Invoice_Discount_Amount; "Invoice Discount Amount") { }

            column(Ship_to_Name; "Ship-to Name") { }
            column(Ship_to_Address; "Ship-to Address") { }
            column(Ship_to_City; "Ship-to City") { }
            column(Ship_to_Country_Region_Code; "Ship-to Country/Region Code") { }
            column(Sell_to_Contact_No_; "Sell-to Contact No.") { }
            column(Bill_to_Customer_No_; "Bill-to Customer No.") { }


            dataitem("Sales Invoice Line"; "Sales Invoice Line")
            {
                DataItemLinkReference = "Sales Invoice Header";
                DataItemLink = "Document No." = field("No.");
                column(item_No_; "No.") { }
                column(Description; Description) { }
                column(Quantity; Quantity) { }
                column(Unit_Price; "Unit Price") { }
                column(Amount_Including_VAT; "Amount Including VAT") { }
                column(Line_Amount; "Line Amount") { }

                dataitem(Customer; Customer)
                {
                    DataItemLinkReference = "Sales Invoice Header";
                    DataItemLink = "No." = field("Bill-to Customer No.");
                    column(customer_Name; Name) { }
                    column(customer_Address; Address) { }
                    column(customer_City; City) { }
                    column(customer_Country_Region_Code; "Country/Region Code") { }
                    column(customer_Post_Code; "Post Code") { }

                }

            }
            trigger OnAfterGetRecord()
            begin
                "Sales Invoice Line".Reset();
                "Sales Invoice Line".SetRange("Document No.", "Sales Invoice Header"."No.");
                Subtotal := 0;
                Tax := 0;
                "Total USD" := 0;
                if "Sales Invoice Line".FindSet() then
                    repeat
                        subtotal += "Sales Invoice Line"."Line Amount";
                        Tax += "Sales Invoice Line"."Amount Including VAT" - "Sales Invoice Line"."Line Amount";
                    until "Sales Invoice Line".Next() = 0;
                "Total USD" := Subtotal + Tax - "Invoice Discount Amount";
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
    var
        companyinfo: Array[4] of Text;
        companyinformation: Record "Company Information";
        Subtotal: Decimal;
        Tax: Decimal;
        "Total USD": Decimal;

    trigger OnPreReport()
    begin
        companyinformation.Get();
        companyinformation.CalcFields(Picture);
        companyinfo[1] := companyinformation.Name;
        companyinfo[2] := companyinformation.Address;
        companyinfo[3] := companyinformation.City;
        companyinfo[4] := companyinformation."Country/Region Code";
        CompressArray(companyinfo);
    end;
}