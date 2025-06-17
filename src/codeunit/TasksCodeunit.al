codeunit 70311 Tasks
{
    [EventSubscriber(ObjectType::Table, Database::"Sales Shipment Header", 'OnAfterInsertEvent', '', true, true)]
    local procedure OnAfterSalesShipmentInserted(var Rec: Record "Sales Shipment Header")
    var
        SalesHeader: Record "Sales Header";
    begin
        Message('Posted Shipment Inserted: %1', Rec."No.");

        if SalesHeader.Get(SalesHeader."Document Type"::Order, Rec."Order No.") then begin
            SalesHeader."Last Shipment Date" := Rec."Posting Date";
            SalesHeader.Modify();
            Message('Last Shipment Date updated to %1', SalesHeader."Last Shipment Date");
        end;

    end;

}
