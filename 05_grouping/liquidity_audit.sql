SELECT
    open_branch_id,
    product_cd,
    COUNT(account_id) AS total_accounts,
    SUM(avail_balance)::NUMERIC(15, 2) AS total_avail_balance,
    ROUND(AVG(avail_balance)::NUMERIC, 2) AS avg_balance,
    MAX(avail_balance) AS max_balance
FROM account
WHERE status = 'ACTIVE'
GROUP BY open_branch_id, product_cd
HAVING SUM(avail_balance)::NUMERIC(15, 2) > 5000.0 AND COUNT(account_id) > 1
ORDER BY open_branch_id, total_avail_balance DESC;