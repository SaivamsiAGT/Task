pageextension 70327 PurchaseHeader extends "Purchase Order"
{
    layout
    {
        addafter("Posting Date")
        {
            field("Buyer Name"; Rec."Buyer Name")
            {
                ApplicationArea = all;
            }
        }
    }


}