// codeunit 72584 coidunittotranferdata
// {
//     [EventSubscriber(ObjectType::Page, Page::"Sales Order", OnPostDocumentBeforeNavigateAfterPosting, '', true, true)]
//     local procedure OnPostDocumentBeforeNavigateAfterPosting1(var SalesHeader: Record "Sales Header"; var PostingCodeunitID: Integer; var Navigate: Enum "Navigate After Posting"; DocumentIsPosted: Boolean; var IsHandled: Boolean)

//     var
//         reccc: record "Cust. Ledger Entry";
//     begin
//         reccc.Reset();
//         reccc.SetRange("Customer No.", SalesHeader."Sell-to Customer No.");
//         if reccc.FindLast() then begin
//             reccc.Customer_Name_GEN := SalesHeader."Sell-to Customer Name";
//             reccc.Modify();
//         end;

//     end;

//     var
//         tochec: Text[80];
// }