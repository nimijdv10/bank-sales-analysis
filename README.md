# Bank Sales Campaign Data Analysis

## Business Question
Which customer segments and contact strategies drive term deposit 
conversions and where is the bank misallocating its call centre resources?

## Dataset
UCI Bank Marketing dataset | 45,211 records | 20 features

## Tools
SQL (SQLite) · Python (pandas, matplotlib, seaborn, scikit-learn) · Excel · Power BI

## Key Findings
 
### 1. Segment misallocation (job type)
| Segment | Conv. Rate | Index vs Avg | Call Volume |
|---|---|---|---|
| Student | 28.68% | 2.45x | 2% of calls |
| Retired | 22.79% | 1.94x | 5% of calls |
| Blue-collar | 7.27% | 0.62x | **21.5% of calls** |
 
The bank's highest-converting segments receive the least call volume; its lowest-converting segment receives nearly a quarter of all outreach.
 
### 2. Contact frequency
Conversion rate falls from **14.6%** on the first contact attempt to below the 11.70% average by the 2nd attempt. Repeated re-contact of unresponsive customers consumes capacity with no return.
 
### 3. Previous campaign relationship, the strongest single lever
| Previous Outcome | Conv. Rate | vs Avg |
|---|---|---|
| Success | 64.73% | 5.5x |
| Other | 16.68% | 1.4x |
| Failure | 12.61% | 1.07x |
| Never contacted | 9.16% | 0.78x |
 
Customers with a prior successful outcome convert at nearly **5.5x** the bank average and yet represent only 3.3% of total call volume (1,511 of 45,211).
 
### 4. Call duration × prior relationship 
Cross-tabulating call duration (under/over 5 minutes) against previous outcome reveals that **65.6% of all calls** fall into the single worst-performing cell: new/unknown customers whose calls end within 5 minutes, converting at just **3.44%**.
 
| Prior Outcome | Under 5 min | Over 5 min | Lift from engagement |
|---|---|---|---|
| Unknown (new contact) | 3.44% | 24.72% | **7.2x** |
| Success | 56.52% | 77.50% | 1.4x |
 
For new contacts the first 5 minutes engagement threshold is where conversion is won or lost. This points to call scripting and agent training as a complementary lever to list targeting.
 
### 5. Seasonality
March converts at **51.99%** vs May at **6.72%**, a 7.7x gap and yet May receives 33% of total call volume while March receives under 1%.
 
## Predictive Model
 
A decision tree classifier (`max_depth=5`, `class_weight='balanced'`) was trained to validate EDA findings against the full feature set without relying solely on initial hypotheses.
 
| Feature | Importance | Actionable Pre-Call? |
|---|---|---|
| duration | 56.9% | No — known only after contact |
| poutcome (success) | 29.9% | **Yes** — strongest actionable signal |
| age | 5.0% | Yes |
| month (March) | 4.0% | Yes |
| contact method unknown | 1.8% | Yes |
 
**Model performance (minority class — "yes"):** Recall 0.71, Precision 0.35, F1 0.47. Recall was prioritized over precision: the cost of an extra call (false positive) is low, while the cost of missing a genuine prospect (false negative) is high.
 
The model's top feature (`duration`) is not independently actionable but follow-up analysis (finding #4) showed it is not redundant with `poutcome` either; both carry distinct information, and together they reveal where the 65.6% majority of "cold" call volume is being lost.
 

## Recommendation
1. **Reallocate segment volume** — shift call effort toward student and retired segments, away from blue-collar (estimated 2,000+ additional annual conversions from the same total call volume)
2. **Prioritize warm leads first** — customers with `poutcome=success` should be called before any cold list, regardless of segment (5.8x conversion rate, currently under-prioritized)
3. **Cap contact attempts at 3** — conversion falls below average after the 3rd attempt; reallocate that capacity to fresh contacts
4. **Invest in call scripting/agent training for cold contacts** — the 5-minute engagement threshold separates 3.44% from 24.72% conversion for the 65.6% of calls with no prior relationship
5. **Shift campaign timing toward Q1/Q4** — March, September, October convert 4-8x better than summer months currently receiving the bulk of volume

## Repository Structure
 
```
bank-telemarketing-analysis/
├── README.md
├── notebooks/
│   └── bank_analysis.ipynb       # SQL, Python EDA, model, charts
├── data/
│   └── bank_powerbi.csv
├── excel/
│   └── bank_key_findings.xlsx    # Summary + segment breakdowns
├── sql/
│   └── queries.sql
└── dashboard/
    └── dashboard_preview.png     # Power BI dashboard screenshot
```
