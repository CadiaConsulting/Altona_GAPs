pageextension 50103 "Sales Quote PTE" extends "Sales Quote"
{
    layout
    {
        addafter("Shipment Date")
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