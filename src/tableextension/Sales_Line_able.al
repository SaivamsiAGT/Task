tableextension 70320 Saleslinecustomefield extends "Sales Line"
{
    fields
    {
        field(500; MyCustomField_1; Text[80])
        {
            DataClassification = ToBeClassified;
        }
        field(501; MyCustomField_2; Text[80])
        {
            DataClassification = ToBeClassified;
        }
    }
}