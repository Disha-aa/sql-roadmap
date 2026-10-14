WITH prepared_accounts AS (
    SELECT
        a.account_id,

        'ACC#' || a.account_id 
            || ' [' || p.product_cd || ': ' || p.name 
            || '] | CUST#' || a.cust_id 
            || ' | STATUS: ' || a.status AS account_passport,

        '$'|| a.avail_balance AS formatted_balance,

        CASE
            WHEN (a.avail_balance + a.pending_balance) = 0 OR a.avail_balance IS NULL
            THEN 0.0
            ELSE ROUND((a.avail_balance / (a.avail_balance + a.pending_balance)) * 100.0, 1)
        END AS liquidity_raw


    FROM account a INNER JOIN product p
        ON a.product_cd = p.product_cd
        INNER JOIN customer c
            ON a.cust_id = c.cust_id
)

SELECT
    account_id,
    account_passport,
    formatted_balance,
    liquidity_raw::text || '%' AS liquidity_pct,
    CASE
        WHEN liquidity_raw >= 80.0 THEN 'HIGH_LIQUIDITY'
        WHEN liquidity_raw >= 40.0 THEN 'MODERATE'
        ELSE 'LOW_LIQUIDITY'
    END AS risk_category



FROM prepared_accounts
ORDER BY account_id
LIMIT 15;