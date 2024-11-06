CREATE TABLE Employee (
    employee_id INT PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    base_salary DECIMAL(10, 2) NOT NULL,
    bonus DECIMAL(10, 2) DEFAULT 0,
    allowance DECIMAL(10, 2) DEFAULT 0,
    department_id INT
);

-- Product Table
CREATE TABLE Product (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    category_id INT NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    stock_quantity INT DEFAULT 0
);

-- Customer Table
CREATE TABLE Customer (
    customer_id INT PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    password VARCHAR(100) NOT NULL
);

-- Order Table
CREATE TABLE [Order] (  -- Using brackets because ORDER is a reserved keyword in SQL
    order_id INT PRIMARY KEY,
    customer_id INT NOT NULL,
    order_date DATE NOT NULL,
    total_amount DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES Customer(customer_id)
);

-- Warehouse_stock Table
CREATE TABLE Warehouse_stock (
    product_id INT,
    warehouse_id INT,
    stock_quantity INT DEFAULT 0,
    PRIMARY KEY (product_id, warehouse_id),
    FOREIGN KEY (product_id) REFERENCES Product(product_id)
);

-- Review Table
CREATE TABLE Review (
    review_id INT PRIMARY KEY,
    product_id INT NOT NULL,
    rating DECIMAL(2, 1) CHECK (rating BETWEEN 1 AND 5),  -- Rating constraint between 1 and 5
    review_comment VARCHAR(255),
    customer_id INT NOT NULL,
    FOREIGN KEY (product_id) REFERENCES Product(product_id),
    FOREIGN KEY (customer_id) REFERENCES Customer(customer_id)
);