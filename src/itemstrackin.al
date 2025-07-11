// pageextension 70338 MyItemTrackingLinesExt extends "Item Tracking Lines"
// {

//     var
//         Inserted: Boolean;
//         MyTrackingHelper: Codeunit 70311;

//     trigger OnAfterGetRecord()
//     var
//         Qty: Decimal;
//         ToHandle: Decimal;
//         ToInvoice: Decimal;
//         NewSpec: Record "Tracking Specification";
//     begin
//         if Inserted then
//             exit;

//         // Get values from shared codeunit
//         MyTrackingHelper.GetTrackingValues(Qty, ToHandle, ToInvoice);
//         if Qty = 0 then
//             exit;

//         NewSpec.Init();
//         NewSpec.TransferFields(Rec);
//         NewSpec."Entry No." := 3;
//         NewSpec."Quantity (Base)" := Qty;
//         NewSpec."Qty. to Handle (Base)" := ToHandle;
//         NewSpec."Qty. to Invoice (Base)" := ToInvoice;
//         NewSpec."Lot No." := 'AUTO-LOT-001';

//         NewSpec.Insert();

//         Inserted := true;
//         MyTrackingHelper.ClearTrackingValues();
//     end;

// }
