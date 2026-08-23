SELECT cust_id
FROM branch_feedback
WHERE cust_id IS NOT NULL
UNION
SELECT cust_id
FROM credit_card
ORDER BY cust_id;

SELECT cust_id
FROM branch_feedback
WHERE cust_id IS NOT NULL
INTERSECT
SELECT cust_id
FROM credit_card
ORDER BY cust_id;

SELECT cust_id
FROM branch_feedback
WHERE cust_id IS NOT NULL
EXCEPT
SELECT cust_id
FROM credit_card
ORDER BY cust_id;