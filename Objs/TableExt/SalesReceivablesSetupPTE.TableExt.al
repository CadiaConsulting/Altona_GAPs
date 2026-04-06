tableextension 50149 "Sales & Receivables Setup PTE" extends "Sales & Receivables Setup"
{
    fields
    {
        field(50100; "Allows Auto Docum. Sending"; Boolean)
        {
            Caption = 'Allows Auto Docum. Sending';
        }
        field(50101; "Technical Responsible Name"; text[50])
        {
            Caption = 'Technical Responsible Name';
        }
        field(50102; "Technical Responsible E-mail"; text[80])
        {
            Caption = 'Technical Responsible E-mail';
            ExtendedDatatype = EMail;
        }
        field(50103; "Technical Responsible Phone"; text[30])
        {
            Caption = 'Technical Responsible Phone';
            ExtendedDatatype = PhoneNo;
        }

    }
}