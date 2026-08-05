PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS acc_transaction;
DROP TABLE IF EXISTS account;
DROP TABLE IF EXISTS product;
DROP TABLE IF EXISTS customer;
DROP TABLE IF EXISTS employee;
DROP TABLE IF EXISTS department;
DROP TABLE IF EXISTS branch;

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