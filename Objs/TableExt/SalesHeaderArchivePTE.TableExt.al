tableextension 50104 "Sales Header Archive PTE" extends "Sales Header Archive"
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
        field(50001; "Order Created"; Boolean)
        {
            //ENU=Order Created;PTB=Pedido Criado
            Caption = 'Order Created';
            Description = 'CADIA-001';
            Editable = false;

        }
        field(50002; "Order Not Posted Created"; Boolean)
        {
            //ENU=Order Not Posted Created;PTB=Pedido Criado N o Registrado
            Caption = 'Order Not Posted Created';
            FieldClass = FlowField;
            CalcFormula = Exist("Sales Header" WHERE("Quote No." = FIELD("No."), "Version Quote No." = FIELD("Version No.")));
            Description = 'CADIA-001';
            Editable = false;

        }
        field(50003; "Order Posted Created"; Boolean)
        {
            //ENU=Order Posted Created;PTB=Pedido Criado Registrado
            Caption = 'Order Posted Created';
            FieldClass = FlowField;
            CalcFormula = Exist("Sales Invoice Header" WHERE("Quote No." = FIELD("No."), "Version Quote No." = FIELD("Version No.")));
            Description = 'CADIA-001';
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