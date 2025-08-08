report 80012 "Purchase Qty report"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'integer qty report.rdl';

    dataset
    {
        dataitem(Integer; Integer)
        {
            column(Number; Number) { }

            dataitem("Purchase Header"; "Purchase Header")
            {
                DataItemTableView = where("Document Type" = const(Order));

                column(Subtotal; Subtotal) { }
                column(Total_USD; "Total USD") { }
                column(Tax; Tax) { }
                column(compinfo1; companyinfo[1]) { }
                column(compinfo2; companyinfo[2]) { }
                column(compinfo3; companyinfo[3]) { }
                column(compinfo4; companyinfo[4]) { }
                column(picture_companyinfo; companyinformation.Picture) { }


                column(Purchase_No_; "No.") { }
                column(Buy_from_Vendor_No_; "Buy-from Vendor No.") { }
                column(Location_Code; "Location Code") { }
                column(Due_Date; "Due Date") { }
                column(Buy_from_Vendor_Name; "Buy-from Vendor Name") { }

                dataitem("Purchase Line"; "Purchase Line")
                {
                    DataItemLinkReference = "Purchase Header";
                    DataItemLink = "Document Type" = field("Document Type"), "Document No." = field("No.");

                    column(No_purchase; "No.") { }
                    column(Description; Description) { }
                    column(Quantity; Quantity) { }
                    column(Unit_of_Measure; "Unit of Measure") { }
                    column(Direct_Unit_Cost; "Direct Unit Cost") { }
                    column(Line_Amount; "Line Amount") { }
                    column(Inv__Discount_Amount; "Inv. Discount Amount") { }
                }

                trigger OnAfterGetRecord()
                begin
                    "Purchase Line".Reset();
                    "Purchase Line".SetRange("Document Type", "Purchase Header"."Document Type");
                    "Purchase Line".SetRange("Document No.", "Purchase Header"."No.");

                    Subtotal := 0;
                    "Total USD" := 0;

                    if "Purchase Line".FindSet() then
                        repeat
                            Subtotal += "Purchase Line"."Line Amount";
                        until "Purchase Line".Next() = 0;

                    "Total USD" := Subtotal - "Purchase Line"."Inv. Discount Amount";
                end;

                trigger OnPreDataItem()
                begin
                    if "Purchase Order No." <> '' then
                        SetRange("No.", "Purchase Order No.");
                end;
            }

            trigger OnPreDataItem()
            begin
                if nooflines = 0 then
                    Error('No quantity found for the selected Purchase Order.');

                SetRange(Number, 1, nooflines);
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
                    field("Purchase Order No."; "Purchase Order No.")
                    {
                        ApplicationArea = All;
                        TableRelation = "Purchase Header"."No." where("Document Type" = const(Order));
                    }
                }
            }
        }
    }

    var
        Subtotal: Decimal;
        Tax: Decimal;
        "Total USD": Decimal;
        "Sales Order No.": Code[40];
        check: Boolean;
        noofcopies: Integer;
        nooflines: Integer;
        "Purchase Order No.": Code[40];
        purchaseline: Record "Purchase Line";
        companyinfo: Array[4] of Text;
        companyinformation: Record "Company Information";


    trigger OnPreReport()
    begin

        purchaseline.Reset();
        purchaseline.SetRange("Document No.", "Purchase Order No.");
        nooflines := 0;

        if purchaseline.FindSet() then begin

            repeat
                nooflines += purchaseline.Quantity;
            until purchaseline.Next() = 0;
        end;
        companyinformation.Get();
        companyinformation.CalcFields(Picture);
        companyinfo[1] := companyinformation.Name;
        companyinfo[2] := companyinformation.Address;
        companyinfo[3] := companyinformation.City;
        companyinfo[4] := companyinformation."Country/Region Code";
        CompressArray(companyinfo);

    end;
}
