pageextension 70342 postedsales extends "Posted Sales Invoices"
{
    layout
    {
        addafter("Due Date")
        {
            field("Custom Ref"; Rec."Custom Ref")
            {
                ApplicationArea = all;
            }
        }
    }

}