pageextension 50106 "Sales Quote Archive PTE" extends "Sales Quote Archive"
{
    layout
    {
        addafter(Status)
        {
            field("Boarding Condition"; rec."Boarding Condition")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Boarding Condition field.';
            }
            field("Order Created"; rec."Order Created")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Order Created field.';
            }

        }


    }
    actions
    {
        // Add changes to page actions here

    }
    trigger OnAfterGetRecord()
    var

    begin
        CALCFIELDS("Order Not Posted Created", "Order Posted Created");
        IF "Order Not Posted Created" OR "Order Posted Created" THEN begin
            "Order Created" := TRUE;
            Modify();
        end ELSE begin
            "Order Created" := FALSE;
            Modify();
        end;

    end;

}