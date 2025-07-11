pageextension 70322 MyExtension extends "Posted Sales Shipment Lines"
{
    layout
    {
        addafter(Quantity)
        {
            field("Shipment Instruction"; Rec."Shipment Instruction")
            {
                ApplicationArea = all;
            }
            field("Sales Reference Code"; Rec."Sales Reference Code")
            {
                ApplicationArea = all;
            }
        }
    }


}