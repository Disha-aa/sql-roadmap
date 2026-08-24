SELECT cust_id
FROM loan

INTERSECT

SELECT cust_id
FROM credit_card;


SELECT cust_id
FROM loan

EXCEPT

SELECT cust_id
FROM credit_card;

SELECT cust_id
FROM credit_card

EXCEPT

SELECT cust_id
FROM loan;


WITH registry AS (
    SELECT cust_id FROM LOAN
    UNION
    SELECT cust_id FROM credit_card
)
SELECT
    ROUND(
        (SELECT COUNT(*) FROM registry) * 100.0 /
        (SELECT COUNT(*) FROM customer)
    ) as active_clients;