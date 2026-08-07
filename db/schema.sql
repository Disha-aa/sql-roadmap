PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS acc_transaction;
DROP TABLE IF EXISTS account;
DROP TABLE IF EXISTS product;
DROP TABLE IF EXISTS customer;
DROP TABLE IF EXISTS employee;
DROP TABLE IF EXISTS department;
DROP TABLE IF EXISTS branch;
DROP TABLE IF EXISTS branch_feedback;
DROP TABLE IF EXISTS credit_card;
DROP TABLE IF EXISTS loan;

CREATE TABLE loan (
    loan_id INTEGER PRIMARY KEY AUTOINCREMENT,
    account_id INT NOT NULL,
    cust_id INT NOT NULL,
    loan_type VARCHAR(20) NOT NULL,
    principal_amount DECIMAL(12,2) NOT NULL,
    interest_rate DECIMAL(5,2) NOT NULL,
    term_months INT NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE,
    monthly_payment DECIMAL(10,2) NOT NULL,
    status VARCHAR(10) CHECK(status IN ('ACTIVE', 'PAID', 'DEFAULTED', 'APPROVED')),
    approved_by_emp_id INT,
    FOREIGN KEY (account_id) REFERENCES account (account_id),
    FOREIGN KEY (cust_id) REFERENCES customer (cust_id),
    FOREIGN KEY (approved_by_emp_id) REFERENCES employee (emp_id)
);

CREATE TABLE credit_card (
    card_id INTEGER PRIMARY KEY AUTOINCREMENT,
    cust_id INT NOT NULL,
    account_id INT,
    card_number VARCHAR(16) NOT NULL UNIQUE,
    card_type VARCHAR(20) NOT NULL,
    credit_limit DECIMAL(10,2) NOT NULL,
    current_balance DECIMAL(10,2) DEFAULT 0.00,
    available_credit DECIMAL(10,2) NOT NULL,
    expiry_date DATE NOT NULL,
    status VARCHAR(10) CHECK(status IN ('ACTIVE', 'BLOCKED', 'EXPIRED', 'CLOSED')),
    issued_by_branch_id INT,
    issued_by_emp_id INT,
    FOREIGN KEY (cust_id) REFERENCES customer (cust_id),
    FOREIGN KEY (account_id) REFERENCES account (account_id),
    FOREIGN KEY (issued_by_branch_id) REFERENCES branch (branch_id),
    FOREIGN KEY (issued_by_emp_id) REFERENCES employee (emp_id)
);

CREATE TABLE branch_feedback (
    feedback_id INTEGER PRIMARY KEY AUTOINCREMENT,
    branch_id INT NOT NULL,
    cust_id INT,
    emp_id INT,
    rating INT CHECK(rating BETWEEN 1 AND 5),
    comment TEXT,
    feedback_date DATE NOT NULL,
    feedback_type VARCHAR(20) CHECK(feedback_type IN ('COMPLAINT', 'COMPLIMENT', 'SUGGESTION', 'GENERAL')),
    FOREIGN KEY (branch_id) REFERENCES branch (branch_id),
    FOREIGN KEY (cust_id) REFERENCES customer (cust_id),
    FOREIGN KEY (emp_id) REFERENCES employee (emp_id)
);

CREATE TABLE branch (
    branch_id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(20) NOT NULL,
    address VARCHAR(30),
    city VARCHAR(20),
    state VARCHAR(2),
    zip VARCHAR(10)
);

CREATE TABLE department (
    dept_id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(20) NOT NULL
);

CREATE TABLE employee (
    emp_id INTEGER PRIMARY KEY AUTOINCREMENT,
    fname VARCHAR(20) NOT NULL,
    lname VARCHAR(20) NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE,
    title VARCHAR(20),
    assigned_branch_id INT,
    dept_id INT,
    superior_emp_id INT,
    FOREIGN KEY (assigned_branch_id) REFERENCES branch (branch_id),
    FOREIGN KEY (dept_id) REFERENCES department (dept_id),
    FOREIGN KEY (superior_emp_id) REFERENCES employee (emp_id)
);

CREATE TABLE customer (
    cust_id INTEGER PRIMARY KEY AUTOINCREMENT,
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

CREATE TABLE account (
    account_id INTEGER PRIMARY KEY AUTOINCREMENT,
    product_cd VARCHAR(10) NOT NULL,
    cust_id INT NOT NULL,
    open_date DATE NOT NULL,
    close_date DATE,
    last_activity_date DATE,
    status VARCHAR(10) CHECK(status IN ('ACTIVE', 'CLOSED', 'FROZEN')),
    open_branch_id INT,
    open_emp_id INT,
    avail_balance DECIMAL(10,2),
    pending_balance DECIMAL(10,2),
    FOREIGN KEY (product_cd) REFERENCES product (product_cd),
    FOREIGN KEY (cust_id) REFERENCES customer (cust_id),
    FOREIGN KEY (open_branch_id) REFERENCES branch (branch_id),
    FOREIGN KEY (open_emp_id) REFERENCES employee (emp_id)
);

CREATE TABLE acc_transaction (
    txn_id INTEGER PRIMARY KEY AUTOINCREMENT,
    txn_date DATETIME NOT NULL,
    account_id INT NOT NULL,
    txn_type_cd VARCHAR(1) CHECK(txn_type_cd IN ('C', 'D')),
    amount DECIMAL(10,2) NOT NULL,
    teller_emp_id INT,
    execution_branch_id INT,
    FOREIGN KEY (account_id) REFERENCES account (account_id),
    FOREIGN KEY (teller_emp_id) REFERENCES employee (emp_id),
    FOREIGN KEY (execution_branch_id) REFERENCES branch (branch_id)
);