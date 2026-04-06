pageextension 50107 "Sales Order List PTE" extends "Sales Order List"
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