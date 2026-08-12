SELECT card_id, cust_id, card_type, credit_limit, current_balance, available_credit, status
FROM credit_card
WHERE status IN ('ACTIVE', 'BLOCKED')
    AND (available_credit < 500 OR current_balance >= credit_limit * 0.8)
    AND account_id IS NOT NULL
    AND card_type NOT IN ('VISA', 'MasterCard');