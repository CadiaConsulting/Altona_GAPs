pageextension 50105 "Sales List Archive PTE" extends "Sales List Archive"
{
    layout
    {
        addafter("Currency Code")
        {
            field("Boarding Condition"; rec."Boarding Condition")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Boarding Condition field.';
            }

        }


    }
    actions
    {
        // Add changes to page actions here

    }

}