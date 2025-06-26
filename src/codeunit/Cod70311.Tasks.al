codeunit 70311 Tasks
{
    //Task -1

    // [EventSubscriber(ObjectType::Table, Database::Customer, 'OnAfterValidateEvent', 'E-Mail', false, false)]
    //     local procedure OnAfterEmailValidate(var Rec: Record Customer; xRec: Record Customer)
    //     begin
    //         if Rec."E-Mail" <> xRec."E-Mail" then
    //             Message('Email was entered sucessfully : %1', Rec."E-Mail");
    //     end;

    //Task - 2

    //      [EventSubscriber(ObjectType::Page, Page::"Sales Order", OnPostDocumentBeforeNavigateAfterPosting, '', true, true)]
    //     local procedure OnPostDocumentBeforeNavigateAfterPosting1(var SalesHeader: Record "Sales Header"; var PostingCodeunitID: Integer; var Navigate: Enum "Navigate After Posting"; DocumentIsPosted: Boolean; var IsHandled: Boolean)

    //     var
    //         Custledgerentry: record "Cust. Ledger Entry";
    //     begin
    //         Custledgerentry.Reset();
    //         Custledgerentry.SetRange("Customer No.", SalesHeader."Sell-to Customer No.");
    //         if Custledgerentry.FindLast() then begin
    //             Custledgerentry.Customer_Name_GEN := SalesHeader."Sell-to Customer Name";
    //             Custledgerentry.Modify();
    //         end;
    //     end;

    // Task -3
    //     [EventSubscriber(ObjectType::Table, Database::"Default Dimension", 'OnBeforeOnModify', '', true, true)]
    //     local procedure MyProcedure1(var DefaultDimension: Record "Default Dimension"; var DimensionManagement: Codeunit "DimensionManagement"; var IsHandled: Boolean)
    //     var
    //         employee: Record Employee;
    //     begin
    //         Message('Yes entered 1');
    //         Message('Default Dimension Table ID: %1, No.: %2', DefaultDimension."Table ID", DefaultDimension."No.");

    //         if employee.Get(DefaultDimension."No.") then begin
    //             employee.Custome_Dimension_code := DefaultDimension."Dimension Code";
    //             Message('Dimensions has been Modified Task-3 %1', DefaultDimension."Dimension Code");
    //         end
    //     end;

    //     [EventSubscriber(ObjectType::Table, Database::"Default Dimension", 'OnBeforeOnInsert', '', true, true)]
    //     local procedure MyProcedure2(var DefaultDimension: Record "Default Dimension"; var DimensionManagement: Codeunit "DimensionManagement"; var IsHandled: Boolean)
    //     var
    //         employee: Record Employee;
    //     begin
    //         Message('Yes entered 2');
    //         Message('Default Dimension Table ID: %1, No.: %2', DefaultDimension."Table ID", DefaultDimension."No.");
    //         if employee.Get(DefaultDimension."No.") then begin
    //             employee.Custome_Dimension_code := DefaultDimension."Dimension Code";
    //             employee.Modify();
    //             Message('Dimensions has been Modified Task-3 %1', DefaultDimension."Dimension Code");
    //         end
    //     end;

    //     [EventSubscriber(ObjectType::Table, Database::"Default Dimension", 'OnAfterInsertEvent', '', true, true)]
    //     local procedure MyProcedure3(var rec: Record "Default Dimension")
    //     var
    //         employee: Record Employee;
    //     begin
    //         Message('Yes entered 3');
    //         Message('Default Dimension Table ID: %1, No.: %2', Rec."Table ID", Rec."No.");
    //         if employee.Get(Rec."No.") then begin
    //             employee.Custome_Dimension_code := Rec."Dimension Code";
    //             employee.Modify();
    //             Message('Dimensions has been Modified Task-3 %1', rec."Dimension Code");
    //         end
    //     end;

    //Task - 4

    //  [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnInitRecordOnBeforeAssignShipmentDate', '', false, false)]
    //     local procedure HandleInitRecordOnBeforeAssignShipmentDate(var SalesHeader: Record "Sales Header"; var IsHandled: Boolean)
    //     begin
    //         SalesHeader."Shipment Date" := 0D;
    //         IsHandled := true;
    //     end;

    //Task - 5

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

    //Task -6

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

    //Task - 7
    // [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnBeforeInitDefaultDimensionSources', '', false, false)]
    // local procedure SetSalespersonDimensionByLoad(
    //   this is correct event for task 7



    //Task - 8

    // [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnBeforeInsertEvent', '', true, true)]
    // local procedure OnBeforeInsertSalesHeader(var Rec: Record "Sales Header"; RunTrigger: Boolean)
    // begin
    //     Message(' Entered OnBeforeInsertSalesHeader');
    //     Rec.CustomField_Task8 := Rec."Sell-to Customer Name" + ' Vamsi';
    // end;

    // [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnBeforeInsertGLEntry', '', true, true)]
    // local procedure OnBeforeInsertGlEntry(
    //     var GenJnlLine: Record "Gen. Journal Line";
    //     var GLEntry: Record "G/L Entry";
    //     var IsHandled: Boolean)
    // var
    //     SalesInvoiceHeader: Record "Sales Invoice Header";
    //     SalesHeader: Record "Sales Header";
    // begin
    //     Message('G/L Entry Event Triggered');

    //     if GLEntry."Document Type" = GLEntry."Document Type"::Invoice then begin
    //         if SalesInvoiceHeader.Get(GLEntry."Document No.") then begin
    //             if SalesInvoiceHeader."Order No." <> '' then begin
    //                 if SalesHeader.Get(SalesHeader."Document Type"::Order, SalesInvoiceHeader."Order No.") then begin
    //                     GLEntry."External Document No." := SalesHeader.CustomField_Task8;
    //                     Message('Copied from Sales Header: %1', SalesHeader.CustomField_Task8);
    //                 end else
    //                     Message('Order not found: %1', SalesInvoiceHeader."Order No.");
    //             end else
    //                 Message('No Order No. in Invoice: %1', GLEntry."Document No.");
    //         end else
    //             Message('Invoice not found: %1', GLEntry."Document No.");
    //     end;
    // end;

    // Task - 9
    // [EventSubscriber(ObjectType::Table, Database::"Vendor Ledger Entry", OnAfterInsertEvent, '', true, true)]
    // local procedure MyProcedure(var Rec: Record "Vendor Ledger Entry")
    // var
    //     PurchaseInvoiceHeader: Record "Purch. Inv. Header";
    //     PurchaseHeader: Record "Purchase Header";
    // begin
    //     if Rec."Document Type" = Rec."Document Type"::Invoice then begin
    //         if PurchaseInvoiceHeader.Get(Rec."Document No.") then begin
    //             if PurchaseInvoiceHeader."Order No." <> '' then begin
    //                 if PurchaseHeader.Get(PurchaseHeader."Document Type"::Order, PurchaseInvoiceHeader."Order No.") then begin
    //                     Message('Sucess %1', PurchaseHeader.Purchase_custome_field);
    //                     rec.vendor_custome_field := PurchaseHeader.Purchase_custome_field;
    //                     rec.modify(true);
    //                     Message('Sucess2 %1', rec.vendor_custome_field);
    //                 end
    //             end
    //         end
    //     end
    // end;

    // //Task - 9,10
    // [EventSubscriber(ObjectType::Table, Database::"Purchase Header", OnBeforeOnInsert, '', true, true)]
    // local procedure OnBeforeOnInsert1(var PurchaseHeader: Record "Purchase Header"; var IsHandled: Boolean)
    // begin

    //     PurchaseHeader.Purchase_custome_field := PurchaseHeader."Pay-to Name" + ' vamsi';
    //     Message('inserted   %1   sucess', PurchaseHeader.Purchase_custome_field);
    // end;


    //Task - 10  , Pending 

    // [EventSubscriber(ObjectType::Table, Database::"Item Ledger Entry", OnAfterInsertEvent, '', true, true)]
    // local procedure MyProcedure1(var Rec: Record "Item Ledger Entry")
    // var
    //     PurchaseLine: Record "Purchase Line";
    //     PurchaseHeader: Record "Purchase Header";
    // begin
    //     Message('Task 11 event triggered');
    //     Message('1  -    %1,', PurchaseLine."Document Type"::Invoice);
    //     Message('2   -   %1,', Rec."Document No.");

    //     //Rec."Document Type" = Rec."Document Type"::"Purchase Invoice" then begin
    //     PurchaseLine.SetRange("Document Type", PurchaseLine."Document Type"::Invoice);
    //     PurchaseLine.SetRange("Document No.", Rec."Document No.");
    //     // PurchaseLine.SetRange("Line No.", Rec."Order Line No.");


    //     if PurchaseLine.FindSet() then begin

    //         Message('3           -      %1,', PurchaseHeader."No.");
    //         if PurchaseHeader.Get(PurchaseLine."Document Type", PurchaseLine."Document No.") then begin
    //             Message(' Hello Vamsi Reddy! Found Purchase Header: %1', PurchaseHeader."No.");
    //         end else begin
    //             Message('Purchase Header not found');
    //         end;
    //     end else begin
    //         Message(' No matching Purchase Line found');
    //     end;
    // end;// else begin
    //     //     Message('Not a Purchase Invoice related Item Ledger Entry');
    //end;
    //  end;


    //  Task-11
    // [EventSubscriber(ObjectType::Codeunit, Codeunit::"Copy Item", OnAfterCopyItem, '', true, true)]
    // local procedure OnAfterCopyItem(var CopyItemBuffer: Record "Copy Item Buffer"; SourceItem: Record Item; var TargetItem: Record Item)
    // begin
    //     TargetItem.Description := SourceItem.Description + '@ copied item ';
    //     TargetItem.Modify(true);
    //     Message(SourceItem.Description);
    //     Message(TargetItem.Description);
    // end;

    //Task -12

    [EventSubscriber(ObjectType::Page, Page::"Sales Order Subform", OnAfterValidateEvent, "No.", true, true)]
    local procedure MyProcedure(var Rec: Record "Sales Line")
    var
        salesheader: Record "Sales Header";
    begin
        Message('Onaftervalideat event triggered');
        salesheader.SetRange("Document Type", salesheader."Document Type"::Order);
        SalesHeader.SetRange("No.", Rec."Document No.");
        if salesheader.FindFirst() then begin
            if salesheader.Delivery <> '' then begin
                Rec.Delivery := salesheader.Delivery;
                Message(rec.Delivery);
                rec.Modify(true);
            end
            else begin
                Message('No nothing is there');
            end;
        end;
    end;

    //Task -15
    // [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnAfterInsertEvent', '', true, true)]
    // local procedure SalesLine_OnAfterInsert(var Rec: Record "Sales Line")
    // begin
    //     Rec."MyCustomField_1" := 'vamsireddy';
    //     Rec."MyCustomField_2" := 'vamsireddy12';
    //     Rec.Modify();
    //     Message('1 - Modified sucessfully for taks 15');
    // end;
    // [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnBeforeSalesShptLineInsert', '', false, false)]
    // local procedure OnBeforeSalesShptLineInsertHandler(var SalesShptLine: Record "Sales Shipment Line"; SalesLine: Record "Sales Line"; CommitIsSuppressed: Boolean; var IsHandled: Boolean)
    // begin
    //     Message('2  Modified sucessfully for taks 15');
    //     SalesShptLine."MyCustomField1" := SalesLine."MyCustomField_1";
    //     SalesShptLine."MyCustomField2" := SalesLine."MyCustomField_2";
    // end;


}