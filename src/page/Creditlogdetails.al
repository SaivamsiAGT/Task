table 70339 Creditlog
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; EntryNo; Integer)
        {
            DataClassification = ToBeClassified;
            Editable = false;
            AutoIncrement = true;
        }
        field(2; "old credit limit"; Decimal)
        {

        }
        field(3; "New credit limit"; Decimal)
        {

        }
        field(4; "User Name"; Code[85])
        {

        }
        field(5; "date and time"; DateTime)
        {

        }
    }

    keys
    {
        key(Key1; EntryNo)
        {
            Clustered = true;
        }
    }



}