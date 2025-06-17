codeunit 70101 CustomerMessageTrigger
{
    [EventSubscriber(ObjectType::Table, Database::Customer, 'OnAfterValidateEvent', 'E-Mail', false, false)]
    local procedure OnAfterEmailValidate(var Rec: Record Customer; xRec: Record Customer)
    begin
        if Rec."E-Mail" <> xRec."E-Mail" then
            Message('Email was entered sucessfully : %1', Rec."E-Mail");
    end;
}
