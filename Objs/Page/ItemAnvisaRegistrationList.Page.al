page 50100 "Item Anvisa Registration List"
{
    ApplicationArea = All;
    Caption = 'Item Anvisa Registration List';
    PageType = List;
    SourceTable = "Item Anvisa Registration";
    UsageCategory = Lists;
    
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Item Nº"; Rec."Item Nº")
                {
                    ToolTip = 'Specifies the value of the Item Nº field.', Comment = '%';
                }
                field("Anvisa Registration Nº"; Rec."Anvisa Registration Nº")
                {
                    ToolTip = 'Specifies the value of the Anvisa Registration Nº field.', Comment = '%';
                }
                field("Expiration Date"; Rec."Expiration Date")
                {
                    ToolTip = 'Specifies the value of the Expiration Date field.', Comment = '%';
                }
                field(Enable; Rec.Enable)
                {
                    ToolTip = 'Specifies the value of the Enable field.', Comment = '%';
                }
            }
        }
    }
}
