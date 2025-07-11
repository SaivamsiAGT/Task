tableextension 70318 SalesShipmentcustomefield extends "Sales Shipment Line"
{
    fields
    {
        field(72546; "Sales Reference Code"; Text[80])
        {
            DataClassification = ToBeClassified;
        }
        field(72547; "Shipment Instruction"; Text[80])
        {
            DataClassification = ToBeClassified;
        }
    }
}