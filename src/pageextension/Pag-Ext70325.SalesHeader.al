pageextension 70325 SalesHeader extends "Sales Order"
{
    layout
    {
        addafter("Sell-to Address")
        {
            field(Delivery; Rec.Delivery)
            {

                ApplicationArea = all;
                Editable = IsEditableDelivery;
            }
        }
    }
    var
        IsEditableDelivery: Boolean;

    trigger OnAfterGetRecord()
    begin
        IsEditableDelivery := Rec.Status <> Rec.Status::Released;
    end;
}
