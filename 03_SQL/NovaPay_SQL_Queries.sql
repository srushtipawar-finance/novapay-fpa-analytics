/* 
NovaPay FP&A Analytics & Management Reporting
NovaPay Analytics - SQL Financial Reporting Queries
*/


/* 1. Monthly Revenue by Stream */
SELECT
    Month_Label,
    Month_Number,
    SUM(Subscription_Revenue)        AS subscription_revenue,
    SUM(Transaction_Fee_Revenue)     AS transaction_fee_revenue,
    SUM(Premium_Analytics_Revenue)   AS premium_analytics_revenue,
    SUM(Setup_Fee_Revenue)           AS setup_fee_revenue,
    SUM(Total_Revenue)               AS total_revenue
FROM Revenue_Data
GROUP BY Month_Label, Month_Number
ORDER BY Month_Number;


/* 2. Revenue Mix by Month */
SELECT
    Month_Label,
    Month_Number,
    SUM(Subscription_Revenue)                                                        AS subscription_revenue,
    SUM(Transaction_Fee_Revenue)                                                     AS transaction_fee_revenue,
    SUM(Premium_Analytics_Revenue)                                                   AS premium_analytics_revenue,
    SUM(Setup_Fee_Revenue)                                                           AS setup_fee_revenue,
    SUM(Total_Revenue)                                                               AS total_revenue,
    ROUND(SUM(Subscription_Revenue)      * 1.0 / SUM(Total_Revenue), 4)             AS subscription_revenue_mix,
    ROUND(SUM(Transaction_Fee_Revenue)   * 1.0 / SUM(Total_Revenue), 4)             AS transaction_fee_revenue_mix,
    ROUND(SUM(Premium_Analytics_Revenue) * 1.0 / SUM(Total_Revenue), 4)             AS premium_revenue_mix,
    ROUND(SUM(Setup_Fee_Revenue)         * 1.0 / SUM(Total_Revenue), 4)             AS setup_fee_revenue_mix
FROM Revenue_Data
GROUP BY Month_Label, Month_Number
ORDER BY Month_Number;


/* 3. Top Customers by Total Revenue */
SELECT
    r.Customer_ID,
    c.Customer_Name,
    SUM(r.Total_Revenue) AS total_revenue
FROM Revenue_Data r
LEFT JOIN Customers c ON r.Customer_ID = c.Customer_ID
GROUP BY r.Customer_ID, c.Customer_Name
ORDER BY total_revenue DESC;


/* 4. Monthly Expense Variance by Department */
SELECT
    Month_Label,
    Month_Number,
    Department,
    SUM(Budget_Expense)                                                                         AS budget_expense,
    SUM(Actual_Expense)                                                                         AS actual_expense,
    SUM(Actual_Expense) - SUM(Budget_Expense)                                                   AS expense_variance,
    ROUND((SUM(Actual_Expense) - SUM(Budget_Expense)) * 1.0 / SUM(Budget_Expense), 4)          AS expense_variance_pct
FROM Expense_Data
GROUP BY Month_Label, Month_Number, Department
ORDER BY Month_Number, Department;


/* 5. Expense Overrun Analysis */
SELECT
    Month_Label,
    Month_Number,
    Department,
    Expense_Category,
    Vendor,
    Budget_Expense,
    Actual_Expense,
    Actual_Expense - Budget_Expense                                         AS expense_variance,
    ROUND((Actual_Expense - Budget_Expense) * 1.0 / Budget_Expense, 4)     AS expense_variance_pct
FROM Expense_Data
WHERE Actual_Expense > Budget_Expense
ORDER BY expense_variance DESC;


/* 6. Budget vs Actual Revenue Variance */
SELECT
    b.Month_Label,
    b.Month_Number,
    b.Budget_Total_Revenue,
    r.Actual_Total_Revenue,
    r.Actual_Total_Revenue - b.Budget_Total_Revenue                                             AS revenue_variance,
    ROUND((r.Actual_Total_Revenue - b.Budget_Total_Revenue) * 1.0 / b.Budget_Total_Revenue, 4) AS revenue_variance_pct
FROM Budget_Data b
JOIN (
    SELECT
        Month_Number,
        SUM(Total_Revenue) AS Actual_Total_Revenue
    FROM Revenue_Data
    GROUP BY Month_Number
) r ON b.Month_Number = r.Month_Number
ORDER BY b.Month_Number;


/* 7. Monthly Gross Profit and Gross Margin */
SELECT
    Month_Label,
    Month_Number,
    Actual_Revenue,
    Actual_COGS,
    Gross_Profit,
    Gross_Margin
FROM Monthly_Summary
ORDER BY Month_Number;


/* 8. Monthly EBITDA and EBITDA Margin */
SELECT
    Month_Label,
    Month_Number,
    Actual_Revenue,
    Actual_Expenses,
    Actual_COGS,
    EBITDA,
    EBITDA_Margin
FROM Monthly_Summary
ORDER BY Month_Number;


/* 9. Customer KPI Trend */
SELECT
    Month_Label,
    Month_Number,
    Active_Customers,
    New_Customers,
    Lost_Customers,
    Churn_Rate,
    Average_Revenue_Per_Customer,
    CAC,
    Gross_Margin,
    Net_Revenue_Retention
FROM KPI_Data
ORDER BY Month_Number;


/* 10. Churn and CAC Risk Review */
SELECT
    Month_Label,
    Month_Number,
    Active_Customers,
    Lost_Customers,
    Churn_Rate,
    CAC,
    Net_Revenue_Retention,
    CASE
        WHEN Churn_Rate >= 0.08 THEN 'High Churn Risk'
        WHEN Churn_Rate >= 0.04 THEN 'Moderate Churn Risk'
        ELSE 'Low Churn Risk'
    END AS churn_risk_flag,
    CASE
        WHEN CAC >= 10000 THEN 'High CAC'
        WHEN CAC >= 5000  THEN 'Moderate CAC'
        ELSE 'Low CAC'
    END AS cac_risk_flag
FROM KPI_Data
ORDER BY Month_Number;


/* 11. Scenario Input Review */
SELECT
    Scenario,
    Customer_Growth_Rate,
    Churn_Rate,
    Transaction_Volume_Growth,
    Pricing_Increase,
    CAC_Change,
    Payroll_Inflation,
    Marketing_Spend_Change
FROM Scenario_Inputs
ORDER BY Scenario;


/* 12. Executive KPI Summary */
SELECT
    r.Month_Number,
    d.Month_Label,
    r.Actual_Total_Revenue,
    e.Actual_Operating_Expenses,
    k.Active_Customers,
    k.Churn_Rate,
    k.CAC,
    k.Gross_Margin,
    k.Net_Revenue_Retention
FROM (
    SELECT Month_Number, SUM(Total_Revenue) AS Actual_Total_Revenue
    FROM Revenue_Data
    GROUP BY Month_Number
) r
JOIN (
    SELECT Month_Number, SUM(Actual_Expense) AS Actual_Operating_Expenses
    FROM Expense_Data
    GROUP BY Month_Number
) e ON r.Month_Number = e.Month_Number
JOIN KPI_Data k     ON r.Month_Number = k.Month_Number
JOIN Date_Table d   ON r.Month_Number = d.Month_Number
ORDER BY r.Month_Number;