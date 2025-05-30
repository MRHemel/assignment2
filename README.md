# PostgreSQL Concepts and Queries

### 2. What is the purpose of a database schema in PostgreSQL?

A **schema** in PostgreSQL  is a logical namespace that organizes database objects (tables, views, functions, etc.) into groups.

#### Purpose:
- Logical organization of objects
- Separation between different parts of an application
- Avoid name conflicts (e.g. same table name in different schemas)
- Strengthen security with schema-level permissions

***Example***:
```sql
CREATE SCHEMA hr;

CREATE TABLE hr.employees (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    department VARCHAR(50)
);
```

### 3. Explain the Primary Key and Foreign Key concepts in PostgreSQL.

Primary Key:
A primary key uniquely identifies each row in a table. It must be unique and not null.

***Example***:
```sql
CREATE TABLE departments (
    dept_id SERIAL PRIMARY KEY,
    dept_name VARCHAR(50) NOT NULL
);
```

Foreign Key:

A foreign key establishes a relationship between two tables by referring to a primary key in another table.

***Example***:
```sql
CREATE TABLE employees (
    emp_id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    dept_id INTEGER REFERENCES departments(dept_id)
);
```

### 4. What is the difference between the VARCHAR and CHAR data types?

| Type      | Description                             |
| --------- | --------------------------------------- |
| `VARCHAR` | Variable-length character string        |
| `CHAR`    | Fixed-length string, padded with spaces |

Key Differences:
CHAR(n) always stores n characters (padding if shorter)

VARCHAR(n) stores only as many characters as needed (up to n)

***Example***:
```sql
-- Flexible string
name VARCHAR(50)

-- Fixed format code
code CHAR(3)
```


### 5. Explain the purpose of the WHERE clause in a SELECT statement.

The **WHERE** clause filters rows returned by a **SELECT** query based on specified conditions.

***Syntax:***

```sql
SELECT column1, column2
FROM table
WHERE condition;
```
***Example:***
```sql
SELECT name, department
FROM employees
WHERE department = 'Sales';
```

### 10. How can you calculate aggregate functions like `COUNT()`, `SUM()`, and `AVG()` in PostgreSQL?

Aggregate functions compute a single result from a set of input values. These functions are essential for reporting, analytics, and summarizing data in PostgreSQL.

| Function | Purpose                     |
|----------|-----------------------------|
| `COUNT()`| Counts rows or values       |
| `SUM()`  | Calculates the total sum    |
| `AVG()`  | Computes the average        |
| `MAX()`  | Finds the highest value     |
| `MIN()`  | Finds the lowest value      |

***Example***:

```sql
-- Total number of employees
SELECT COUNT(*) FROM employees;

-- Average salary in each department
SELECT department, AVG(salary)
FROM employees
GROUP BY department;

-- Total sales made by each employee
SELECT emp_id, SUM(sales_amount)
FROM sales
GROUP BY emp_id;
```
