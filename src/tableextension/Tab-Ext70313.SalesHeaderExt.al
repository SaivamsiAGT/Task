tableextension 70313 SalesHeaderExt extends "Sales Header"
{
    fields
    {
        field(708; "Last_Shipment_Date"; Date)
        {
            Caption = 'Last Shipment Date';
        }
        field(50100; LastInvoiceNo; Code[20])
        {
            Caption = 'Last Invoice No';
        }
        field(5089; Delivery; Code[20])
        {
            Caption = 'Delivery Mode';
        }
        field(50101; "Customer Name Copy"; Code[80])
        {
            DataClassification = CustomerContent;
        }

        field(72545; Customer_Name_sales; Text[80])
        {
            DataClassification = ToBeClassified;
        }
        field(72546; "Custom Ref"; Text[80])
        {
            DataClassification = ToBeClassified;
        }
        field(78945; "Total Amount"; Decimal)
        {

        }
    }
}
