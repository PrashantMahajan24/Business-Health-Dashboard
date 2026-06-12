use business_health;

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    gender VARCHAR(10),
    city VARCHAR(50),
    state VARCHAR(50),
    join_date DATE,
    customer_type VARCHAR(20)
);

WITH Numbers AS (
    SELECT TOP 1000 ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS n
    FROM sys.objects
)
INSERT INTO customers
(customer_id, customer_name, gender, city, state, join_date, customer_type)
SELECT
    n,
    CONCAT('Customer_', n),
    CASE WHEN n % 2 = 0 THEN 'Female' ELSE 'Male' END,
    CASE n % 5 
        WHEN 0 THEN 'Mumbai'
        WHEN 1 THEN 'Pune'
        WHEN 2 THEN 'Delhi'
        WHEN 3 THEN 'Bengaluru'
        ELSE 'Chennai'
    END,
    CASE n % 5 
        WHEN 0 THEN 'Maharashtra'
        WHEN 1 THEN 'Maharashtra'
        WHEN 2 THEN 'Delhi'
        WHEN 3 THEN 'Karnataka'
        ELSE 'Tamil Nadu'
    END,
    DATEADD(DAY, n, '2023-01-01'),
    CASE WHEN n % 3 = 0 THEN 'Premium' ELSE 'Regular' END
FROM Numbers;


CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(100),
    department_id INT,
    salary DECIMAL(10,2),
    performance_score INT,
    attendance_percent DECIMAL(5,2),
    joining_date DATE
);

WITH Numbers AS (
    SELECT TOP 1000 ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS n
    FROM sys.objects
)
INSERT INTO employees
(emp_id, emp_name, department_id, salary, performance_score, attendance_percent, joining_date)
SELECT
    n,
    CONCAT('Employee_', n),
    (n % 5) + 1,
    30000 + (n % 70000),
    60 + (n % 40),
    70 + (n % 30),
    DATEADD(DAY, -n, '2024-01-01')
FROM Numbers;


CREATE TABLE departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(50)
);

WITH Numbers AS (
    SELECT TOP 1000 ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS n
    FROM sys.objects
)
INSERT INTO departments
(department_id, department_name)
SELECT
    n,
    CONCAT('Department_', n)
FROM Numbers;



CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50),
    price DECIMAL(10,2),
    cost_price DECIMAL(10,2)
);

WITH Numbers AS (
    SELECT TOP 1000 ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS n
    FROM sys.objects
)
INSERT INTO products
(product_id, product_name, category, price, cost_price)
SELECT
    n,
    CONCAT('Product_', n),
    CASE n % 5
        WHEN 0 THEN 'Electronics'
        WHEN 1 THEN 'Furniture'
        WHEN 2 THEN 'Office'
        WHEN 3 THEN 'Stationery'
        ELSE 'Accessories'
    END,
    1000 + (n * 10),
    800 + (n * 5)
FROM Numbers;

CREATE TABLE inventory (
    inventory_id INT PRIMARY KEY,
    product_id INT,
    stock_quantity INT,
    warehouse VARCHAR(50),
    reorder_level INT
);

WITH Numbers AS (
    SELECT TOP 1000 ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS n
    FROM sys.objects
)
INSERT INTO inventory
(inventory_id, product_id, stock_quantity, warehouse, reorder_level)
SELECT
    n,
    (n % 1000) + 1,
    50 + (n % 500),
    CASE n % 3
        WHEN 0 THEN 'Mumbai'
        WHEN 1 THEN 'Pune'
        ELSE 'Delhi'
    END,
    20 + (n % 50)
FROM Numbers;

CREATE TABLE sales (
    sales_id INT PRIMARY KEY,
    customer_id INT,
    product_id INT,
    emp_id INT,
    quantity INT,
    sales_amount DECIMAL(10,2),
    profit DECIMAL(10,2),
    sales_date DATE,
    region VARCHAR(50)
);

WITH Numbers AS (
    SELECT TOP 1000 ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS n
    FROM sys.objects
)
INSERT INTO sales
(sales_id, customer_id, product_id, emp_id, quantity, sales_amount, profit, sales_date, region)
SELECT
    n,
    (n % 1000) + 1,
    (n % 1000) + 1,
    (n % 1000) + 1,
    (n % 10) + 1,
    1000 + (n * 50),
    200 + (n * 10),
    DATEADD(DAY, n, '2024-01-01'),
    CASE n % 4
        WHEN 0 THEN 'North'
        WHEN 1 THEN 'South'
        WHEN 2 THEN 'East'
        ELSE 'West'
    END
FROM Numbers;

CREATE TABLE targets (
    target_id INT PRIMARY KEY,
    month_name VARCHAR(20),
    sales_target DECIMAL(12,2)
);

WITH Numbers AS (
    SELECT TOP 1000 ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS n
    FROM sys.objects
)
INSERT INTO targets
(target_id, month_name, sales_target)
SELECT
    n,
    DATENAME(MONTH, DATEADD(MONTH, n % 12, '2024-01-01')),
    50000 + (n * 100)
FROM Numbers;



select * from targets;