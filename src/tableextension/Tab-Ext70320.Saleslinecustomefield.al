tableextension 70320 Saleslinecustomefield extends "Sales Line"
{
    fields
    {
        field(500; "Sales Reference Code"; Text[80])
        {
            DataClassification = ToBeClassified;
        }
        field(501; "Shipment Instruction"; Text[80])
        {
            DataClassification = ToBeClassified;
        }
        field(5089; Delivery; code[20])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                SalesHeader: Record "Sales Header";
            begin
                SalesHeader.Get("Document Type", "Document No.");
                if SalesHeader.Status <> SalesHeader.Status::Open then
                    Error('The order must be open to modify Delivery.');
            end;
        }
        field(506; PlannedShipmentDate; Date)
        {

        }
    }
}