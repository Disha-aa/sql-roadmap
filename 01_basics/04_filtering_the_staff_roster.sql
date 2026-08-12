SELECT emp_id, fname, lname, start_date, end_date
FROM employee
WHERE superior_emp_id IS NOT NULL
    AND start_date BETWEEN '2012-01-01' AND '2020-12-31'
    AND (end_date IS NULL OR end_date > '2023-01-01')
    AND title NOT IN ('Teller', 'Junior Teller');