report 80010 "purchase order integer report"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'integer report.rdl';

    dataset
    {

        dataitem("Purchase Header"; "Purchase Header")
        {

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
            dataitem(Integer; Integer)
            {
                column(Number; Number) { }

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

                    dataitem(vendor1; vendor)
                    {
                        DataItemLink = "No." = field("Buy-from Vendor No.");
                        DataItemLinkReference = "Purchase Header";
                        column(Address; Address) { }
                        column(Contact; Contact) { }
                        column(City; City) { }
                        column(Post_Code; "Post Code") { }
                        dataitem("Country/Region"; "Country/Region")
                        {
                            DataItemLinkReference = vendor1;
                            DataItemLink = Code = field("Country/Region Code");
                            column(Name1; Name) { }
                            column(County_Name; "County Name") { }

                            dataitem(Location; Location)
                            {
                                DataItemLink = Code = field("Location Code");
                                DataItemLinkReference = "Purchase Header";
                                column(shiptoName; Name) { }
                            }
                        }
                    }
                }


                trigger OnPreDataItem()
                begin
                    "Purchase Line".Reset();
                    "Purchase Line".SetRange("Document Type", "Purchase Header"."Document Type");
                    "Purchase Line".SetRange("Document No.", "Purchase Header"."No.");
                    Subtotal := 0;
                    "Total USD" := 0;
                    nooflines := 0;
                    if "Purchase Line".FindSet() then
                        repeat
                            nooflines += "Purchase Line".Quantity;
                            subtotal += "Purchase Line"."Line Amount";
                        until "Purchase Line".Next() = 0;
                    "Total USD" := Subtotal - "Purchase Line"."Inv. Discount Amount";
                    if nooflines = 0 then begin
                        CurrReport.Skip();
                        SetRange(Number, 1, 0);
                    end
                    else begin
                        SetRange(Number, 1, 2);
                    end
                end;
            }
            trigger OnAfterGetRecord()
            begin
                //     "Purchase Line".Reset();
                //     "Purchase Line".SetRange("Document Type", "Purchase Header"."Document Type");
                //     "Purchase Line".SetRange("Document No.", "Purchase Header"."No.");
                //     Subtotal := 0;
                //     "Total USD" := 0;
                //     nooflines := 0;
                //     if "Purchase Line".FindSet() then
                //         repeat
                //             nooflines += "Purchase Line".Quantity;
                //             subtotal += "Purchase Line"."Line Amount";
                //         until "Purchase Line".Next() = 0;
                //     "Total USD" := Subtotal - "Purchase Line"."Inv. Discount Amount";
                //     SetRange(Number, 1, nooflines - 1);
                if nooflines = 0 then
                    CurrReport.Skip();
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
        "Sales Order No.": Code[40];
        check: Boolean;
        noofcopies: Integer;
        nooflines: Integer;

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