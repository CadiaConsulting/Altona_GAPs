tableextension 50105 "Item PTE" extends Item
{
    fields
    {
        field(50000; "Anvisa Registration Nº"; Text[50])
        {
            Caption = 'Anvisa Registration Nº';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup("Item Anvisa Registration"."Anvisa Registration Nº" where("Item Nº" = field("No."), Enable = filter(true)));

        }

    }

}