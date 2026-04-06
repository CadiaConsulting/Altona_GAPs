tableextension 50100 "Customer PTE" extends Customer
{
    fields
    {
        field(50100; "Laboratory Responsible E-mail"; Text[80])
        {
            Caption = 'Laboratory Responsible E-mail';
            ExtendedDatatype = EMail;

        }

    }

}