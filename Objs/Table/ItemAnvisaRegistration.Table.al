table 50100 "Item Anvisa Registration"
{
    DataClassification = ToBeClassified;
    Caption = 'Item Anvisa Registration';
    LookupPageId = "Item Anvisa Registration List";
    DrillDownPageId = "Item Anvisa Registration List";

    fields
    {
        field(1; "Item Nº"; Code[20])
        {
            caption = 'Item Nº';
            TableRelation = Item;
            DataClassification = ToBeClassified;

        }
        field(2; "Anvisa Registration Nº"; Text[50])
        {
            Caption = 'Anvisa Registration Nº';
            DataClassification = ToBeClassified;

        }
        field(3; "Expiration Date"; Date)
        {
            Caption = 'Expiration Date';
            DataClassification = ToBeClassified;

        }
        field(4; Enable; boolean)
        {
            Caption = 'Enable';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                ItemAnvisa: Record "Item Anvisa Registration";
            begin
                if Enable = true then begin
                    ItemAnvisa.Reset();
                    ItemAnvisa.SetRange("Item Nº", rec."Item Nº");
                    ItemAnvisa.SetRange(Enable, true);
                    if ItemAnvisa.FindFirst() then
                        error('Já existe um registro ativo para o Item %1 e Registro %2! Desabilite antes para umn novo registro ativo', ItemAnvisa."Item Nº", ItemAnvisa."Anvisa Registration Nº")

                end;
            end;

        }
    }

    keys
    {
        key(Key1; "Item Nº", "Anvisa Registration Nº")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        // Add changes to field groups here
    }

    var
        myInt: Integer;

    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}