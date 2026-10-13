WITH base_employee AS (
    SELECT
        emp_id,
        fname || ' ' || lname AS full_name,
        start_date,
        EXTRACT(YEAR FROM AGE(DATE '2025-01-01', start_date))::INT AS full_years,
        (start_date + INTERVAL '5 years')::DATE AS anniversary_5yr
    FROM employee
    WHERE end_date IS NULL
)

SELECT
    emp_id,
    full_name,
    start_date,
    full_years,
    anniversary_5yr,
    CASE
        WHEN full_years >= 10
        THEN 'Veteran'
        WHEN full_years BETWEEN 5 and 9
        THEN 'Senior'
        WHEN full_years BETWEEN 2 and 4
        THEN 'Middle'
        ELSE 'Junior'
    END AS seniority_level

FROM base_employee
ORDER BY full_years DESC;
