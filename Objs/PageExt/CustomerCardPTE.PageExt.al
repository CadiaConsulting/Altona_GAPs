pageextension 50100 "Customer Card PTE" extends "Customer Card"
{
    layout
    {
        addafter("CADBR E-Mail - NFe")
        {
            field("Laboratory Responsible E-mail"; "Laboratory Responsible E-mail")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Laboratory Responsible E-mail field.';
            }

        }


    }
    actions
    {
        // Add changes to page actions here

    }

}