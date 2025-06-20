codeunit 70311 Tasks
{
    // [EventSubscriber(ObjectType::Table, Database::"Sales Shipment Header", 'OnAfterInsertEvent', '', true, true)]
    // local procedure OnAfterSalesShipmentInserted(var Rec: Record "Sales Shipment Header")
    // var
    //     SalesHeader: Record "Sales Header";
    // begin
    //     Message('Posted Shipment Inserted: %1', Rec."No.");

    //     if SalesHeader.Get(SalesHeader."Document Type"::Order, Rec."Order No.") then begin
    //         SalesHeader."Last Shipment Date" := Rec."Posting Date";
    //         SalesHeader.Modify();
    //         Message('Last Shipment Date updated to %1', SalesHeader."Last Shipment Date");
    //     end;
    // end;

    // [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post (Yes/No)", 'OnBeforeRunSalesPost', '', true, true)]
    // local procedure HandleBeforeRunSalesPost(var SalesHeader: Record "Sales Header"; var IsHandled: Boolean; var SuppressCommit: Boolean)
    // var
    //     salesline: Record "Sales Line";
    // begin
    //     Message('Posting is about to start the process: %1 , %2', SalesHeader."No.", SalesHeader."Document Type");
    //     salesline.Reset();
    //     salesline.SetRange("Document Type", SalesHeader."Document Type");
    //     salesline.SetRange("Document No.", SalesHeader."No.");
    //     if salesline.FindSet() then begin
    //         if salesline."No." = '1896-S' then
    //             Error('Posting is stopped for Document No. %1 with Item %2', SalesHeader."No.", salesline."No.");
    //         IsHandled := true;
    //     end;
    // end;




    // [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnBeforeInitDefaultDimensionSources', '', false, false)]
    // local procedure SetSalespersonDimensionByLoad(
    //   this is correct event for task 7




    //Task -15
    // [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnAfterInsertEvent', '', true, true)]
    // local procedure SalesLine_OnAfterInsert(var Rec: Record "Sales Line")
    // begin
    //     Rec."MyCustomField_1" := 'vamsireddy';
    //     Rec."MyCustomField_2" := 'vamsireddy12';
    //     Rec.Modify();
    //     Message('1 - Modified sucessfully for taks 15');
    // end;

    // Task -15
    // [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnBeforeSalesShptLineInsert', '', false, false)]
    // local procedure OnBeforeSalesShptLineInsertHandler(var SalesShptLine: Record "Sales Shipment Line"; SalesLine: Record "Sales Line"; CommitIsSuppressed: Boolean; var IsHandled: Boolean)
    // begin
    //     Message('2  Modified sucessfully for taks 15');
    //     SalesShptLine."MyCustomField1" := SalesLine."MyCustomField_1";
    //     SalesShptLine."MyCustomField2" := SalesLine."MyCustomField_2";
    // end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnBeforeInsertEvent', '', true, true)]
    local procedure OnBeforeInsertSalesHeader(var Rec: Record "Sales Header"; RunTrigger: Boolean)
    begin
        Message('💡 Entered OnBeforeInsertSalesHeader');
        Rec.CustomField_Task8 := Rec."Sell-to Customer Name" + ' Vamsi';
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnBeforeInsertGLEntry', '', true, true)]
    local procedure OnBeforeInsertGlEntry(
        var GenJnlLine: Record "Gen. Journal Line";
        var GLEntry: Record "G/L Entry";
        var IsHandled: Boolean)
    var
        SalesInvoiceHeader: Record "Sales Invoice Header";
        SalesHeader: Record "Sales Header";
    begin
        Message('G/L Entry Event Triggered');

        if GLEntry."Document Type" = GLEntry."Document Type"::Invoice then begin
            if SalesInvoiceHeader.Get(GLEntry."Document No.") then begin
                if SalesInvoiceHeader."Order No." <> '' then begin
                    if SalesHeader.Get(SalesHeader."Document Type"::Order, SalesInvoiceHeader."Order No.") then begin
                        GLEntry."External Document No." := SalesHeader.CustomField_Task8;
                        Message('Copied from Sales Header: %1', SalesHeader.CustomField_Task8);
                    end else
                        Message('Order not found: %1', SalesInvoiceHeader."Order No.");
                end else
                    Message('No Order No. in Invoice: %1', GLEntry."Document No.");
            end else
                Message('Invoice not found: %1', GLEntry."Document No.");
        end;
    end;
}

