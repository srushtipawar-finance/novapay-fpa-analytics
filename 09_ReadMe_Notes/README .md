# NovaPay FP&A Analytics & Management Reporting

Monthly FP&A reporting pack for **NovaPay, a fictional B2B payments company**, built from six months of data (Jan–Jun 2024).

The project follows the monthly cycle an FP&A analyst runs: take raw revenue, expense and budget data, build the P&L and budget-vs-actual in Excel, query it with SQL, run scenario analysis in Python, and present it in a Power BI dashboard, an executive report and a presentation deck.

> All company names, customers and figures are fictional. This is a portfolio project, not client or professional work.

---

## Dashboard Preview

![NovaPay Financial Performance Dashboard](08_Screenshots/Dashboard_Full_View.png)

---

## Key Findings

| Finding | Numbers (Jan–Jun 2024) | What it means |
| --- | --- | --- |
| Revenue grew, but EBITDA got worse | Monthly revenue $4.2K → $9.5K (+128%); EBITDA –$35.0K → –$37.7K | Gross profit rose $3.1K while operating expenses rose $5.9K. Growth alone is not closing the gap. |
| Beat budget on revenue, missed on EBITDA | Revenue $35.0K vs. $29.9K budget (+17%); opex over plan in all 6 months; EBITDA below budget in all 6 months | Cost overruns, mainly cloud hosting (+$5.1K) and marketing (+$4.9K), more than offset the revenue beat. |
| Customer concentration | TechStart Ltd = 39.8% of six-month revenue; top two customers = 59% | Losing a single account would materially reduce revenue. |
| Acquisition cost | Mar–Jun CAC $9.8K–$11.6K per new customer; revenue per customer under $2K/month | Each new customer takes many months of gross profit to pay back its acquisition cost. |
| Scenarios | Base / upside / downside July EBITDA: –$39.0K / –$38.3K / –$40.1K | Under all three sets of assumptions, EBITDA stays negative. Expense control matters more than growth rate. |

---

## Business Recommendations

* Put monthly spend reviews on cloud hosting and marketing, the two categories that ran over budget most often.
* Track CAC alongside revenue per customer to judge whether acquisition spend is paying back.
* Reduce dependence on the largest customer by broadening the customer base.
* Review budget vs. actual every month, at the line-item level, not just total revenue.
* Use the dashboard as the standard monthly management report.
* Revisit the scenario assumptions as more months of data become available.

---

## Tools and How They Were Used

| Tool | What I did with it |
| --- | --- |
| Excel | Structured tables (revenue, expenses, budget, KPIs, scenarios, date table); Monthly Summary, P&L and Budget vs. Actual sheets linked with SUMIFS / XLOOKUP; Scenario Analysis and CFO Summary sheets |
| SQL | 12 queries: revenue by stream and mix, top customers, expense variance by department, expense overruns, budget vs. actual revenue, gross margin, EBITDA, customer KPI trend, churn/CAC risk flags, executive KPI summary |
| Python (pandas) | Revenue bridge, budget vs. actual, expense overruns by category, customer concentration, CAC, and one-month base/upside/downside scenarios (same logic as the Excel scenario sheet) |
| Power BI | Data model with a date table; KPI cards, revenue trend, budget vs. actual, expense mix, revenue by customer, gross margin and CAC trends, month slicer |
| Word / PDF, PowerPoint | Executive report and presentation deck |

---

## Folder Structure

```text
├── 01_Data                  Raw CSV datasets
├── 02_Excel_Model           NovaPay_FPA_Model.xlsx
├── 03_SQL                   NovaPay_SQL_Queries.sql
├── 04_Python                NovaPay_Forecasting_Notebook.ipynb (run, with outputs)
├── 05_PowerBI               NovaPay_Financial_Dashboard.pbix
├── 06_Reports               Executive report (Word / PDF) and dashboard screenshots
├── 07_Presentation          NovaPay_FPA_Dashboard_Presentation.pptx
├── 08_Screenshots           Dashboard, presentation and report screenshots
├── 09_ReadMe_Notes          Project notes
└── README.md
```

---

## How to Open the Files

* `02_Excel_Model/NovaPay_FPA_Model.xlsx`: start with the **BvA_Report** tab (formatted budget vs. actual summary), then **P&L_Model**. The **Budget_vs_Actual** tab is the unformatted version that Power BI reads.
* `04_Python/NovaPay_Forecasting_Notebook.ipynb`: opens directly on GitHub with outputs; to re-run, run it from the `04_Python` folder.
* `05_PowerBI/NovaPay_Financial_Dashboard.pbix`: needs Power BI Desktop.
* `06_Reports/NovaPay_Executive_Report.pdf` and `07_Presentation/`: summary for a non-technical reader.

---

## Known Limitations

Being upfront about what the data can and cannot support:

* **Six months of data.** That is too short for a statistical forecast. The Python and Excel "forecast" is a one-month scenario analysis driven by stated assumptions, not a prediction.
* **Gross margin is an input.** Monthly gross margin (69% → 63%) is given in the KPI data, and COGS is derived from it. The decline is an assumption in the dataset, not something the model explains. Cloud hosting is booked in operating expenses; for a payments business it could reasonably sit in COGS.
* **Churn data conflict.** The KPI table records one lost customer in June, but the revenue table still bills all six customers that month. Churn figures should be read with that in mind.
* **Two budget totals.** Budget operating expenses in `Budget_Data` ($234.8K) differ from the sum of line-item budgets in `Expense_Data` ($231.5K) in March, April and June. The Excel Budget vs. Actual sheet uses `Budget_Data`; the expense-category analysis uses line items.
* **Rent is missing in March and June** (Professional Fees appears instead), so opex in those months may be understated.
* **CAC** is calculated as marketing spend ÷ new customers and excludes sales payroll. It is undefined in February (no new customers).

---

## Author

**Srushti Mahant Pawar**, MS Finance, Naveen Jindal School of Management, UT Dallas
FP&A analytics portfolio project · Excel | SQL | Python | Power BI
