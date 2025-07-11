page 70340 CreditlogList
{
    PageType = List;
    SourceTable = Creditlog;
    ApplicationArea = All;
    UsageCategory = Lists;
    Caption = 'Credit Limit Change Log';

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(EntryNo; Rec.EntryNo) { ApplicationArea = All; }
                field("old credit limit"; Rec."old credit limit") { ApplicationArea = All; }
                field("New credit limit"; Rec."New credit limit") { ApplicationArea = All; }
                field("User Name"; Rec."User Name") { ApplicationArea = All; }
                field("date and time"; Rec."date and time") { ApplicationArea = All; }
            }
        }
    }
}
