pageextension 70336 purchaseordersubform extends "Purchase Order Subform"
{
    layout
    {
        addafter(Quantity)
        {
            field("Requested By"; Rec."Requested By")
            {
                ApplicationArea = all;
            }
        }
    }


}