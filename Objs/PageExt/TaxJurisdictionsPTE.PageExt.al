pageextension 50111 "Tax Jurisdictions PTE" extends "Tax Jurisdictions"
{
    layout
    {
        addafter("CADBR Base Changes")
        {
            field("Discount on Net Sale Value"; rec."Discount on Net Sale Value")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Discount on Net Sale Value field.';
            }

        }


    }
    actions
    {
        // Add changes to page actions here

    }

}