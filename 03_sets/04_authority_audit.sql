SELECT approved_by_emp_id 
FROM loan 
WHERE approved_by_emp_id  IS NOT NULL

UNION

SELECT issued_by_emp_id
FROM credit_card
WHERE issued_by_emp_id IS NOT NULL;


SELECT approved_by_emp_id
FROM loan
WHERE approved_by_emp_id  IS NOT NULL

INTERSECT

SELECT issued_by_emp_id
FROM credit_card
WHERE issued_by_emp_id IS NOT NULL;


WITH emp_registry AS (
    SELECT approved_by_emp_id AS emp_id
    FROM loan
    WHERE approved_by_emp_id  IS NOT NULL
    UNION
    SELECT issued_by_emp_id
    FROM credit_card
    WHERE issued_by_emp_id IS NOT NULL
)

SELECT emp_id
FROM employee
WHERE emp_id IS NOT NULL

EXCEPT

SELECT emp_id
FROM emp_registry;


WITH active_emps AS (
    SELECT approved_by_emp_id AS emp_id
    FROM loan
    WHERE approved_by_emp_id IS NOT NULL
    UNION
    SELECT issued_by_emp_id
    FROM credit_card
    WHERE issued_by_emp_id IS NOT NULL
),
passive_emps AS (
    SELECT emp_id FROM employee 
    EXCEPT 
    SELECT emp_id FROM active_emps
)

SELECT 
    e.emp_id, 
    e.fname, 
    e.lname, 
    e.title
FROM passive_emps pe
JOIN employee e ON pe.emp_id = e.emp_id;
