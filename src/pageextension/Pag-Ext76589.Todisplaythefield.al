pageextension 76589 Todisplaythefield extends "Customer Ledger Entries"
{
    layout
    {
        addafter(Amount)
        {
            field(Customer_Name_GEN; Rec.Customer_Name_GEN)
            {
                ApplicationArea = all;
            }
        }
    }


}