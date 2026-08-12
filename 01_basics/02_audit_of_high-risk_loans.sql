SELECT loan_id, cust_id, principal_amount, interest_rate, monthly_payment, status
FROM loan
WHERE status in ('DEFAULTED', 'APPROVED')
AND (monthly_payment NOT BETWEEN 100.00 AND 500.00)
AND (interest_rate BETWEEN 5.0 AND 12.5)
ORDER BY interest_rate DESC, monthly_payment;