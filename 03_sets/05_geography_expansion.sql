SELECT city, COUNT(*) AS client_count
FROM customer
WHERE city IN (
    SELECT city FROM customer
    EXCEPT
    SELECT city FROM branch
)
GROUP BY city
ORDER BY client_count DESC;


SELECT city FROM branch

EXCEPT

SELECT city FROM customer;


SELECT city FROM customer

INTERSECT

SELECT city FROM branch;