report 80006 "Purchase Report Data"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'Parchase Report.rdl';
    dataset
    {
        dataitem("Purchase Header"; "Purchase Header")
        {
            column(No_; "No.") { }
            column(PageCaption; PageCaptionLbl) { }
            column(Buy_from_Vendor_No_; "Buy-from Vendor No.") { }
            column(Buy_from_Contact; "Buy-from Contact") { }
            column(Buy_from_Post_Code; "Buy-from Post Code") { }
            column(Vendor_Invoice_No_; "Vendor Invoice No.") { }
            column(Vendor_Order_No_; "Vendor Order No.") { }
            column(Order_Date; "Order Date") { }
            column(Invoice_Discount; "Invoice Discount Amount") { }

            dataitem("Purchase Line"; "Purchase Line")
            {
                DataItemLinkReference = "Purchase Header";
                DataItemLink = "Document Type" = field("Document Type"), "Document No." = field("No.");
                column(item_No_; "No.") { }
                column(Description; Description) { }
                column(Unit_of_Measure; "Unit of Measure") { }
                column(Quantity; Quantity) { }
                column(Direct_Unit_Cost; "Direct Unit Cost") { }
                column(Line_Amount; "Line Amount") { }

                dataitem(Vendor; Vendor)
                {
                    DataItemLinkReference = "Purchase Header";
                    DataItemLink = "No." = field("Buy-from Vendor No.");
                    column(vendor_Name; Name) { }
                    column(Contact; Contact) { }
                    column(Address; Address) { }
                    column(City; City) { }

                    dataitem("Country/Region"; "Country/Region")
                    {
                        DataItemLinkReference = "Purchase Header";
                        DataItemLink = Code = field("Buy-from Country/Region Code");
                        column(country_Name; Name) { }
                        column(picture_companyinformation; companyinformation.Picture) { }
                        column(company_name; companyinfo[1]) { }
                        column(company_address; companyinfo[2]) { }
                        column(company_satae; companyinfo[3]) { }
                        column(Tax; Tax) { }
                        column(Total_USD; "Total USD") { }
                        column(Subtotal; Subtotal) { }

                        dataitem(Location; Location)
                        {
                            DataItemLinkReference = "Purchase Header";
                            DataItemLink = Code = field("Location Code");
                            column(ship_Name; Name) { }
                            column(ship_Address; Address) { }
                            column(ship_City; City) { }
                            column(ship_Post_Code; "Post Code") { }
                        }
                    }
                }
            }

            trigger OnAfterGetRecord()
            var
                purchaseline: Record "Purchase Line";
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
                "Total USD" := Subtotal + "Purchase Header"."Invoice Discount Amount" + Tax;
            end;

            trigger OnPreDataItem()
            begin
                if ordernumber <> '' then begin
                    "Purchase Header".Reset();
                    "Purchase Header".SetRange("No.", ordernumber);
                end;

                if (startdate <> 0D) and (enddate <> 0D) then begin
                    "Purchase Header".Reset();
                    "Purchase Header".SetFilter("Order Date", '%1..%2', startDate, endDate);
                end
                else if (startdate <> 0D) and (enddate = 0D) then begin
                    "Purchase Header".Reset();
                    "Purchase Header".SetFilter("Order Date", '%1..%2', startDate, Today);
                end
                else if (startdate = 0D) and (enddate <> 0D) then begin
                    "Purchase Header".Reset();
                    "Purchase Header".SetFilter("Order Date", '..%2', enddate);
                end
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
                    field(ordernumber; ordernumber)
                    {
                        TableRelation = "Purchase Header"."No.";
                        ApplicationArea = all;
                    }
                    field(startdate; startdate)
                    {
                        ApplicationArea = all;
                    }
                    field(enddate; enddate)
                    {
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
        companyinformation: Record "Company Information";
        companyinfo: Array[4] of Text;
        Subtotal: Decimal;
        PageCaptionLbl: Label 'Page:';
        Tax: Decimal;
        "Total USD": Decimal;
        ordernumber: code[50];
        startdate: Date;
        enddate: Date;

    trigger OnPreReport()
    begin
        companyinformation.Get();
        companyinformation.CalcFields(Picture);
        companyinfo[1] := companyinformation.Name;
        companyinfo[2] := companyinformation.Address;
        companyinfo[3] := companyinformation."Country/Region Code";
        companyinfo[4] := companyinformation."E-Mail";
        CompressArray(companyinfo);
    end;
}