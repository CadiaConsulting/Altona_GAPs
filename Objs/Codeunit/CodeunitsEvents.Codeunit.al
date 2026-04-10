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

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"CADBR Send Mail NFe", 'OnAfterNFeSendFile', '', false, false)]
    local procedure Codeunit_86_OnAfterNFeSendFile(var SendOK: Boolean; var NFeProcess: Record "CADBR NF-e Process")
    var
        SalesReceivablesSetup: Record "Sales & Receivables Setup";
        FunctionsAl: Codeunit Functions;
    begin

        SalesReceivablesSetup.GET;

        IF (SendOK) and (SalesReceivablesSetup."Allows Auto Docum. Sending") AND (nfeProcess."Return Code" IN ['100', '104']) THEN BEGIN
            FunctionsAl.SendItemDocuments(nfeProcess."NF-e Process No.");
        END;

    end;

}