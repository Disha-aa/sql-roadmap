SELECT
    COALESCE(open_branch_id::TEXT, 'ALL BRANCHES') AS branch,
    COALESCE(product_cd, 'BRANCH TOTAL') AS product,
    COUNT(*) AS accounts_cnt,
    SUM(avail_balance)::NUMERIC(15, 2) AS total_balance

FROM account
WHERE status = 'ACTIVE'
GROUP BY ROLLUP(open_branch_id, product_cd)
ORDER BY open_branch_id NULLS LAST, product_cd NULLS LAST;