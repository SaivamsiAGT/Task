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

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post (Yes/No)", 'OnBeforeRunSalesPost', '', true, true)]
    local procedure HandleBeforeRunSalesPost(var SalesHeader: Record "Sales Header"; var IsHandled: Boolean; var SuppressCommit: Boolean)
    var
        salesline: Record "Sales Line";
    begin
        Message('Posting is about to start the process: %1 , %2', SalesHeader."No.", SalesHeader."Document Type");
        salesline.Reset();
        salesline.SetRange("Document Type", SalesHeader."Document Type");
        salesline.SetRange("Document No.", SalesHeader."No.");
        if salesline.FindSet() then begin
            if salesline."No." = '1896-S' then
                Error('Posting is stopped for Document No. %1 with Item %2', SalesHeader."No.", salesline."No.");
            IsHandled := true;
        end;



    end;
}

