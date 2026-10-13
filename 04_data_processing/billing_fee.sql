WITH step1_exact AS (
    SELECT
        txn_id,
        account_id,
        TO_CHAR(txn_date, 'DD.MM.YYYY HH24:MI') AS txn_formatted,
        txn_type_cd,    
        amount,
        CASE
            WHEN txn_type_cd = 'D' THEN amount * 0.0185
            ELSE 0.0000
        END AS exact_fee,
        CASE
            WHEN txn_type_cd = 'C' THEN amount
            ELSE -amount
        END AS cash_flow

    FROM acc_transaction
),

step2_audit AS (
    SELECT 
        *,
        ROUND(exact_fee, 2) AS charged_fee,
        ABS(exact_fee - ROUND(exact_fee, 2)) AS roundoff_error

    FROM step1_exact
)
    

SELECT
    txn_id,
    account_id,
    txn_formatted,
    txn_type_cd,    
    amount,
    exact_fee,
    charged_fee,
    roundoff_error,
    cash_flow
    
FROM step2_audit
WHERE roundoff_error > 0
ORDER BY roundoff_error DESC
LIMIT 10;