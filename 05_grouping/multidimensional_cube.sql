SELECT
    COALESCE(a.status, 'ALL STATUSES') AS account_status,
    COALESCE(c.cust_type_cd, 'ALL TYPES') AS cust_type,
    COUNT(*) AS accounts_cnt,
    SUM(a.pending_balance)::NUMERIC(15, 2) AS total_pending

FROM account a INNER JOIN customer c
    ON a.cust_id = c.cust_id
GROUP BY CUBE(c.cust_type_cd, a.status)
ORDER BY a.status NULLS LAST, c.cust_type_cd NULLS LAST;