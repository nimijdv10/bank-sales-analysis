
-- ============================================
-- BANK SALES ANALYSIS — SQL QUERIES
-- ============================================

-- 1. Overall conversion rate
SELECT
    COUNT(*) as total_called,
    SUM(CASE WHEN y='yes' THEN 1 ELSE 0 END) as converted,
    ROUND(100.0 * SUM(CASE WHEN y='yes' THEN 1 ELSE 0 END) / COUNT(*), 2) as conv_rate
FROM bank_calls;

-- 2. Conversion rate by job
SELECT job,
    COUNT(*) as total,
    SUM(CASE WHEN y='yes' THEN 1 ELSE 0 END) as converted,
    ROUND(100.0 * SUM(CASE WHEN y='yes' THEN 1 ELSE 0 END) / COUNT(*), 2) as conv_rate,
    ROUND(100.0 * SUM(CASE WHEN y='yes' THEN 1 ELSE 0 END) /
        (SELECT SUM(CASE WHEN y='yes' THEN 1 ELSE 0 END) FROM bank_calls), 2) as pct_of_conversions
FROM bank_calls
WHERE job != 'unknown'
GROUP BY job
ORDER BY conv_rate DESC;

-- 3. Conversion rate by education
SELECT education,
    COUNT(*) as total,
    SUM(CASE WHEN y='yes' THEN 1 ELSE 0 END) as converted,
    ROUND(100.0 * SUM(CASE WHEN y='yes' THEN 1 ELSE 0 END) / COUNT(*), 2) as conv_rate
FROM bank_calls
WHERE education != 'unknown'
GROUP BY education
ORDER BY conv_rate DESC;

-- 4. Two-variable segmentation: job x education
SELECT job, education,
    COUNT(*) as total,
    ROUND(100.0 * SUM(CASE WHEN y='yes' THEN 1 ELSE 0 END) / COUNT(*), 2) as conv_rate
FROM bank_calls
WHERE education != 'unknown' AND job != 'unknown'
GROUP BY job, education
HAVING total > 100
ORDER BY conv_rate DESC
LIMIT 10;

-- 5. Conversion rate by contact attempt (campaign)
SELECT campaign,
    COUNT(*) as total,
    ROUND(100.0 * SUM(CASE WHEN y='yes' THEN 1 ELSE 0 END) / COUNT(*), 2) as conv_rate
FROM bank_calls
GROUP BY campaign
HAVING COUNT(*) > 50
ORDER BY campaign;

-- 6. Conversion rate by month
SELECT month,
    COUNT(*) as total,
    ROUND(100.0 * SUM(CASE WHEN y='yes' THEN 1 ELSE 0 END) / COUNT(*), 2) as conv_rate,
    ROUND(100.0 * SUM(CASE WHEN y='yes' THEN 1 ELSE 0 END) /
        (SELECT SUM(CASE WHEN y='yes' THEN 1 ELSE 0 END) FROM bank_calls), 2) as pct_conv_rate
FROM bank_calls
GROUP BY month
ORDER BY conv_rate DESC;


-- 8. Conversion by previous campaign outcome
SELECT poutcome,
    COUNT(*) as total,
    SUM(CASE WHEN y='yes' THEN 1 ELSE 0 END) as converted,
    ROUND(100.0 * SUM(CASE WHEN y='yes' THEN 1 ELSE 0 END) / COUNT(*), 2) as conv_rate
FROM bank_calls
GROUP BY poutcome
ORDER BY conv_rate DESC;

-- 9. Conversion by poutcome and duration
SELECT 
    poutcome,
    CASE 
        WHEN duration_min <= 5 THEN 'under_5min'
        ELSE 'over_5min'
    END as duration_bucket,
    COUNT(*) as total,
    ROUND(100.0 * SUM(CASE WHEN y='yes' THEN 1 ELSE 0 END) / COUNT(*), 2) as conv_rate
FROM bank_calls
GROUP BY poutcome, duration_bucket
ORDER BY poutcome, duration_bucket;
