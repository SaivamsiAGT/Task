report 80007 "Sales Order Report"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'Sales Order report.rdl';


    dataset
    {
        dataitem("Sales Header"; "Sales Header")
        {
            column(Order_No_; "No.") { }
            column(Sell_to_City; "Sell-to City") { }
            column(Sell_to_Country_Region_Code; "Sell-to Country/Region Code") { }
            column(Ship_to_Address; "Ship-to Address") { }
            column(Ship_to_Code; "Ship-to Code") { }
            column(Ship_to_Contact; "Ship-to Contact") { }
            column(Prepmt__Payment_Terms_Code; "Prepmt. Payment Terms Code") { }
            column(Bill_to_County; "Bill-to County") { }

            column(picture_companyinformation; companyinformation.Picture) { }
            column(companyName; companyinfo[1]) { }
            column(companyAddress; companyinfo[2]) { }
            column(companyCountry; companyinfo[3]) { }
            column(companyE_Mail; companyinfo[4]) { }

            dataitem(Customer; Customer)
            {
                DataItemLinkReference = "Sales Header";
                DataItemLink = "No." = field("Sell-to Customer No.");
                column(customer_Name; Name) { }
                column(Address; Address) { }

                dataitem("Sales Line"; "Sales Line")
                {
                    DataItemLinkReference = "Sales Header";
                    DataItemLink = "Document Type" = field("Document Type"), "Document No." = field("No.");
                    column(No_; "No.") { }
                    column(Description; Description) { }
                    column(Quantity; Quantity) { }
                    column(Unit_of_Measure; "Unit of Measure") { }
                    column(Unit_Cost; "Unit Cost") { }
                    column(Line_Amount; "Line Amount") { }
                    column(Subtotal; Subtotal) { }
                    column(Tax; Tax) { }
                    column(Total_USD; "Total USD") { }
                    column(Inv__Discount_Amount; "Inv. Discount Amount") { }
                    dataitem("Payment Terms"; "Payment Terms")
                    {
                        DataItemLinkReference = "Sales Header";
                        DataItemLink = Code = field("Prepmt. Payment Terms Code");
                        column(payment_Description; Description) { }
                    }

                    trigger OnAfterGetRecord()
                    begin
                        if "Sales Line".Quantity = 0 then
                            CurrReport.Skip();
                    end;

                }
            }
            trigger OnAfterGetRecord()
            var
                salesline: Record "Sales Line";
            begin
                "Sales Line".Reset();
                "Sales Line".SetRange("Document Type", "Sales Header"."Document Type");
                "Sales Line".SetRange("Document No.", "Sales Header"."No.");
                "Sales Line".SetRange(type, "Sales Line".Type::Item);
                "Sales Line".SetFilter(Quantity, '<>0');
                Subtotal := 0;
                "Total USD" := 0;
                check := false;
                Tax := 0;
                if "Sales Line".FindSet() then
                    check := true;
                repeat
                    Subtotal += "Sales Line"."Line Amount";
                    if "Sales Line"."VAT %" <> 0 then
                        Tax += "Sales Line"."Line Amount" * ("Sales Line"."VAT %" / 100);
                until "Sales Line".Next() = 0;
                "Total USD" := Subtotal - "Sales Line"."Inv. Discount Amount" + Tax;
                if check = false then begin
                    CurrReport.Skip();
                end;
            end;

            trigger OnPreDataItem()

            begin
                if "Sales Order No." <> '' then
                    "Sales Header".Reset();
                "Sales Header".SetFilter("No.", "Sales Order No.");
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
                group(Filter)
                {
                    field("Sales Order No."; "Sales Order No.")
                    {
                        TableRelation = "Sales Header"."No." WHERE("Document Type" = CONST(Order));
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
        companyinfo: Array[4] of Text;
        companyinformation: Record "Company Information";
        Subtotal: Decimal;
        Tax: Decimal;
        "Total USD": Decimal;
        "Sales Order No.": Code[40];
        check: Boolean;

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