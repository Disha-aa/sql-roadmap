SELECT 
    e.fname || ' ' || e.lname AS person_id,
    'EMPLOYEE' AS person_type,
    b.city AS city
FROM employee e
JOIN branch b on e.assigned_branch_id = b.branch_id

UNION

SELECT
    c.fed_id AS person_id,
    'CUSTOMER' AS person_type,
    c.city AS city
FROM customer c
WHERE c.cust_type_cd = 'I'
ORDER BY city;