pageextension 70321 SalesLinePageExt extends "Sales Order Subform"
{
    layout
    {
        addafter(Quantity)
        {
            field(Delivery; Rec.Delivery)
            {
                ApplicationArea = All;
            }
            field(PlannedShipmentDate; Rec.PlannedShipmentDate)
            {
                ApplicationArea = all;
            }
            field("Unit Cost (LCY) 1"; Rec."Unit Cost (LCY)")
            {
                ApplicationArea = all;
            }
        }
    }


}
