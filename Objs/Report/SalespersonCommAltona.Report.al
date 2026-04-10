report 50115 "Salesperson-Commission Altona"
{
    DefaultLayout = RDLC;
    RDLCLayout = './ReportLayout/SalespersonCommissionAltona.rdlc';
    PreviewMode = PrintLayout;
    ApplicationArea = Suite;
    Caption = 'Salesperson - Commission';
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Salesperson/Purchaser"; "Salesperson/Purchaser")
        {
            DataItemTableView = sorting(Code);
            PrintOnlyIfDetail = true;
            RequestFilterFields = "Code";
            column(STRSUBSTNO_Text000_PeriodText_; StrSubstNo(PeriodTxt, PeriodText))
            {
            }
            column(Salesperson_Purchaser__TABLECAPTION__________SalespersonFilter; SalespersonFilterHeading)
            {
            }
            column(Cust__Ledger_Entry__TABLECAPTION__________CustLedgEntryFilter; CustLedgEntryFilterHeading)
            {
            }
            column(Salesperson_Purchaser_Code; Code)
            {
            }
            column(Salesperson_Purchaser_Name; Name)
            {
            }
            column(Salesperson_Purchaser__Commission___; "Commission %")
            {
            }
#if not CLEAN27
            column(COMPANYNAME; COMPANYPROPERTY.DisplayName())
            {

            }
            column(SalespersonFilter; SalespersonFilter)
            {

            }
            column(CustLedgEntryFilter; CustLedgEntryFilter)
            {

            }
            column(PageGroupNo; PageGroupNo)
            {

            }
            column(Cust__Ledger_Entry___Sales__LCY__; "Cust. Ledger Entry"."Sales (LCY)")
            {

            }
            column(Cust__Ledger_Entry___Profit__LCY__; "Cust. Ledger Entry"."Profit (LCY)")
            {

            }
            column(SalesCommissionAmt; SalesCommissionAmt)
            {
                AutoFormatType = 1;

            }
            column(ProfitCommissionAmt; ProfitCommissionAmt)
            {
                AutoFormatType = 1;

            }
            column(AdjProfit; AdjProfit)
            {
                AutoFormatType = 1;

            }
            column(AdjProfitCommissionAmt; AdjProfitCommissionAmt)
            {
                AutoFormatType = 1;

            }
            column(Salesperson___CommissionCaption; Salesperson___CommissionCaptionLbl)
            {

            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {

            }
            column(All_amounts_are_in_LCYCaption; All_amounts_are_in_LCYCaptionLbl)
            {

            }
            column(Cust__Ledger_Entry__Posting_Date_Caption; Cust__Ledger_Entry__Posting_Date_CaptionLbl)
            {

            }
            column(Cust__Ledger_Entry__Document_No__Caption; "Cust. Ledger Entry".FieldCaption("Document No."))
            {

            }
            column(Cust__Ledger_Entry__Document_External__Caption; "Cust. Ledger Entry".FieldCaption("External Document No."))
            {

            }
            column(Cust__Ledger_Entry__Customer_No__Caption; "Cust. Ledger Entry".FieldCaption("Customer No."))
            {

            }
            column(Cust__Ledger_Entry__Customer_Name_Caption; "Cust. Ledger Entry".FieldCaption("Customer Name"))
            {

            }

            column(Cust__Ledger_Entry__Sales__LCY__Caption; "Cust. Ledger Entry".FieldCaption("Sales (LCY)"))
            {

            }
            column(Cust__Ledger_Entry__Profit__LCY__Caption; "Cust. Ledger Entry".FieldCaption("Profit (LCY)"))
            {

            }
            column(SalesCommissionAmt_Control32Caption; SalesCommissionAmt_Control32CaptionLbl)
            {

            }
            column(ProfitCommissionAmt_Control33Caption; ProfitCommissionAmt_Control33CaptionLbl)
            {

            }
            column(AdjProfit_Control39Caption; AdjProfit_Control39CaptionLbl)
            {

            }
            column(AdjProfitCommissionAmt_Control45Caption; AdjProfitCommissionAmt_Control45CaptionLbl)
            {

            }
            column(Salesperson_Purchaser__Commission___Caption; FieldCaption("Commission %"))
            {

            }
            column(TotalCaption; TotalCaptionLbl)
            {

            }
#endif
            dataitem("Cust. Ledger Entry"; "Cust. Ledger Entry")
            {
                DataItemLink = "Salesperson Code" = field(Code);
                DataItemTableView = sorting("Salesperson Code", "Posting Date") where("Document Type" = filter(Invoice | "Credit Memo"));
                RequestFilterFields = "Posting Date";
                column(Cust__Ledger_Entry__Posting_Date_; Format("Posting Date"))
                {
                }
                column(Cust__Ledger_Entry__Document_No__; "Document No.")
                {
                }
                column(Cust__Ledger_Entry__Document_External__; "External Document No.")
                {
                }
                column(Cust__Ledger_Entry__Customer_No__; "Customer No.")
                {
                }
                column(Cust__Ledger_Entry__Sales__LCY__; "Sales (LCY)")
                {
                }
                column(Cust__Ledger_Entry__Profit__LCY__; "Profit (LCY)")
                {
                }
                column(CustLedgerEntry_CustomerName; Customer_Name)
                {
                }
                column(SalesCommissionAmt_Control32; SalesCommissionAmt)
                {
                    AutoFormatType = 1;
                }
                column(ProfitCommissionAmt_Control33; ProfitCommissionAmt)
                {
                    AutoFormatType = 1;
                }
                column(AdjProfit_Control39; AdjProfit)
                {
                    AutoFormatType = 1;
                }
                column(AdjProfitCommissionAmt_Control45; AdjProfitCommissionAmt)
                {
                    AutoFormatType = 1;
                }
                column(SalespersonPurchaser_Code; "Salesperson/Purchaser".Code)
                {
                    IncludeCaption = true;
                }
                column(Salesperson_Purchaser__Name; "Salesperson/Purchaser".Name)
                {
                    IncludeCaption = true;
                }

                trigger OnAfterGetRecord()
                var
                    VATEntry: Record "VAT Entry";
                    Customer: Record Customer;
                    CustLedgerEntry: Record "Cust. Ledger Entry";
                    TaxJurisdictions: Record "Tax Jurisdiction";
                    CostCalcMgt: Codeunit "Cost Calculation Management";
                    TaxesDiscount: Decimal;
                    TotalAmount: Decimal;
                    Fator: Decimal;

                begin

                    VATEntry.RESET;
                    VATEntry.SETRANGE("Document Type", "Document Type");
                    VATEntry.SETRANGE("Document No.", "Document No.");
                    VATEntry.SETRANGE("Posting Date", "Posting Date");
                    VATEntry.SETRANGE("Bill-to/Pay-to No.", "Customer No.");
                    CLEAR(TaxesDiscount);
                    IF VATEntry.FINDSET THEN
                        REPEAT
                            TaxJurisdictions.RESET;
                            TaxJurisdictions.SETRANGE("Code", VATEntry."Tax Jurisdiction Code");
                            IF TaxJurisdictions.FINDSET THEN
                                REPEAT
                                    IF TaxJurisdictions."Discount on Net Sale Value" THEN
                                        TaxesDiscount += VATEntry.Amount;
                                UNTIL TaxJurisdictions.NEXT = 0;
                        UNTIL VATEntry.NEXT = 0;

                    CLEAR(TotalAmount);
                    CustLedgerEntry.RESET;
                    CustLedgerEntry.SETRANGE("Document Type", "Cust. Ledger Entry"."Document Type");
                    CustLedgerEntry.SETRANGE("Document No.", "Cust. Ledger Entry"."Document No.");
                    CustLedgerEntry.SETRANGE("Posting Date", "Cust. Ledger Entry"."Posting Date");
                    IF CustLedgerEntry.FINDFIRST THEN
                        REPEAT
                            CustLedgerEntry.CALCFIELDS("Original Amt. (LCY)");
                            TotalAmount += CustLedgerEntry."Original Amt. (LCY)";
                        UNTIL CustLedgerEntry.NEXT = 0;

                    "Cust. Ledger Entry".CalcFields("Original Amt. (LCY)");

                    IF TotalAmount <> "Cust. Ledger Entry"."Original Amt. (LCY)" THEN
                        Fator := TotalAmount / "Cust. Ledger Entry"."Original Amt. (LCY)"
                    ELSE
                        Fator := 1;

                    AdjProfit := ROUND("Sales (LCY)" - (TaxesDiscount / Fator), 0.01);

                    SalesCommissionAmt := Round(AdjProfit * "Salesperson/Purchaser"."Commission %" / 100);

                    // Calculate SubTotals for Word Layout
                    SubtotalsSales += "Sales (LCY)";
                    SubtotalsProfit += "Profit (LCY)";
                    SubtotalsAdjProfit += AdjProfit;
                    SubtotalsSalesCommission += SalesCommissionAmt;
                    SubtotalsProfitCommission += ProfitCommissionAmt;
                    SubtotalsAdjProfitCommission += AdjProfitCommissionAmt;
                    // Calculate Grand Totals for Word Layout
                    TotalsSales += "Sales (LCY)";
                    TotalsProfit += "Profit (LCY)";
                    TotalsAdjProfit += AdjProfit;
                    TotalsSalesCommission += SalesCommissionAmt;
                    TotalsProfitCommission += ProfitCommissionAmt;
                    TotalsAdjProfitCommission += AdjProfitCommissionAmt;

                    IF Customer.GET("Customer No.") THEN
                        Customer_Name := Customer.Name;

                    if not ReportHasData then
                        ReportHasData := true;
                end;

                trigger OnPreDataItem()
                begin
                    ClearAmounts();
                end;
            }
            dataitem(Subtotals; Integer)
            {
                DataItemTableView = sorting(Number) where(Number = const(1));

                // Used for test cases mapping
                column(Subtotals_Salesperson_Code; "Salesperson/Purchaser".Code)
                {
                }
                column(Subtotals_Sales; SubtotalsSales)
                {
                    AutoFormatType = 1;
                }
                column(Subtotals_Profit; SubtotalsProfit)
                {
                    AutoFormatType = 1;
                }
                column(Subtotals_AdjProfit; SubtotalsAdjProfit)
                {
                    AutoFormatType = 1;
                }
                column(Subtotals_SalesCommission; SubtotalsSalesCommission)
                {
                    AutoFormatType = 1;
                }
                column(Subtotals_ProfitCommission; SubtotalsProfitCommission)
                {
                    AutoFormatType = 1;
                }
                column(Subtotals_AdjProfitCommission; SubtotalsAdjProfitCommission)
                {
                    AutoFormatType = 1;
                }

                trigger OnPreDataItem()
                begin
                    if "Cust. Ledger Entry".IsEmpty() then
                        CurrReport.Break();
                end;
            }

            trigger OnAfterGetRecord()
            begin
                if PrintOnlyOnePerPageReq then
                    PageGroupNo := PageGroupNo + 1;

                // Reset SubTotals for Word Layout
                SubtotalsSales := 0;
                SubtotalsProfit := 0;
                SubtotalsAdjProfit := 0;
                SubtotalsSalesCommission := 0;
                SubtotalsProfitCommission := 0;
                SubtotalsAdjProfitCommission := 0;
            end;

            trigger OnPreDataItem()
            begin
                PageGroupNo := 1;
                ClearAmounts();
            end;
        }
        dataitem(Totals; Integer)
        {
            DataItemTableView = sorting(Number) where(Number = const(1));

            column(Totals_Sales; TotalsSales)
            {
                AutoFormatType = 1;
            }
            column(Totals_Profit; TotalsProfit)
            {
                AutoFormatType = 1;
            }
            column(Totals_AdjProfit; TotalsAdjProfit)
            {
                AutoFormatType = 1;
            }
            column(Totals_SalesCommission; TotalsSalesCommission)
            {
                AutoFormatType = 1;
            }
            column(Totals_ProfitCommission; TotalsProfitCommission)
            {
                AutoFormatType = 1;
            }
            column(Totals_AdjProfitCommission; TotalsAdjProfitCommission)
            {
                AutoFormatType = 1;
            }

            trigger OnPreDataItem()
            begin
                if not ReportHasData then
                    CurrReport.Break();
            end;
        }
    }

    requestpage
    {
        AboutTitle = 'About Salesperson - Commission';
        AboutText = 'Analyze the commissions by salesperson. See the customer, document, sales amounts and profit amounts provided by a salesperson''s contributions.';
        SaveValues = true;

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(PrintOnlyOnePerPage; PrintOnlyOnePerPageReq)
                    {
                        ApplicationArea = Suite;
                        Caption = 'New Page per Person';
                        ToolTip = 'Specifies if each person''s information is printed on a new page if you have chosen two or more persons to be included in the report.';
                    }
                    // Used to set the Period on the report header across multiple languages
                    field(RequestPeriodText; PeriodText)
                    {
                        ApplicationArea = All;
                        Caption = 'Period';
                        ToolTip = 'Specifies the Date Period applied to this report.';
                        Visible = false;
                    }
                    // Used to set the Salesperson Filter on the report header across multiple languages
                    field(RequestSalespersonFilterHeading; SalespersonFilterHeading)
                    {
                        ApplicationArea = All;
                        Caption = 'Salesperson Filter';
                        ToolTip = 'Specifies the Salesperson Filters applied to this report.';
                        Visible = false;
                    }
                    // Used to set the Cust. Ledg. Entry Filter on the report header across multiple languages
                    field(RequestCustLedgEntryFilterHeading; CustLedgEntryFilterHeading)
                    {
                        ApplicationArea = All;
                        Caption = 'Cust. Ledg. Entry Filter';
                        ToolTip = 'Specifies the Customer Ledger Entry filters applied to this report.';
                        Visible = false;
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnClosePage()
        begin
            // Ensures Layout Filter Headings are up to date
            UpdateRequestPageFilterValues();
        end;
    }
    labels
    {
        SalespersonCommissionLabel = 'Salesperson - Commission';
        SalespersonCommissionPrint = 'Salesperson Commission (Print)', MaxLength = 31, Comment = 'Excel worksheet name.';
        SalespersonCommissionAnalysis = 'Salesp. Commission (Analysis)', MaxLength = 31, Comment = 'Excel worksheet name.';
        DataRetrieved = 'Data retrieved:';
        PeriodCaption = 'Period:';
        DocumentNoLabel = 'Document No.';
        CustomerNoLabel = 'Customer No.';
        CustomerNameLabel = 'Customer Name';
        SalesLabel = 'Sales (LCY)';
        ProfitLabel = 'Profit (LCY)';
        PostingDateLabel = 'Posting Date';
        SalesCommissionLabel = 'Sales Commission (LCY)';
        ProfitCommissionLabel = 'Profit Commission (LCY)';
        AdjustedProfitLabel = 'Adjusted Profit (LCY)';
        AdjustedProfitCommissionLabel = 'Adjusted Profit Commission (LCY)';
        CommissionPercentLabel = 'Commission %';
        AllAmountsAreInLCYLabel = 'All amounts are in LCY';
        TotalsCaption = 'Total';
        // About the report labels
        AboutTheReportLabel = 'About the report';
        EnvironmentLabel = 'Environment';
        CompanyLabel = 'Company';
        UserLabel = 'User';
        RunOnLabel = 'Run on';
        ReportNameLabel = 'Report name';
        DocumentationLabel = 'Documentation';
    }

    trigger OnPreReport()
    begin
        // Ensures Layout Filter Headings are up to date
        UpdateRequestPageFilterValues();
    end;

    var
        PeriodTxt: Label 'Period: %1', Comment = '%1 - period text';
        SalespersonFilter: Text;
        CustLedgEntryFilter: Text;
        SalespersonFilterHeading: Text;
        CustLedgEntryFilterHeading: Text;
        PeriodText: Text;
        AdjProfit: Decimal;
        ProfitCommissionAmt: Decimal;
        AdjProfitCommissionAmt: Decimal;
        SalesCommissionAmt: Decimal;
        PrintOnlyOnePerPageReq: Boolean;
        PageGroupNo: Integer;
        // SubTotals for the Word Layout
        SubtotalsSales: Decimal;
        SubtotalsProfit: Decimal;
        SubtotalsAdjProfit: Decimal;
        SubtotalsSalesCommission: Decimal;
        SubtotalsProfitCommission: Decimal;
        SubtotalsAdjProfitCommission: Decimal;
        // Grand Totals for the Word Layout
        TotalsSales: Decimal;
        TotalsProfit: Decimal;
        TotalsAdjProfit: Decimal;
        TotalsSalesCommission: Decimal;
        TotalsProfitCommission: Decimal;
        TotalsAdjProfitCommission: Decimal;
        ReportHasData: Boolean;
#if not CLEAN27
        All_amounts_are_in_LCYCaptionLbl: Label 'All amounts are in LCY';
        TotalCaptionLbl: Label 'Total';
        Salesperson___CommissionCaptionLbl: Label 'Salesperson - Commission';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        Cust__Ledger_Entry__Posting_Date_CaptionLbl: Label 'Posting Date';
        SalesCommissionAmt_Control32CaptionLbl: Label 'Sales Commission (LCY)';
        ProfitCommissionAmt_Control33CaptionLbl: Label 'Profit Commission (LCY)';
        AdjProfit_Control39CaptionLbl: Label 'Net Sales Value (LCY)';
        AdjProfitCommissionAmt_Control45CaptionLbl: Label 'Adjusted Profit Commission (LCY)';
        Customer_Name: Text;
#endif

    local procedure ClearAmounts()
    begin
        Clear(AdjProfit);
        Clear(ProfitCommissionAmt);
        Clear(AdjProfitCommissionAmt);
        Clear(SalesCommissionAmt);
    end;

    local procedure UpdateRequestPageFilterValues()
    begin
        SalespersonFilter := "Salesperson/Purchaser".GetFilters();
        CustLedgEntryFilter := "Cust. Ledger Entry".GetFilters();
        PeriodText := "Cust. Ledger Entry".GetFilter("Posting Date");

        SalespersonFilterHeading := '';
        CustLedgEntryFilterHeading := '';
        if SalespersonFilter <> '' then
            SalespersonFilterHeading := "Salesperson/Purchaser".TableCaption + ': ' + SalespersonFilter;
        if CustLedgEntryFilter <> '' then
            CustLedgEntryFilterHeading := "Cust. Ledger Entry".TableCaption + ': ' + CustLedgEntryFilter;
    end;
}