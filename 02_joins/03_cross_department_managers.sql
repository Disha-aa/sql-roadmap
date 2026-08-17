SELECT e.emp_id, e.fname, e.lname
FROM employee e INNER JOIN employee m 
    ON e.superior_emp_id = m.emp_id
WHERE e.dept_id != m.dept_id;