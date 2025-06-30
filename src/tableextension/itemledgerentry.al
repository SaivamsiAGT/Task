pageextension 70330 MyExtension3 extends "Item Ledger Entries"
{
    layout
    {
        addafter("Document Type")
        {
            field(Purchase_customefield; Rec.Purchase_customefield)
            {
                ApplicationArea = all;
            }
        }
    }



}