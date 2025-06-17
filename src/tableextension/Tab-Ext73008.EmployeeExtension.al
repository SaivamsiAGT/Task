tableextension 73008 EmployeeExtension extends Employee
{
    fields
    {
        field(255; Custome_Dimension_code; Code[20])
        {

        }
    }

    trigger OnInsert()

    begin
        Message('Custome_Dimension_code has been inserted');
    end;
}