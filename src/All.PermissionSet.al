permissionset 50100 "AltonaBasic"
{
    Access = Internal;
    Assignable = true;
    Caption = 'Altona All permissions', Locked = true;

    Permissions =
         codeunit "Codeunits Events" = X,
         codeunit Functions = X,
         page "Item Anvisa Registration List" = X,
         report "Sales - Quote Altona" = X,
         table "Item Anvisa Registration" = X,
         tabledata "Item Anvisa Registration" = RIMD;
}