# Bank Sales Campaign Data Analysis

## Business Question
Which customer segments and contact strategies drive term deposit 
conversions and where is the bank misallocating its call centre resources?

## Dataset
UCI Bank Marketing dataset | 45,211 records | 20 features

## Tools
SQL (SQLite) · Python (pandas, matplotlib, seaborn, scikit-learn) · Excel · Power BI

## Key Findings
1. **WHO should the bank be calling**: Student segment converts at 29.72% which is 2.6x the 11.27% average. On the other hand, Blue-collar receives 24% of calls but converts at only 7.27%
2. **WHEN should the bank be calling**: March converts at 51.99% but represents 1% of the calls. May converts at 6.72% but represents 30.4% calls, the single highest-volume month is the worst performing month.
3. **HOW often should the bank be calling the same person**: Conversion rate is 14.6% at the first attempt. It drops a bit below average by the second and third attempt. It drops drastically after the forth call.

## Recommendation
Redirect 30% of blue-collar call volume to student and retired segments.
Cap outreach at 3 attempts. Prioritise previous subscribers before cold calls.
Estimated impact: 2,000+ additional conversions annually at zero extra cost.
