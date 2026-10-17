# SQL & Relational Databases Practice

[![Database](https://img.shields.io/badge/Database-PostgreSQL_16-336791?style=for-the-badge&logo=postgresql&logoColor=white)](#)
[![Database](https://img.shields.io/badge/Database-SQLite3-003B57?style=for-the-badge&logo=sqlite&logoColor=white)](#)
[![Container](https://img.shields.io/badge/Docker-Compose-2496ED?style=for-the-badge&logo=docker&logoColor=white)](#)
[![Roadmap](https://img.shields.io/badge/Roadmap-Backend_Developer-orange?style=for-the-badge)](#)

A hands-on repository for learning how to design relational databases and write complex SQL queries. The project is based on the classic “Bank DB” domain (bank accounts, customers, branches, employee hierarchy, and financial transactions).

---

## Tech Stack & Roadmap

- [x] **SQLite3** — lightweight embedded engine for initial prototyping and offline practice.
- [x] **Docker & Docker Compose** — isolated PostgreSQL 16 container with persistent volumes and healthcheck.
- [x] **PostgreSQL 16 Migration** — full production-ready RDBMS migration (strict FK order, `SERIAL` keys, `NUMERIC` financial types, sequence alignment).
- [x] **Data Processing & Transformations (Chapter 7)** — robust string parsing, edge-case sanitization (`TRIM`, `STRPOS`), and PII data masking (`04_data_processing/pii_masking.sql`).
- [ ] **Advanced Querying** — window functions, CTEs, complex aggregations (`GROUPING SETS`, `ROLLUP`).
- [ ] **Performance & Optimization** — indexing strategies, execution plans with `EXPLAIN (ANALYZE, BUFFERS)`.

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

---

## Quick Start

### 1. PostgreSQL 16 via Docker Compose (Primary Environment)

1. **Start the database container:**
   ```bash
   docker compose up -d
   ```

2. **Initialize schema, seed 1200+ records, and sync sequence counters:**
   ```bash
   cat db/schema_pg.sql db/seed.sql db/sync_sequences.sql | docker exec -i local_postgres psql -U dev_user -d bank_dev
   ```

3. **Connect to interactive `psql` console:**
   ```bash
   docker exec -it local_postgres psql -U dev_user -d bank_dev
   ```

4. **Fast execution alias (recommended):**
   ```bash
   alias r="docker exec -i local_postgres psql -U dev_user -d bank_dev < 04_data_processing/pii_masking.sql"
   ```

---

### 2. SQLite3 (Embedded / Offline Practice)

```bash
sqlite3 db/bank.db < db/schema.sql && sqlite3 db/bank.db < db/seed.sql
sqlite3 db/bank.db
```

---

## Repository Structure

```text
.
├── 01_basics/            # Basic query syntax, filtering, and ordering
├── 02_joins/             # Multi-table joins (INNER, LEFT, CROSS, self-joins)
├── 03_sets/              # Set theory operations (UNION, INTERSECT, EXCEPT)
├── 04_data_processing/   # Data manipulation (strings, dates, numbers, PII masking)
│   ├── pii_masking.sql        # Task 1: PII masking & safe address parsing
│   ├── tenure_calc.sql        # Task 2: Precise employee tenure & anniversary calculation
│   ├── billing_fee.sql        # Task 3: Fee calculation & roundoff error audit
│   └── account_passport.sql   # Task 4: Flat account passport with zero-division guard
├── 05_grouping/          # Aggregations & Grouping (Chapter 8: GROUP BY, HAVING, aggregates)
│   └── liquidity_audit.sql    # Task 1: Liquidity audit by branch and product
├── db/
│   ├── bank.db           # Pre-built SQLite database
│   ├── schema.sql        # SQLite DDL schema
│   ├── schema_pg.sql     # PostgreSQL DDL schema (SERIAL keys, strict FKs, NUMERIC)
│   ├── seed.sql          # 1200+ rows dataset (branches, customers, accounts, loans)
│   └── sync_sequences.sql # Sequence alignment script for PostgreSQL
├── docker-compose.yml    # Isolated PostgreSQL 16 service definition
└── README.md
```
