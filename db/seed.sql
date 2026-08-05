INSERT INTO department (dept_id, name) VALUES 
(1, 'Operations'),
(2, 'Loans'),
(3, 'Administration'),
(4, 'IT');


INSERT INTO branch (branch_id, name, address, city, state, zip) VALUES 
(1, 'Headquarters', '388 Main St.', 'Waltham', 'MA', '02451'),
(2, 'Waltham Branch', '102 River St.', 'Waltham', 'MA', '02453'),
(3, 'Woburn Branch', '422 Maple St.', 'Woburn', 'MA', '01801');


INSERT INTO employee (emp_id, fname, lname, start_date, title, assigned_branch_id, dept_id, superior_emp_id) VALUES 
(1, 'Michael', 'Smith', '2001-06-22', 'President', 1, 3, NULL),
(2, 'Susan', 'Barker', '2002-09-12', 'Vice President', 1, 3, 1),
(3, 'Robert', 'Tyler', '2000-02-09', 'Treasurer', 1, 3, 1),
(4, 'Susan', 'Hawthorne', '2002-04-24', 'Operations Mgr', 1, 1, 3),
(5, 'John', 'Gooding', '2003-11-14', 'Loan Manager', 1, 2, 2),
(6, 'Helen', 'Fleming', '2004-03-17', 'Head Teller', 2, 1, 4),
(7, 'Chris', 'Tucker', '2004-09-15', 'Teller', 2, 1, 6),
(8, 'Sarah', 'Parker', '2002-12-02', 'Teller', 3, 1, 6);


INSERT INTO customer (cust_id, fed_id, cust_type_cd, address, city, state, postal_code) VALUES 
(1, '111-11-1111', 'I', '18 Ball Rd.', 'Waltham', 'MA', '02451'),
(2, '222-22-2222', 'I', '22 Oak St.', 'Waltham', 'MA', '02453'),
(3, '333-33-3333', 'I', '412 Salem St.', 'Woburn', 'MA', '01801'),
(4, '444-44-4444', 'I', '128 Pleasant St.', 'Quincy', 'MA', '02169'),
(5, '10-1111111', 'B', '100 Corporate Dr.', 'Woburn', 'MA', '01801');


INSERT INTO product (product_cd, name, product_type_cd) VALUES 
('CHK', 'Checking Account', 'ACCOUNT'),
('SAV', 'Savings Account', 'ACCOUNT'),
('CD', 'Certificate of Deposit', 'ACCOUNT'),
('MRT', 'Mortgage Loan', 'LOAN');


INSERT INTO account (account_id, product_cd, cust_id, open_date, status, open_branch_id, open_emp_id, avail_balance, pending_balance) VALUES 
(1, 'CHK', 1, '2000-01-15', 'ACTIVE', 1, 1, 1050.00, 1050.00),
(2, 'SAV', 1, '2000-01-15', 'ACTIVE', 1, 1, 500.00, 500.00),
(3, 'CHK', 2, '2001-03-12', 'ACTIVE', 2, 6, 2250.75, 2250.75),
(4, 'CHK', 3, '2002-05-23', 'ACTIVE', 3, 8, 100.00, 100.00),
(5, 'CD', 5, '2004-06-30', 'ACTIVE', 1, 1, 10000.00, 10000.00);


INSERT INTO acc_transaction (txn_id, txn_date, account_id, txn_type_cd, amount, teller_emp_id, execution_branch_id) VALUES 
(1, '2004-01-05 10:11:00', 1, 'C', 1000.00, 7, 1),
(2, '2004-01-06 14:22:00', 1, 'D', 50.00, 7, 1),
(3, '2004-01-10 09:15:00', 3, 'C', 500.00, 6, 2),
(4, '2004-01-12 11:45:00', 2, 'D', 100.00, 7, 1),
(5, '2004-01-15 16:30:00', 4, 'C', 200.00, 8, 3);