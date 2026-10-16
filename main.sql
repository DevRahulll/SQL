CREATE TABLE departments (
    department_id SERIAL PRIMARY KEY,
    -- value cannot be NULL and it must be unique
    department_name VARCHAR(50) NOT NULL
);
INSERT INTO departments (department_name)
VALUES ('Sales'),
    ('Support'),
    ('Warehouse');
INSERT INTO departments (department_id, department_name)
VALUES (4, 'Tech');
SELECT *
FROM departments;
CREATE TABLE employees (
    employee_id SERIAL PRIMARY KEY,
    -- cannot be null it is unique
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    phone VARCHAR(20),
    bio TEXT,
    job_title VARCHAR(50) NOT NULL,
    salary INT NOT NULL CHECK (salary > 0),
    is_active BOOLEAN NOT NULL DEFAULT TRUE,
    hire_date DATE NOT NULL,
    last_login TIMESTAMP,
    employee_status VARCHAR(20) NOT NULL DEFAULT 'active' CHECK (
        employee_status IN ('active', 'on_leave', 'terminated')
    ),
    -- active, on_leave, terminated
    created_at TIMESTAMP NOT NULL DEFAULT now(),
    department_id INT REFERENCES departments(department_id),
    manager_id INT REFERENCES employees(employee_id)
);
INSERT INTO employees (
        first_name,
        last_name,
        email,
        department_id,
        job_title,
        salary,
        manager_id,
        hire_date
    )
VALUES (
        'Priya',
        'Nair',
        'priya.nair@techbazaar.com',
        1,
        'Sales Representative',
        62000.00,
        1,
        '2020-06-15'
    ),
    (
        'Fake',
        'Robert',
        'robert.chen@techbazaar.com',
        1,
        'Rep',
        50000.00,
        1,
        '2024-01-01'
    ),
    (
        'Marcus',
        'Webb',
        'marcus.webb@techbazaar.com',
        1,
        'Sales Representative',
        58000.00,
        1,
        '2021-09-01'
    ),
    (
        'Elena',
        'Garcia',
        'elena.garcia@techbazaar.com',
        1,
        'Senior Sales Rep',
        68000.00,
        NULL,
        '2019-11-20'
    ),
    (
        'James',
        'Okafor',
        'james.okafor@techbazaar.com',
        2,
        'Support Lead',
        72000.00,
        2,
        '2018-05-10'
    ),
    (
        'Lily',
        'Zhang',
        'lily.zhang@techbazaar.com',
        2,
        'Support Agent',
        48000.00,
        NULL,
        '2022-02-14'
    ),
    (
        'Diego',
        'Fernandez',
        'diego.fernandez@techbazaar.com',
        2,
        'Support Agent',
        46000.00,
        1,
        '2023-01-09'
    ),
    (
        'Sara',
        'Osei',
        'sara.osei@techbazaar.com',
        3,
        'Warehouse Lead',
        55000.00,
        5,
        '2020-08-23'
    );
SELECT *
FROM employees;
ALTER TABLE employees
ADD COLUMN internal_note VARCHAR(100) NOT NULL DEFAULT 'N/A';
ALTER TABLE employees
    RENAME COLUMN internal_note to hr_note;
SELECT *
FROM employees;
ALTER TABLE employees DROP COLUMN hr_note;
--! ======== DDL End ========
-- ======================================================================================
-- ! INSERT< UPDATE < DELETE are called as DML - Data Manipulation language
INSERT INTO customers (
        first_name,
        last_name,
        email,
        phone,
        city,
        country
    )
VALUES (
        'John',
        'Doe',
        'john.doe@gmail.com',
        '999999999',
        'Mumbai',
        'India'
    );
SELECT *
FROM customers;
INSERT INTO categories (category_name, description)
VALUES ('Dairy', 'Dairy products'),
    ('Gym', 'Gym products'),
    ('Cold drinks', 'cold drinks description');
SELECT *
FROM categories;
UPDATE products
SET stock_quantity = 51
WHERE product_id = 1;
UPDATE products
SET is_active = FALSE;
UPDATE products
SET price = price + 50;
UPDATE products
SET stock_quantity = 1
WHERE product_id = 3;
SELECT *
FROM products
ORDER BY product_id;
-- order_item_id:1,2
SELECT *
FROM order_items
WHERE order_id = 1;
DELETE FROM orders
WHERE order_id = 1;
SELECT customer_id,
    first_name,
    phone
FROM customers
WHERE phone is NULL;
SELECT *
FROM orders
ORDER BY order_id;
-- ======================================================================================
--! ======== DML End ========
-- ! DQL - Data Query Language


SELECT product_id,
    product_name,
    stock_quantity AS "Rahul"
FROM products;

-- use quotes for specific String for alias name to be shown

SELECT * FROM customers;

SELECT DISTINCT country from customers;

-- Distince keyword is used to brings only single value no duplicate

SELECT * FROM products 
WHERE price>200 OR is_active=TRUE;

-- Give me products having stock qty > 0 and price < 150

SELECT * FROM products 
WHERE stock_quantity > 0 AND price<150;

-- Give me products havning 0 as stock qty or price < 150

SELECT * FROM products 
WHERE stock_quantity = 0 OR price<150;


SELECT * FROM products WHERE price BETWEEN 120 AND 200;

SELECT * FROM categories;

-- Give me product from Electronics as well as books

SELECT * FROM products 
WHERE category_id = 1 OR category_id=3 OR category_id = 4 ORDER BY category_id ASC;

SELECT * FROM products WHERE category_id IN (1, 2, 3, 4);

INSERT INTO products
(product_name, price, stock_quantity, category_id)
VALUES 
('Wireless keyboard', 100, 20, 1),
('Wireless light', 200, 0, 1),
('Wireless headphones', 150, 0, 1);


SELECT * FROM products WHERE product_name LIKE '%less%';

-- Give me customers who does not have phone numbers

SELECT * FROM customers WHERE phone IS NULL;

SELECT * FROM customers WHERE phone IS NOT NULL;




SELECT 
    first_name,
    last_name,
    COALESCE(phone, 'Phone number unavailable') AS phone_num,
    COALESCE(city, 'No city') AS city_name
FROM customers;

-- COALESCE keyword is used to show to F.E about specific string if values in not availabe e.g phone = null , it will show "PHone number unavailable"

-- Give me products from cheapest to expensive order

SELECT * FROM products ORDER BY price ASC;

-- Give me top 10 most expensive producst

SELECT * FROM products ORDER BY price DESC LIMIT 10;

-- Pagination

SELECT * FROM products ORDER BY product_id ASC LIMIT 10 OFFSET 20;

-- F.E fromula -> 
--  offset =(page -1) * limit;
--  e.g = (3-1)*10= 20;



