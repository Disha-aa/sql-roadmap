WITH account_debit_stats AS (
    SELECT
        account_id,
        COUNT(*) AS dbt_count,
        SUM(amount)::NUMERIC(15, 2) AS total_withdraw,
        MAX(amount)::NUMERIC(15, 2) AS max_single_dbt,
        ROUND(AVG(amount)::NUMERIC, 2) AS avg_dbt_amount

    FROM acc_transaction
    WHERE txn_type_cd = 'D'
    GROUP BY account_id
    HAVING COUNT(*) > 1 OR SUM(amount)::NUMERIC(15, 2) > 3000.00
)

SELECT
    account_id,
    dbt_count,
    total_withdraw,
    max_single_dbt,
    avg_dbt_amount

FROM account_debit_stats
ORDER BY total_withdraw DESC, dbt_count DESC
LIMIT 15;