// codeunit 73010 MyShipmentDateSubscriber
// {
//     [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnInitRecordOnBeforeAssignShipmentDate', '', false, false)]
//     local procedure HandleInitRecordOnBeforeAssignShipmentDate(var SalesHeader: Record "Sales Header"; var IsHandled: Boolean)
//     begin
//         SalesHeader."Shipment Date" := 0D;
//         IsHandled := true;
//     end;
// }
