tableextension 50103 "Sales Invoice Header PTE" extends "Sales Invoice Header"
{

    fields
    {
        field(50000; "Boarding Condition"; Text[100])
        {
            //ENU=Boarding Condition;PTB=Condição de Embarque
            Caption = 'Boarding Condition';
            Description = 'CADIA-002';
            Editable = false;

        }
        field(50004; "Version Quote No."; integer)
        {
            //ENU=Version Quote No.;PTB=No. Versão Cotação
            Caption = 'Version Quote No.';
            Description = 'CADIA-002';
            Editable = false;

        }

    }

}