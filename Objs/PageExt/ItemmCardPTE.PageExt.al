pageextension 50109 "Item Card PTE" extends "Item Card"
{
    layout
    {
        addafter(Description)
        {
            field("Anvisa Registration Nº"; rec."Anvisa Registration Nº")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Anvisa Registration Nº field.';
            }

        }


    }
    actions
    {
        // Add changes to page actions here
        addafter("Va&riants")
        {
            action(AnvisaRegistration)
            {

                Caption = 'Anvisa Registration';
                ApplicationArea = all;
                Image = Map;
                ToolTip = 'Anvisa Registration';
                RunObject = Page "Item Anvisa Registration List";
                RunPageLink = "Item Nº" = field("No.");

            }
        }
    }

}