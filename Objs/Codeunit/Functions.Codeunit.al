codeunit 50100 Functions
{
    trigger OnRun()
    begin

    end;

    procedure SendItemDocuments(nfeProcessNo: Text[20])
    var

        nfeProcess: Record "cadbr NF-e Process";
        tagE: Record "cadbr NF-e Receiver - Tag E";
        tagI: Record "CADBR NF-e Prod.Service-Tag I";
        customer: Record Customer;
        item: Record Item;
        DocumentAttachment: Record "Document Attachment";
        salesSetup: Record "Sales & Receivables Setup";
        BranchInf: Record "cadbr Branch Information";
        fiscalFunctions: Codeunit "CADBR Fiscal Functions";
        Mail: Codeunit "Email";
        EmailMessage: Codeunit "Email Message";
        EmailAccount: Record "Email Account" temporary;
        EmailAccountMgt: Codeunit "Email Account";
        TempBlob: Codeunit "Temp Blob";
        Base64Convert: Codeunit "Base64 Convert";
        cnpj: Text;
        senderName: Text[30];
        senderAddress: Text[250];
        recipients: Text[1024];
        subject: Text[80];
        body: Text[1024];
        attachFileName: Text[250];
        PDFBase64: array[10] of Text;
        PDFName: array[10] of Text[250];
        OutStr: OutStream;
        InStr: InStream;
        i: Integer;
        countUrl: Integer;
        TextCustomerError: Label 'Não foi possível enviar os Documentos de Instrução de Uso para o cliente %1. Campo "E-Mail Responsável Laboratório" não pode estar vazio no cartão do cliente.';
        TextBody: Label '<p>Prezado Cliente,</p><p>Segue anexo as instruções de uso para o(s) kit(s) adquirido(s) através da NFE %1.</p><p>Qualquer dúvida, por favor, entre em contato com o nosso responsável técnico %2 através do e-mail: %3 ou pelo telefone %4.</p><p>Atenciosamente,</p><p>%5</p>';
        TextSubject: Label 'Instruções de uso dos Kits';
    begin

        salesSetup.GET;
        tagE.GET(nfeProcessNo);
        countUrl := 0;

        CLEAR(Mail);
        CLEAR(EmailMessage);
        CLEAR(TempBlob);

        EmailAccountMgt.GetAllAccounts(EmailAccount);
        EmailAccount.RESET;
        EmailAccount.SetRange(Name, 'mensageria');
        if not EmailAccount.findfirst then
            exit;

        tagI.RESET;
        tagI.SETRANGE("NFe Process No.", nfeProcessNo);
        IF tagI.FINDFIRST THEN
            REPEAT
                item.GET(tagI."No.");
                DocumentAttachment.RESET;
                DocumentAttachment.SETRANGE("Table ID", 27);
                DocumentAttachment.SETRANGE("No.", tagI."No.");
                DocumentAttachment.SETRANGE("File Type", DocumentAttachment."File Type"::PDF);
                IF DocumentAttachment.FINDFIRST THEN begin

                    if DocumentAttachment."Document Reference ID".HasValue then begin
                        TempBlob.CreateOutStream(OutStr);
                        DocumentAttachment."Document Reference ID".ExportStream(OutStr);

                        TempBlob.CreateInStream(InStr);

                        countUrl += 1;
                        pdfBase64[countUrl] := Base64Convert.ToBase64(InStr);
                        PDFName[countUrl] := DocumentAttachment."File Name" + '.' + DocumentAttachment."File Extension";

                    end;

                end;
            UNTIL tagI.NEXT = 0;

        IF countUrl > 0 THEN BEGIN

            cnpj := tagE.CNPJ;
            fiscalFunctions.CheckCNPJCPF(cnpj);

            customer.RESET;
            customer.SETCURRENTKEY("cadbr C.N.P.J./C.P.F.");
            customer.SETRANGE("cadbr C.N.P.J./C.P.F.", cnpj);
            IF customer.FINDFIRST THEN BEGIN
                IF customer."Laboratory Responsible E-mail" = '' THEN BEGIN
                    MESSAGE(TextCustomerError, customer."No.");
                END ELSE BEGIN
                    nfeProcess.GET(nfeProcessNo);
                    BranchInf.GET(nfeProcess."Branch Code");

                    senderName := BranchInf."Sender Name";
                    senderAddress := BranchInf."User ID";
                    recipients := customer."Laboratory Responsible E-mail";
                    subject := TextSubject;
                    body := STRSUBSTNO(TextBody, nfeProcess."Invoice No.", salesSetup."Technical Responsible Name",
                                       salesSetup."Technical Responsible E-mail", salesSetup."Technical Responsible Phone",
                                       BranchInf.Name);

                    EmailMessage.Create(recipients, subject, body, TRUE);

                    CLEAR(i);
                    FOR i := 1 TO countUrl DO BEGIN
                        EmailMessage.AddAttachment(PDFName[i], 'pdf', pdfBase64[i]);
                    END;

                    Mail.Send(EmailMessage, EmailAccount);

                END;
            END;
        end;


    END;

}