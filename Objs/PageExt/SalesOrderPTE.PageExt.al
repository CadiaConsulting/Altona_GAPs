pageextension 50104 "Sales Order PTE" extends "Sales Order"
{
    layout
    {
        addafter("Quote No.")
        {
            field("Version Quote No."; rec."Version Quote No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Version Quote No. field.';
            }

        }


    }
    actions
    {
        // Add changes to page actions here

    }

}