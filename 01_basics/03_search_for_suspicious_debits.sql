SELECT * FROM acc_transaction
WHERE txn_type_cd = 'D'
    AND txn_date LIKE '2024-%'
    AND teller_emp_id IS NOT NULL
    AND amount > 1000.00
ORDER BY amount DESC; 