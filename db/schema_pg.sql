-- Drop existing tables with CASCADE for PostgreSQL
DROP TABLE IF EXISTS branch_feedback CASCADE;
DROP TABLE IF EXISTS credit_card CASCADE;
DROP TABLE IF EXISTS loan CASCADE;
DROP TABLE IF EXISTS acc_transaction CASCADE;
DROP TABLE IF EXISTS account CASCADE;
DROP TABLE IF EXISTS product CASCADE;
DROP TABLE IF EXISTS customer CASCADE;
DROP TABLE IF EXISTS employee CASCADE;
DROP TABLE IF EXISTS department CASCADE;
DROP TABLE IF EXISTS branch CASCADE;

-- 1. Independent parent tables
CREATE TABLE branch (
    branch_id SERIAL PRIMARY KEY,
    name VARCHAR(20) NOT NULL,
    address VARCHAR(30),
    city VARCHAR(20),
    state VARCHAR(2),
    zip VARCHAR(10)
);

CREATE TABLE department (
    dept_id SERIAL PRIMARY KEY,
    name VARCHAR(20) NOT NULL
);

-- 2. Employee (depends on branch, department, self)
CREATE TABLE employee (
    emp_id SERIAL PRIMARY KEY,
    fname VARCHAR(20) NOT NULL,
    lname VARCHAR(20) NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE,
    title VARCHAR(20),
    assigned_branch_id INT REFERENCES branch(branch_id),
    dept_id INT REFERENCES department(dept_id),
    superior_emp_id INT REFERENCES employee(emp_id)
);

-- 3. Customer & Product
CREATE TABLE customer (
    cust_id SERIAL PRIMARY KEY,
    fed_id VARCHAR(12) NOT NULL,
    cust_type_cd VARCHAR(1) NOT NULL CHECK(cust_type_cd IN ('I', 'B')),
    address VARCHAR(30),
    city VARCHAR(20),
    state VARCHAR(2),
    postal_code VARCHAR(10)
);

CREATE TABLE product (
    product_cd VARCHAR(10) PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    product_type_cd VARCHAR(10) NOT NULL
);

-- 4. Account (depends on product, customer, branch, employee)
CREATE TABLE account (
    account_id SERIAL PRIMARY KEY,
    product_cd VARCHAR(10) REFERENCES product(product_cd),
    cust_id INT REFERENCES customer(cust_id),
    open_date DATE NOT NULL,
    close_date DATE,
    last_activity_date DATE,
    status VARCHAR(10) CHECK(status IN ('ACTIVE', 'CLOSED', 'FROZEN')),
    open_branch_id INT REFERENCES branch(branch_id),
    open_emp_id INT REFERENCES employee(emp_id),
    avail_balance NUMERIC(10,2),
    pending_balance NUMERIC(10,2)
);

-- 5. Transactions
CREATE TABLE acc_transaction (
    txn_id SERIAL PRIMARY KEY,
    txn_date TIMESTAMP NOT NULL,
    account_id INT REFERENCES account(account_id),
    txn_type_cd VARCHAR(1) CHECK(txn_type_cd IN ('C', 'D')),
    amount NUMERIC(10,2) NOT NULL,
    teller_emp_id INT REFERENCES employee(emp_id),
    execution_branch_id INT REFERENCES branch(branch_id)
);

-- 6. Loans
CREATE TABLE loan (
    loan_id SERIAL PRIMARY KEY,
    account_id INT REFERENCES account(account_id),
    cust_id INT REFERENCES customer(cust_id),
    loan_type VARCHAR(20) NOT NULL,
    principal_amount NUMERIC(12,2) NOT NULL,
    interest_rate NUMERIC(5,2) NOT NULL,
    term_months INT NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE,
    monthly_payment NUMERIC(10,2) NOT NULL,
    status VARCHAR(10) CHECK(status IN ('ACTIVE', 'PAID', 'DEFAULTED', 'APPROVED')),
    approved_by_emp_id INT REFERENCES employee(emp_id)
);

-- 7. Credit Cards
CREATE TABLE credit_card (
    card_id SERIAL PRIMARY KEY,
    cust_id INT REFERENCES customer(cust_id),
    account_id INT REFERENCES account(account_id),
    card_number VARCHAR(16) NOT NULL UNIQUE,
    card_type VARCHAR(20) NOT NULL,
    credit_limit NUMERIC(10,2) NOT NULL,
    current_balance NUMERIC(10,2) DEFAULT 0.00,
    available_credit NUMERIC(10,2) NOT NULL,
    expiry_date DATE NOT NULL,
    status VARCHAR(10) CHECK(status IN ('ACTIVE', 'BLOCKED', 'EXPIRED', 'CLOSED')),
    issued_by_branch_id INT REFERENCES branch(branch_id),
    issued_by_emp_id INT REFERENCES employee(emp_id)
);

-- 8. Branch Feedback
CREATE TABLE branch_feedback (
    feedback_id SERIAL PRIMARY KEY,
    branch_id INT NOT NULL REFERENCES branch(branch_id),
    cust_id INT REFERENCES customer(cust_id),
    emp_id INT REFERENCES employee(emp_id),
    rating INT CHECK(rating BETWEEN 1 AND 5),
    comment TEXT,
    feedback_date DATE NOT NULL,
    feedback_type VARCHAR(20) CHECK(feedback_type IN ('COMPLAINT', 'COMPLIMENT', 'SUGGESTION', 'GENERAL'))
);
