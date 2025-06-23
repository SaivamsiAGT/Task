pageextension 70322 MyExtension extends "Posted Sales Shipment Lines"
{
    layout
    {
        addafter(Quantity)
        {
            field(MyCustomField1; Rec.MyCustomField1)
            {
                ApplicationArea = all;
            }
            field(MyCustomField2; Rec.MyCustomField2)
            {
                ApplicationArea = all;
            }
        }
    }


}