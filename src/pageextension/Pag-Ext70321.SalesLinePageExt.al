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
        }
    }


}
