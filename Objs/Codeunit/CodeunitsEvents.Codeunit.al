Codeunit 50101 "Codeunits Events"
{

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Quote to Invoice", 'OnCreateSalesInvoiceHeaderOnBeforeSalesInvoiceHeaderInsert', '', false, false)]
    local procedure Codeunit_1305_OnCreateSalesInvoiceHeaderOnBeforeSalesInvoiceHeaderInsert(SalesQuoteHeader: Record "Sales Header"; var SalesInvoiceHeader: Record "Sales Header")
    begin

        SalesQuoteHeader.CALCFIELDS("No. of Archived Versions");
        SalesInvoiceHeader."Version Quote No." := SalesQuoteHeader."No. of Archived Versions" + 1;

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Quote to Order", 'OnCreateSalesHeaderOnBeforeSalesOrderLineLockTable', '', false, false)]
    local procedure Codeunit_86_OnCreateSalesHeaderOnBeforeSalesOrderLineLockTable(var SalesHeaderOrder: Record "Sales Header"; var SalesHeaderQuote: Record "Sales Header")
    begin

        SalesHeaderQuote.CALCFIELDS("No. of Archived Versions");
        SalesHeaderOrder."Version Quote No." := SalesHeaderQuote."No. of Archived Versions" + 1;

    end;

}