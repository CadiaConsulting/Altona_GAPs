pageextension 50108 "Sales Quote Archives PTE" extends "Sales Quote Archives"
{
    layout
    {
        addafter("Shipment Date")
        {
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
    trigger OnOpenPage()
    begin
        UpdateQuotes;
    end;

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

    LOCAL PROCEDURE UpdateQuotes();
    VAR
        SalesHeaderArchive: Record 5107;
    BEGIN
        SalesHeaderArchive.RESET;
        SalesHeaderArchive.SETRANGE("Document Type", SalesHeaderArchive."Document Type"::Quote);
        IF SalesHeaderArchive.FINDFIRST THEN
            REPEAT
                SalesHeaderArchive.CALCFIELDS("Order Not Posted Created", "Order Posted Created");
                IF SalesHeaderArchive."Order Not Posted Created" OR SalesHeaderArchive."Order Posted Created" THEN
                    SalesHeaderArchive."Order Created" := TRUE
                ELSE
                    SalesHeaderArchive."Order Created" := FALSE;
                SalesHeaderArchive.MODIFY;
            UNTIL SalesHeaderArchive.NEXT = 0;

        CurrPage.UPDATE;

    END;

}