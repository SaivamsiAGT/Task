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
    }
}
