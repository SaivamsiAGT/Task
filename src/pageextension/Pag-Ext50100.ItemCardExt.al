pageextension 50100 ItemCardExt extends "Item Card"
{
    layout
    {
        addafter("Cost Details")
        {
            field("Last Sales Price"; Rec."Last Sales Price") { ApplicationArea = All; }
            field("Last Purchase Price"; Rec."Last Purchase Price") { ApplicationArea = All; }
        }
    }
}
