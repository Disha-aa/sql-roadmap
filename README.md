# SQL & Relational Databases Practice

[![Database](https://img.shields.io/badge/Database-SQLite3-003B57?style=for-the-badge&logo=sqlite&logoColor=white)](#)
[![Future](https://img.shields.io/badge/Planned-PostgreSQL_%2B_Docker-4169E1?style=for-the-badge&logo=postgresql&logoColor=white)](#)
[![Roadmap](https://img.shields.io/badge/Roadmap-Backend_Developer-orange?style=for-the-badge)](#)

A hands-on repository for learning how to design relational databases and write complex SQL queries. The project is based on the classic “Bank DB” domain (bank accounts, customers, branches, employee hierarchy, and financial transactions).

---

## Tech Stack & Roadmap

- [x] **SQLite3** — the current DBMS for practicing basic and advanced SQL without the overhead of server infrastructure.
- [ ] **PostgreSQL** — planned transition to a full-fledged RDBMS (joins, CTEs, indexes, query plan optimization using `EXPLAIN ANALYZE`).
- [ ] **Docker & Docker Compose** — deploying PostgreSQL in an isolated container with a volume mount for data persistence.

---

## ER Diagram of a Database (Bank DB)

```mermaid
erDiagram
    CUSTOMER {
        int cust_id PK
        string fed_id "SSN для физлиц / EIN для юрлиц"
        string cust_type_cd "I = individual, B = business"
        string address
        string city
        string state
        string postal_code
    }

    PRODUCT {
        string product_cd PK
        string name
        string product_type_cd "ACCOUNT | LOAN"
    }

    BRANCH {
        int branch_id PK
        string name
        string address
        string city
        string state
        string zip
    }

    DEPARTMENT {
        int dept_id PK
        string name
    }

    EMPLOYEE {
        int emp_id PK
        string fname
        string lname
        date start_date
        date end_date
        string title
        int assigned_branch_id FK
        int dept_id FK
        int superior_emp_id FK "self-reference, менеджер этого сотрудника"
    }

    ACCOUNT {
        int account_id PK
        string product_cd FK
        int cust_id FK
        date open_date
        date close_date
        date last_activity_date
        string status "ACTIVE | CLOSED | FROZEN"
        int open_branch_id FK
        int open_emp_id FK
        decimal avail_balance
        decimal pending_balance
    }

    ACC_TRANSACTION {
        int txn_id PK
        datetime txn_date
        int account_id FK
        string txn_type_cd "C = credit, D = debit"
        decimal amount
        int teller_emp_id FK
        int execution_branch_id FK
    }

    LOAN {
        int loan_id PK
        int account_id FK
        int cust_id FK
        string loan_type
        decimal principal_amount
        decimal interest_rate
        int term_months
        date start_date
        date end_date
        decimal monthly_payment
        string status "ACTIVE | PAID | DEFAULTED | APPROVED"
        int approved_by_emp_id FK
    }

    CREDIT_CARD {
        int card_id PK
        int cust_id FK
        int account_id FK
        string card_number UK
        string card_type
        decimal credit_limit
        decimal current_balance
        decimal available_credit
        date expiry_date
        string status "ACTIVE | BLOCKED | EXPIRED | CLOSED"
        int issued_by_branch_id FK
        int issued_by_emp_id FK
    }

    BRANCH_FEEDBACK {
        int feedback_id PK
        int branch_id FK
        int cust_id FK
        int emp_id FK
        int rating "1..5"
        string comment
        date feedback_date
        string feedback_type "COMPLAINT | COMPLIMENT | SUGGESTION | GENERAL"
    }

    %% --- связи ---
    BRANCH      o|--o{ EMPLOYEE         : "assigned_branch_id"
    DEPARTMENT  o|--o{ EMPLOYEE         : "dept_id"
    EMPLOYEE    o|--o{ EMPLOYEE         : "supervises (superior_emp_id)"

    CUSTOMER    ||--o{ ACCOUNT          : "cust_id"
    PRODUCT     ||--o{ ACCOUNT          : "product_cd"
    BRANCH      o|--o{ ACCOUNT          : "open_branch_id"
    EMPLOYEE    o|--o{ ACCOUNT          : "open_emp_id"

    ACCOUNT     ||--o{ ACC_TRANSACTION  : "account_id"
    EMPLOYEE    o|--o{ ACC_TRANSACTION  : "teller_emp_id"
    BRANCH      o|--o{ ACC_TRANSACTION  : "execution_branch_id"

    ACCOUNT     ||--o{ LOAN             : "account_id"
    CUSTOMER    ||--o{ LOAN             : "cust_id"
    EMPLOYEE    o|--o{ LOAN             : "approved_by_emp_id"

    CUSTOMER    ||--o{ CREDIT_CARD      : "cust_id"
    ACCOUNT     o|--o{ CREDIT_CARD      : "account_id"
    BRANCH      o|--o{ CREDIT_CARD      : "issued_by_branch_id"
    EMPLOYEE    o|--o{ CREDIT_CARD      : "issued_by_emp_id"

    BRANCH      ||--o{ BRANCH_FEEDBACK  : "branch_id"
    CUSTOMER    o|--o{ BRANCH_FEEDBACK  : "cust_id"
    EMPLOYEE    o|--o{ BRANCH_FEEDBACK  : "emp_id"
```
# Quick start

To deploy the database and run the practice scripts locally, follow these steps.

# Requirements:
- git
- sqlite3 

# 1. Cloning a repository:
```bash
git clone https://github.com/Disha-aa/sql-roadmap.git
cd sql-roadmap
```

# 2. Initializing and Populating the Database
The database is generated from code (DDL + DML) with a single command:
```bash
sqlite3 db/bank.db < db/schema.sql && sqlite3 db/bank.db < db/seed.sql
```

# 3. Launching the SQLite Interactive Console
```bash
sqlite3 db/bank.db
```
