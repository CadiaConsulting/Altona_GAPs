pageextension 50144 "Sales & Receivables Setup PTE" extends "Sales & Receivables Setup"
{
    layout
    {
        addafter("CADBR Allow Manual Reconciliation")
        {
            group("Instructions for Use of Kits")//ENU=Instructions for Use of Kits;PTB=Instruções de uso de kits
            {
                Caption = 'Instructions for Use of Kits';

                field("Allows Auto Docum. Sending"; rec."Allows Auto Docum. Sending")
                {
                    ApplicationArea = all;
                }
                field("Technical Responsible Name"; rec."Technical Responsible Name")
                {
                    ApplicationArea = all;
                }
                field("Technical Responsible E-mail"; rec."Technical Responsible E-mail")
                {
                    ApplicationArea = all;
                }
                field("Technical Responsible Phone"; rec."Technical Responsible Phone")
                {
                    ApplicationArea = all;
                }
            }
        }

    }

    actions
    {
        // Add changes to page actions here
    }


}