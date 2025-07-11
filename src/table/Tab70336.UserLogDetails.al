table 70336 "User Log Details"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            DataClassification = SystemMetadata;
            AutoIncrement = true;
        }

        field(2; "User ID"; Code[50])
        {
            DataClassification = SystemMetadata;
        }

        field(3; "Action DateTime"; DateTime)
        {
            DataClassification = SystemMetadata;
        }

        field(4; "Action"; Option)
        {
            OptionMembers = Release,Reopen;
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
    }
}
