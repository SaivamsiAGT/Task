report 80002 "Purchase Order Report1"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'Purchase_Order_Report.rdl';

    dataset
    {

        dataitem("Purchase Header"; "Purchase Header")
        {
            column(Subtotal; Subtotal) { }
            column(Total_USD; "Total USD") { }

            column(No_; "No.") { }
            column(Buy_from_Vendor_No_; "Buy-from Vendor No.") { }
            column(Location_Code; "Location Code") { }
            column(Due_Date; "Due Date") { }
            column(Buy_from_Vendor_Name; "Buy-from Vendor Name") { }


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
                    DataItemLink = Code = field("Country/Region Code");
                    DataItemLinkReference = vendor1;
                    column(Name1; Name) { }
                    column(County_Name; "County Name") { }
                    column(compinfo1; comparray[1]) { }
                    column(compinfo2; comparray[2]) { }
                    column(compinfo3; comparray[3]) { }
                    column(compinfo4; comparray[4]) { }
                    column(companyinfo; companyinfo.Picture) { }
                    dataitem(Location; Location)
                    {
                        DataItemLink = Code = field("Location Code");
                        DataItemLinkReference = "Purchase Header";
                        column(shiptoName; Name) { }
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

                        }

                    }
                }
            }
            trigger OnPreDataItem()
            begin
                "Purchase Header".SetFilter("No.", purchaseOrderNo);
            end;

            trigger OnAfterGetRecord()
            begin
                "Purchase Line".Reset();
                "Purchase Line".SetRange("Document Type", "Purchase Header"."Document Type");
                "Purchase Line".SetRange("Document No.", "Purchase Header"."No.");

                if "Purchase Line".FindSet() then
                    repeat
                        subtotal += "Purchase Line"."Line Amount";
                    until "Purchase Line".Next() = 0;
            end;

        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(Filter)
                {
                    field(purchaseOrderNo; purchaseOrderNo)
                    {
                        ApplicationArea = All;
                        TableRelation = "Purchase Header"."No." where("Document Type" = const(Order));
                    }
                }
            }
        }
    }

    var
        purchaseOrderNo: Code[20];
        purchaseline: Record "Purchase Line";
        companyinfo: Record "Company Information";
        comparray: array[4] of Text;
        Subtotal: Decimal;
        "Total USD": Decimal;

    trigger OnPreReport()
    var
        myInt: Integer;
    begin
        companyinfo.Get();
        companyinfo.CalcFields(Picture);
        companyarray();
    end;

    procedure companyarray()
    var
        myInt: Integer;
    begin
        comparray[1] := companyinfo.Name;
        comparray[2] := companyinfo.Address;
        comparray[3] := companyinfo."Address 2";
        comparray[4] := companyinfo.City + ' ' + companyinfo.County + ' ' + companyinfo."Post Code";
        CompressArray(comparray);

    end;
}
