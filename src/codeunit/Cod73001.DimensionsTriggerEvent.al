codeunit 73002 DimensionsTriggerEvent1
{
    [EventSubscriber(ObjectType::Table, Database::"Default Dimension", 'OnBeforeOnModify', '', true, true)]
    local procedure MyProcedure1(var DefaultDimension: Record "Default Dimension"; var DimensionManagement: Codeunit "DimensionManagement"; var IsHandled: Boolean)
    var
        employee: Record Employee;
    begin
        Message('Yes entered 1');
        Message('Default Dimension Table ID: %1, No.: %2', DefaultDimension."Table ID", DefaultDimension."No.");

        if employee.Get(DefaultDimension."No.") then begin
            employee.Custome_Dimension_code := DefaultDimension."Dimension Code";
            Message('Dimensions has been Modified Task-3 %1', DefaultDimension."Dimension Code");
        end
    end;

    [EventSubscriber(ObjectType::Table, Database::"Default Dimension", 'OnBeforeOnInsert', '', true, true)]
    local procedure MyProcedure2(var DefaultDimension: Record "Default Dimension"; var DimensionManagement: Codeunit "DimensionManagement"; var IsHandled: Boolean)
    var
        employee: Record Employee;
    begin
        Message('Yes entered 2');
        Message('Default Dimension Table ID: %1, No.: %2', DefaultDimension."Table ID", DefaultDimension."No.");
        if employee.Get(DefaultDimension."No.") then begin
            employee.Custome_Dimension_code := DefaultDimension."Dimension Code";
            employee.Modify();
            Message('Dimensions has been Modified Task-3 %1', DefaultDimension."Dimension Code");
        end
    end;

    [EventSubscriber(ObjectType::Table, Database::"Default Dimension", 'OnAfterInsertEvent', '', true, true)]
    local procedure MyProcedure3(var rec: Record "Default Dimension")
    var
        employee: Record Employee;
    begin
        Message('Yes entered 3');
        Message('Default Dimension Table ID: %1, No.: %2', Rec."Table ID", Rec."No.");
        if employee.Get(Rec."No.") then begin
            employee.Custome_Dimension_code := Rec."Dimension Code";
            employee.Modify();
            Message('Dimensions has been Modified Task-3 %1', rec."Dimension Code");
        end
    end;



}
