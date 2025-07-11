page 70336 "User Log Details List"
{
    PageType = List;
    SourceTable = "User Log Details";
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Entry No."; Rec."Entry No.") { ApplicationArea = All; }
                field("User ID"; Rec."User ID") { ApplicationArea = All; }
                field("Action DateTime"; Rec."Action DateTime") { ApplicationArea = All; }
                field("Action"; Rec."Action") { ApplicationArea = All; }
            }
        }
    }
}
