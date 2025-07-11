codeunit 70311 Tasks
{
    //Task -1

    // [EventSubscriber(ObjectType::Table, Database::Customer, 'OnAfterValidateEvent', 'Name', false, false)]
    // local procedure OnAfterEmailValidate(var Rec: Record Customer; xRec: Record Customer)
    // begin
    //     if Rec.Name <> xRec.Name then
    //         Message('Name was entered sucessfully : %1', Rec.Name);
    // end;

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

    // //Task -6

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
    //         IsHandled := true; //try to stop before the posting only
    //     end;
    // end;

    // //  Task - 7
    // [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnAfterInitDefaultDimensionSources', '', false, false)]
    // local procedure OnAfterInitDefaultDimensionSources(
    //  var SalesHeader: Record "Sales Header";
    //  var DefaultDimSource: List of [Dictionary of [Integer, Code[20]]];
    //  FieldNo: Integer)
    // var
    //     Salesperson: Record "Salesperson/Purchaser";
    //     SalesInvoiceHeader: Record "Sales Invoice Header";
    //     SalesHeaderTemp: Record "Sales Header";
    //     CalcDimension: Dictionary of [Code[20], Integer];
    //     Key1: Code[20];
    //     Value: Integer;
    //     CurrCount: Integer;
    //     MinValue: Integer;
    //     SelectedPerson: Code[20];
    // begin
    //     if Salesperson.FindSet() then
    //         repeat
    //             CurrCount := 0;
    //             SalesHeaderTemp.Reset();
    //             SalesHeaderTemp.SetRange("Salesperson Code", Salesperson.Code);
    //             CurrCount += SalesHeaderTemp.Count();
    //             SalesInvoiceHeader.Reset();
    //             SalesInvoiceHeader.SetRange("Salesperson Code", Salesperson.Code);
    //             CurrCount += SalesInvoiceHeader.Count();
    //             CalcDimension.Add(Salesperson.Code, CurrCount);
    //         until Salesperson.Next() = 0;
    //     MinValue := 9999999;
    //     foreach Key1 in CalcDimension.Keys do begin
    //         Value := CalcDimension.Get(Key1);
    //         if Value < MinValue then begin
    //             MinValue := Value;
    //             SelectedPerson := Key1;
    //         end;
    //     end; //sr-01072025++
    //     Message('Least loaded Salesperson: %1 with %2 total docs', SelectedPerson, MinValue);
    //     SalesHeader."Salesperson Code" := SelectedPerson;
    //     //sr-01072025-- //version tags
    // end;




    // //Task - 8

    // [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnBeforeInsertEvent', '', true, true)]
    // local procedure OnBeforeInsertSalesHeader(var Rec: Record "Sales Header"; RunTrigger: Boolean)
    // begin
    //     Message(' Entered OnBeforeInsertSalesHeader');
    //     Rec."Customer Name Copy" := Rec."Sell-to Customer Name" + '@copied'; //custome field
    // end;
    // //try to do in single event

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

    //     if GLEntry."Document Type" = GLEntry."Document Type"::Invoice then begin //try to remove the filter of invoice
    //         if SalesInvoiceHeader.Get(GLEntry."Document No.") then begin
    //             if SalesInvoiceHeader."Order No." <> '' then begin
    //                 if SalesHeader.Get(SalesHeader."Document Type"::Order, SalesInvoiceHeader."Order No.") then begin
    //                     GLEntry."Customer Name copied" := SalesHeader."Customer Name Copy";
    //                     Message('Copied from Sales Header: %1', SalesHeader."Customer Name Copy");
    //                 end else
    //                     Message('Order not found: %1', SalesInvoiceHeader."Order No.");
    //             end else
    //                 Message('No Order No. in Invoice: %1', GLEntry."Document No.");
    //         end else
    //             Message('Invoice not found: %1', GLEntry."Document No.");
    //     end;
    // end;

    // // Task - 9
    // [EventSubscriber(ObjectType::Table, Database::"Vendor Ledger Entry", OnAfterInsertEvent, '', true, true)]
    // local procedure MyProcedure(var Rec: Record "Vendor Ledger Entry")
    // var
    //     PurchaseInvoiceHeader: Record "Purch. Inv. Header";
    //     PurchaseHeader: Record "Purchase Header";
    // begin
    //     if Rec."Document Type" = Rec."Document Type"::Invoice then begin //just check without this extra condition
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
    //     Message('inserted   %1   sucess', PurchaseHeader.Purchase_custome_field);  //take value from ui and custome field
    // end;


    // // //Task - 10  

    // [EventSubscriber(ObjectType::Table, Database::"Item Ledger Entry", OnBeforeInsertEvent, '', true, true)]
    // local procedure OnAfterInsertILE(var Rec: Record "Item Ledger Entry")
    // var
    //     PurchRcptHeader: Record "Purch. Rcpt. Header";
    //     PurchHeader: Record "Purchase Header";
    // begin
    //     if Rec."Document Type" = Rec."Document Type"::"Purchase Receipt" then begin
    //         if PurchRcptHeader.Get(Rec."Document No.") then begin
    //             if PurchHeader.Get(PurchHeader."Document Type"::Order, PurchRcptHeader."Order No.") then begin
    //                 Rec.Purchase_customefield := PurchHeader.Purchase_custome_field;

    //             end;
    //         end
    //     end
    // end;


    // // //  Task-11
    // [EventSubscriber(ObjectType::Codeunit, Codeunit::"Copy Item", OnAfterCopyItem, '', true, true)]
    // local procedure OnAfterCopyItem(var CopyItemBuffer: Record "Copy Item Buffer"; SourceItem: Record Item; var TargetItem: Record Item)
    // begin
    //     TargetItem.Description := SourceItem.Description + '@ copied item ';
    //     TargetItem.Modify(true);
    //     Message(SourceItem.Description);
    //     Message(TargetItem.Description);
    // end;

    // //Task -12

    // [EventSubscriber(ObjectType::Page, Page::"Sales Order Subform", OnAfterValidateEvent, "No.", true, true)]
    // local procedure MyProcedures(var Rec: Record "Sales Line")
    // var
    //     salesheader: Record "Sales Header";
    // begin
    //     Message('Onaftervalideat event triggered');
    //     salesheader.Reset();
    //     salesheader.SetRange("Document Type", salesheader."Document Type"::Order);
    //     SalesHeader.SetRange("No.", Rec."Document No.");
    //     if salesheader.FindFirst() then begin
    //         if salesheader.Delivery <> '' then begin
    //             Rec.Delivery := salesheader.Delivery;
    //             Message(rec.Delivery);
    //             rec.Modify(true);
    //         end
    //         else begin
    //             Message('No nothing is there');
    //         end;
    //     end;
    // end;

    // //Task -13

    // [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", OnBeforeInsertInvoiceHeader, '', true, true)]
    // local procedure OnBeforeInsertInvoiceHeader(SalesHeader: Record "Sales Header"; var SalesInvHeader: Record "Sales Invoice Header"; var IsHandled: Boolean)
    // var
    //     customer: Record Customer;
    //     custLedgerEntry: Record "Cust. Ledger Entry";
    //     permission: Record "Access Control";
    //     count: Integer;
    //     currentUserSecurityId: Guid;
    // begin
    //     customer.GET(SalesHeader."Sell-to Customer No.");
    //     customer.CalcFields("Balance Due (LCY)");

    //     custLedgerEntry.Reset();
    //     custLedgerEntry.SetRange("Customer No.", customer."No.");
    //     custLedgerEntry.SetRange("Document Type", custLedgerEntry."Document Type"::Invoice);
    //     custLedgerEntry.SetRange(Open, true);
    //     custLedgerEntry.SetFilter("Due Date", '<%1', Today);
    // //     if custLedgerEntry.FindSet() then
    // //         repeat
    // //             count += 1;
    // //         until custLedgerEntry.Next() = 0;


    //     if (customer."Balance Due (LCY)" > 10000) or (custLedgerEntry.Count() > 3) then begin
    //         if not Confirm('This customer has an overdue balance of ₹%1 and %2 overdue invoices. Do you want to continue?', false, customer."Balance Due (LCY)", count) then
    //             Error('Posting cancelled by user.');

    //         currentUserSecurityId := UserSecurityId();


    //         permission.Reset();
    //         permission.SetRange("User Security ID", currentUserSecurityId);
    //         permission.SetRange("Role ID", 'SUPER');
    //         if not permission.FindFirst() then
    //             Error('Only users with SUPER permission can override this block.');
    //     end;
    // end;


    // //Task -14
    // [EventSubscriber(ObjectType::Page, Page::"Sales Order Subform", OnAfterValidateEvent, PlannedShipmentDate, true, true)]
    // local procedure OnAfterValidate_PlannedShipmentDates(var Rec: Record "Sales Line")
    // begin
    //     // Check if the PlannedShipmentDate field has a value
    //     if Rec.PlannedShipmentDate <> 0D then begin
    //         // Set Shipment Date to PlannedShipmentDate - 2 days
    //         Rec."Shipment Date" := Rec.PlannedShipmentDate - 2;
    //         Rec.Modify(true);
    //     end;
    // end;


    // //Task -15
    // [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnAfterInsertEvent', '', true, true)]
    // local procedure SalesLine_OnAfterInsert(var Rec: Record "Sales Line")
    // begin
    //     Rec."Sales Reference Code" := 'DefaultRefCode';
    //     Rec."Shipment Instruction" := 'Standard Instructions';
    //     Rec.Modify();
    //     Message('1 - Modified sucessfully for taks 15');
    // end;

    // [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnBeforeSalesShptLineInsert', '', false, false)]
    // local procedure OnBeforeSalesShptLineInsertHandler(var SalesShptLine: Record "Sales Shipment Line"; SalesLine: Record "Sales Line"; CommitIsSuppressed: Boolean; var IsHandled: Boolean)
    // begin
    //     Message('2  Modified sucessfully for taks 15');
    //     SalesShptLine."Sales Reference Code" := SalesLine."Sales Reference Code";
    //     SalesShptLine."Shipment Instruction" := SalesLine."Shipment Instruction";
    // end;

    // // task 16

    // [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post (Yes/No)", 'OnBeforeRunSalesPost', '', true, true)]
    // local procedure HandleBeforeRunSalesPosts(var SalesHeader: Record "Sales Header"; var IsHandled: Boolean)
    // var
    //     DocumentAttachment: Record "Document Attachment";
    // begin
    //     DocumentAttachment.Reset();
    //     DocumentAttachment.SetRange("Table ID", Database::"Sales Header");
    //     DocumentAttachment.SetRange("No.", SalesHeader."No.");
    //     DocumentAttachment.SetRange("Document Type", SalesHeader."Document Type");
    //     if DocumentAttachment.FindFirst() <> true then begin
    //         Error('Sorry you cannot post this order as there is no attachment');
    //         IsHandled := true;
    //     end;
    // end;

    // [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Sales Document", OnBeforeReleaseSalesDoc, '', true, true)]
    // local procedure OnBeforeReleaseSalesDoc(var SalesHeader: Record "Sales Header"; PreviewMode: Boolean; var IsHandled: Boolean; var SkipCheckReleaseRestrictions: Boolean; SkipWhseRequestOperations: Boolean)
    // var
    //     DocumentAttachment: Record "Document Attachment";
    // begin
    //     DocumentAttachment.Reset();
    //     DocumentAttachment.SetRange("Table ID", Database::"Sales Header");
    //     DocumentAttachment.SetRange("No.", SalesHeader."No.");
    //     DocumentAttachment.SetRange("Document Type", SalesHeader."Document Type");
    //     //DocumentAttachment.SetFilter("No.", SalesHeader."No.");
    //     if DocumentAttachment.FindFirst() <> true then begin
    //         Error('Sorry you cannot Release this order as there is no attachment');
    //         IsHandled := true;
    //     end;
    // end;

    //Event-17

    [EventSubscriber(ObjectType::Page, Page::"Sales Order Subform", OnAfterValidateEvent, 'Quantity', true, true)]
    local procedure AutoAdjustItemInventory(var Rec: Record "Sales Line")
    var
        ItemLedgerEntry: Record "Item Ledger Entry";
        ItemJnlLine: Record "Item Journal Line";
        ItemJnlPostLine: Codeunit "Item Jnl.-Post Line";
        TotalQty: Decimal;
        QtyToAdjust: Decimal;
        LineNo: Integer;
    begin
        // Exit if not an item line
        if Rec.Type <> Rec.Type::Item then
            exit;

        // Calculate total available quantity in that location
        ItemLedgerEntry.Reset();
        ItemLedgerEntry.SetRange("Item No.", Rec."No.");
        ItemLedgerEntry.SetRange("Location Code", Rec."Location Code");
        if ItemLedgerEntry.FindSet() then
            repeat
                TotalQty += ItemLedgerEntry.Quantity;
            until ItemLedgerEntry.Next() = 0;

        // If not enough quantity, do a Positive Adjustment
        if Rec.Quantity > TotalQty then begin
            QtyToAdjust := Rec.Quantity - TotalQty;

            Message('Inventory shortfall detected: Required = %1, Available = %2. Adjusting %3.',
                Rec.Quantity, TotalQty, QtyToAdjust);

            ItemJnlLine.Init();
            ItemJnlLine."Journal Template Name" := 'ITEM';
            ItemJnlLine."Journal Batch Name" := 'DEFAULT';
            LineNo := ItemJnlLine."Line No." + 10000;
            ItemJnlLine."Line No." := LineNo;
            ItemJnlLine.Validate("Posting Date", Today);
            ItemJnlLine.Validate("Entry Type", ItemJnlLine."Entry Type"::"Positive Adjmt.");
            ItemJnlLine.Validate("Document No.", 'AUTOADJ' + Format(Today, 0, 9));
            ItemJnlLine.Validate("Item No.", Rec."No.");
            ItemJnlLine.Validate("Location Code", Rec."Location Code");
            ItemJnlLine.Validate("Unit of Measure Code", Rec."Unit of Measure Code");
            ItemJnlLine.Validate(Quantity, QtyToAdjust);
            ItemJnlLine.Insert(true);
            ItemJnlPostLine.RunWithCheck(ItemJnlLine);
            Message('Inventory adjusted by %1 units for item %2.', QtyToAdjust, Rec."No.");
        end;
    end;

    // // Task -18

    // [EventSubscriber(ObjectType::Page, Page::"Sales Order Subform", OnAfterValidateEvent, "Location Code", true, true)]
    // local procedure OnAfterValidate_PlannedShipmentDate(var Rec: Record "Sales Line")
    // begin
    //     Message('yes location code');
    // end;

    // [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Sales Document", OnBeforeReleaseSalesDoc, '', true, true)]
    // local procedure OnBeforeRunReleaseSalesDoc(var SalesHeader: Record "Sales Header")
    // var
    //     UserLog: Record "User Log Details";
    // begin
    //     UserLog.Init();
    //     UserLog."User ID" := UserId;
    //     UserLog."Action DateTime" := CurrentDateTime;
    //     UserLog."Action" := UserLog.Action::Release;
    //     UserLog.Insert();
    // end;

    // [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Sales Document", OnBeforeReopenSalesDoc, '', true, true)]
    // local procedure OnBeforeReopenSalesDoc(var SalesHeader: Record "Sales Header")
    // var
    //     UserLog: Record "User Log Details";
    // begin
    //     UserLog.Init();
    //     UserLog."User ID" := UserId;
    //     UserLog."Action DateTime" := CurrentDateTime;
    //     UserLog."Action" := UserLog.Action::Reopen;
    //     UserLog.Insert();
    // end;

    //Task-19

    // [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnAfterValidateEvent', 'Quantity', true, true)]
    // local procedure InsertManualReservation(var rec: Record "Sales Line"; xrec: Record "Sales Line")
    // var
    //     ReservEntry: Record "Reservation Entry";
    //     Item: Record Item;
    //     EntryNo: Integer;
    // begin
    //     EntryNo := ReservEntry.GetLastEntryNo() + 1;
    //     ReservEntry.Init();
    //     ReservEntry."Entry No." := EntryNo;
    //     ReservEntry."Item No." := rec."No.";
    //     ReservEntry."Location Code" := rec."Location Code";
    //     ReservEntry."Quantity (Base)" := rec."Quantity (Base)";
    //     ReservEntry."Reservation Status" := ReservEntry."Reservation Status"::Surplus;
    //     ReservEntry.Description := rec.Description;
    //     ReservEntry."Creation Date" := Today;
    //     ReservEntry."Source Type" := DATABASE::"Sales Line";
    //     ReservEntry."Source Subtype" := rec."Document Type";
    //     ReservEntry."Source ID" := rec."Document No.";
    //     ReservEntry."Source Ref. No." := rec."Line No.";
    //     ReservEntry."Shipment Date" := rec."Shipment Date";
    //     ReservEntry."Qty. per Unit of Measure" := rec."Qty. per Unit of Measure";
    //     ReservEntry."Quantity" := -1;
    //     ReservEntry."Qty. to Handle (Base)" := -1;
    //     ReservEntry."Qty. to Invoice (Base)" := -1;
    //     ReservEntry."Variant Code" := rec."Variant Code";
    //     ReservEntry."Item Tracking" := ReservEntry."Item Tracking"::"Serial No.";
    //     ReservEntry."Serial No." := 'Test01';
    //     ReservEntry."Created By" := UserId;
    //     ReservEntry."Creation Date" := Today;
    //     ReservEntry.Insert(true);
    //     Message('Manual Reservation Entry created for %1 - Line %2', rec."No.", rec."Line No.");
    // end;

    // Task-20

    // [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", OnAfterSalesInvLineInsert, '', true, true)]
    // local procedure topassvalue(var SalesHeader: Record "Sales Header")
    // var
    //     SalesLine: Record "Sales Line";
    //     Item: Record Item;
    // begin
    //     SalesLine.Reset();
    //     SalesLine.SetRange("Document Type", SalesHeader."Document Type");
    //     SalesLine.SetRange("Document No.", SalesHeader."No.");

    //     if SalesLine.FindSet() then
    //         repeat
    //             if SalesLine.Type = SalesLine.Type::Item then
    //                 if Item.Get(SalesLine."No.") then begin
    //                     Item."Last Sales Price" := SalesLine."Unit Price";
    //                     Item.Modify();
    //                     Message('Inserted into Item: %1, Unit Price: %2', Item."No.", SalesLine."Unit Price");
    //                 end;
    //         until SalesLine.Next() = 0;
    // end;

    // [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", OnAfterPurchInvLineInsert, '', true, true)]
    // local procedure UpdateLastPurchasePrice(PurchHeader: Record "Purchase Header")
    // var
    //     PurchaseLine: Record "Purchase Line";
    //     Item: Record Item;
    // begin
    //     PurchaseLine.Reset();
    //     PurchaseLine.SetRange("Document Type", PurchHeader."Document Type");
    //     PurchaseLine.SetRange("Document No.", PurchHeader."No.");

    //     if PurchaseLine.FindSet() then
    //         repeat
    //             if PurchaseLine.Type = PurchaseLine.Type::Item then
    //                 if Item.Get(PurchaseLine."No.") then begin
    //                     Item."Last Purchase Price" := PurchaseLine."Unit Cost";
    //                     Item.Modify();
    //                     Message('Updated Item: %1, Last Purchase Price: %2', Item."No.", PurchaseLine."Unit Cost");
    //                 end;
    //         until PurchaseLine.Next() = 0;
    // end;

    //Task - 21
    // [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnBeforeTestStatusOpen', '', true, true)]
    // local procedure OnBeforeTestStatusOpen(var SalesLine: Record "Sales Line"; var SalesHeader: Record "Sales Header"; var IsHandled: Boolean; xSalesLine: Record "Sales Line"; CallingFieldNo: Integer; var StatusCheckSuspended: Boolean)

    // var
    //     ReleaseSalesDoc: Codeunit "Release Sales Document";
    // begin
    //     IsHandled := true;
    //     if SalesLine."Document Type" = SalesLine."Document Type"::Order then begin
    //         if SalesHeader.Status = SalesHeader.Status::Released then begin
    //             ReleaseSalesDoc.Reopen(SalesHeader);
    //             SalesHeader.Modify(true);
    //             Message('Sales Order %1 was auto-reopened for editing.', SalesHeader."No.");
    //         end;
    //     end;
    // end;

    // [EventSubscriber(ObjectType::Page, Page::"Sales Order Subform", OnBeforeQuantityOnAfterValidate, '', true, true)]
    // local procedure OnBeforeQuantityOnAfterValidate(var SalesLine: Record "Sales Line"; var xSalesLine: Record "Sales Line")
    // var
    //     salesaheader: Record "Sales Header";
    // begin
    //     salesaheader.Get(SalesLine."Document Type", SalesLine."Document No.");
    //     salesaheader.Status := salesaheader.Status::Released;
    //     salesaheader.Modify(true);
    // end;

    // Task-22
    // [EventSubscriber(ObjectType::Page, Page::"Purchase Order Subform", OnAfterValidateEvent, "No.", true, true)]
    // local procedure MyProcedure(var Rec: Record "Purchase Line")
    // var
    //     purchaseheader: Record "Purchase Header";
    // begin
    //     if PurchaseHeader.Get(Rec."Document Type", Rec."Document No.") then begin
    //         Message('This is the data from header- %1', purchaseheader."Buyer Name");
    //         Rec.Validate("Requested By", PurchaseHeader."Buyer Name");
    //         rec.Modify(true);
    //     end;
    // end;

    // // Task-23

    // [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Sales Document", OnAfterReleaseSalesDoc, '', true, true)]
    // local procedure AutoShipAfterRelease(var SalesHeader: Record "Sales Header")
    // var
    //     SalesPost: Codeunit "Sales-Post";
    // begin
    //     if SalesHeader."Document Type" = SalesHeader."Document Type"::Order then begin
    //         SalesHeader."Posting Date" := Today;
    //         SalesHeader.Ship := true;
    //         SalesHeader.Invoice := false;
    //         SalesPost.SetPostingFlags(SalesHeader);
    //         SalesPost.Run(SalesHeader);
    //     end;
    // end;

    //Task -24
    // [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Sales Document", OnAfterReleaseSalesDoc, '', false, false)]
    // local procedure OnAfterReleaseSalesDocumentHandler(SalesHeader: Record "Sales Header")
    // var
    //     PurchHeader: Record "Purchase Header";
    //     PurchLine: Record "Purchase Line";
    //     SalesLine: Record "Sales Line";
    //     VendorNo: Code[20];
    //     LineNo: Integer;
    // begin
    //     if SalesHeader."Document Type" <> SalesHeader."Document Type"::Order then
    //         exit;


    //     VendorNo := '40000';
    //     PurchHeader.Init();
    //     PurchHeader."Document Type" := PurchHeader."Document Type"::Quote;
    //     PurchHeader.Insert(true);
    //     PurchHeader.Validate("Buy-from Vendor No.", VendorNo);
    //     PurchHeader.Validate("Document Date", Today);
    //     PurchHeader.Modify(true);

    //     SalesLine.SetRange("Document Type", SalesLine."Document Type"::Order);
    //     SalesLine.SetRange("Document No.", SalesHeader."No.");

    //     LineNo := 10000;
    //     if SalesLine.FindSet() then begin
    //         repeat
    //             PurchLine.Init();
    //             PurchLine."Document Type" := PurchHeader."Document Type";
    //             PurchLine."Document No." := PurchHeader."No.";
    //             PurchLine."Line No." := LineNo;
    //             PurchLine.Validate("Type", SalesLine."Type");
    //             PurchLine.Validate("No.", SalesLine."No.");
    //             PurchLine.Validate(Quantity, SalesLine.Quantity);
    //             PurchLine.Insert();
    //             LineNo += 10000;
    //         until SalesLine.Next() = 0;
    //     end;

    //     Message('Purchase Quote %1 created for Sales Order %2.', PurchHeader."No.", SalesHeader."No.");
    // end;

    //Task-26
    // [EventSubscriber(ObjectType::Page, Page::"Sales Order Subform", OnAfterValidateEvent, 'Quantity', true, true)]
    // local procedure MyProcedure4(var Rec: Record "Sales Line")
    // var
    //     ItemLedgerEntry: Record "Item Ledger Entry";
    //     PurchaseHeader: Record "Purchase Header";
    //     PurchaseLine: Record "Purchase Line";
    //     count: Decimal;
    //     QtyToOrder: Decimal;
    //     ConfirmCreate: Boolean;
    // begin
    //     if Rec.Type <> Rec.Type::Item then
    //         exit;
    //     ItemLedgerEntry.Reset();
    //     ItemLedgerEntry.SetRange("Item No.", Rec."No.");
    //     ItemLedgerEntry.SetRange("Location Code", Rec."Location Code");
    //     if ItemLedgerEntry.FindSet() then
    //         repeat
    //             count += ItemLedgerEntry.Quantity;
    //         until ItemLedgerEntry.Next() = 0;
    //     Message('Available inventory for item %1 at location %2 is: %3', Rec."No.", Rec."Location Code", count);
    //     if Rec.Quantity > count then begin
    //         QtyToOrder := Rec.Quantity - count;
    //         ConfirmCreate := Confirm(
    //             'Stock is insufficient. Only %1 available. Do you want to create a Purchase Order for remaining %2?',
    //             false, count, QtyToOrder);
    //         if not ConfirmCreate then
    //             exit;
    //         PurchaseHeader.Init();
    //         PurchaseHeader."Document Type" := PurchaseHeader."Document Type"::Order;
    //         PurchaseHeader.Validate("Buy-from Vendor No.", '10000');
    //         PurchaseHeader.Insert(true);
    //         PurchaseLine.Init();
    //         PurchaseLine."Document Type" := PurchaseHeader."Document Type";
    //         PurchaseLine."Document No." := PurchaseHeader."No.";
    //         PurchaseLine.Type := PurchaseLine.Type::Item;
    //         PurchaseLine.Validate("No.", Rec."No.");
    //         PurchaseLine.Validate(Quantity, QtyToOrder);
    //         PurchaseLine.Insert(true);
    //         Message('Purchase Order %1 created for item %2, quantity %3.', PurchaseHeader."No.", Rec."No.", QtyToOrder);
    //     end;
    // end;



    //Task 27
    // [EventSubscriber(ObjectType::Table, Database::"Sales Invoice Line", 'OnAfterInitFromSalesLine', '', true, true)]
    // local procedure AppendNameToLastLineOnly(
    //  var SalesInvLine: Record "Sales Invoice Line";
    //  SalesInvHeader: Record "Sales Invoice Header";
    //  SalesLine: Record "Sales Line")
    // var
    //     TempSalesLine: Record "Sales Line";
    //     MaxLineNo: Integer;
    // begin

    //     TempSalesLine.Reset();
    //     TempSalesLine.SetRange("Document Type", SalesLine."Document Type");
    //     TempSalesLine.SetRange("Document No.", SalesLine."Document No.");
    //     if TempSalesLine.FindLast() then
    //         MaxLineNo := TempSalesLine."Line No.";

    //     if SalesLine."Line No." = MaxLineNo then begin
    //         SalesInvLine.Description := SalesInvLine.Description + ' @saivamsi';
    //     end;
    // end;


    //Task -28

    //   [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnInsertPostedHeadersOnAfterInsertInvoiceHeader', '', true, true)]
    // local procedure OnInsertPostedHeadersOnAfterInsertInvoiceHeader(var SalesHeader: Record "Sales Header"; var SalesInvoiceHeader: Record "Sales Invoice Header")
    // begin
    //     Message('Triggered salesinvoce header');
    //     SalesInvoiceHeader."Custom Ref" := SalesHeader."Custom Ref";
    // end;


    //Task - 29

    // [EventSubscriber(ObjectType::Table, Database::"Customer", 'OnBeforeModifyEvent', '', false, false)]
    // local procedure UpdateReferencedIdsCustomerOnModify(var Rec: Record Customer; var xRec: Record Customer; RunTrigger: Boolean)
    // var
    //     creditlog: Record Creditlog;
    // begin
    //     Message('ex rec value %1 and new rec value  %2', rec."Credit Limit (LCY)", xRec."Credit Limit (LCY)");
    //     creditlog.Init();
    //     creditlog."old credit limit" := xrec."Credit Limit (LCY)";
    //     creditlog."New credit limit" := rec."Credit Limit (LCY)";
    //     creditlog."User Name" := rec.Name;
    //     creditlog."date and time" := CurrentDateTime;
    //     creditlog.Insert();
    // end;



    //Task- 30
    // [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post (Yes/No)", 'OnBeforeRunSalesPost', '', true, true)]
    // local procedure HandleBeforeRunSalesPost(var SalesHeader: Record "Sales Header"; var IsHandled: Boolean; var SuppressCommit: Boolean)
    // var
    //     customer: Record Customer;
    //     custLedgerEntry: Record "Cust. Ledger Entry";
    //     TotalDue: Decimal;

    // begin
    //     customer.GET(SalesHeader."Sell-to Customer No.");
    //     custLedgerEntry.Reset();
    //     custLedgerEntry.SetRange("Customer No.", customer."No.");
    //     custLedgerEntry.SetRange("Document Type", custLedgerEntry."Document Type"::Invoice);
    //     custLedgerEntry.SetRange(Open, true);
    //     custLedgerEntry.SetFilter("Due Date", '<%1', Today);
    //     if custLedgerEntry.FindSet() then
    //         repeat
    //             custLedgerEntry.CalcFields("Remaining Amt. (LCY)");
    //             TotalDue += custLedgerEntry."Remaining Amount";
    //         until custLedgerEntry.Next() = 0;
    //     customer.CalcFields("Balance Due (LCY)");
    //     TotalDue += customer."Balance Due (LCY)";
    //     if TotalDue < customer."Credit Limit (LCY)" then begin
    //         Error('Sorry You exceded the credit limit you cannot post the order');
    //         IsHandled := true;
    //     end;
    // end;



    //Task -31 
    // [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post (Yes/No)", 'OnBeforeRunSalesPost', '', true, true)]
    // local procedure HandleBeforeRunSalesPost(var SalesHeader: Record "Sales Header"; var IsHandled: Boolean; var SuppressCommit: Boolean)
    // var
    //     salesline: Record "Sales Line";
    //     Item: Record Item;
    // begin
    //     Message('Posting is about to start the process: %1 , %2', SalesHeader."No.", SalesHeader."Document Type");
    //     salesline.Reset();
    //     salesline.SetRange("Document Type", SalesHeader."Document Type");
    //     salesline.SetRange("Document No.", SalesHeader."No.");
    //     if salesline.FindSet() then begin
    //         Item.Get(salesline."No.");
    //         Item.CalcFields("Inventory");
    //         if salesline.Quantity > Item.Inventory then begin
    //             Error('Quantity entered for item %1 exceeds available inventory. Please check stock levels.', Item."No.");
    //             IsHandled := true;
    //         end;
    //     end;
    // end;


}