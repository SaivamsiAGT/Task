pageextension 70335 MyExtension5 extends "General Ledger Entries"
{
    layout
    {
        addafter("Entry No.")
        {
            field("Customer Name copied"; Rec."Customer Name copied")
            {
                ApplicationArea = all;
            }
        }
    }
}