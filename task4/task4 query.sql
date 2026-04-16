CREATE DATABASE ecommerce;
USE ecommerce;

-- Customers Table
CREATE TABLE Customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    email VARCHAR(100),
    city VARCHAR(50)
);

-- Products Table
CREATE TABLE Products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(100),
    price DECIMAL(10,2)
);

-- Orders Table
CREATE TABLE Orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    product_id INT,
    quantity INT,
    order_date DATE,
    total_amount DECIMAL(10,2),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);
INSERT INTO Customers (name, email, city) VALUES
('Arif', 'arif@gmail.com', 'Chennai'),
('Rahul', 'rahul@gmail.com', 'Mumbai'),
('Sara', 'sara@gmail.com', 'Delhi');

INSERT INTO Products (product_name, price) VALUES
('Laptop', 60000),
('Mobile', 20000),
('Headphones', 3000);

INSERT INTO Orders (customer_id, product_id, quantity, order_date, total_amount) VALUES
(1, 1, 1, '2026-02-01', 60000),
(1, 3, 2, '2026-02-10', 6000),
(2, 2, 1, '2026-02-12', 20000),
(3, 2, 3, '2026-02-15', 60000),
(2, 3, 5, '2026-02-16', 15000);
SELECT 
    c.name,
    p.product_name,
    o.quantity,
    o.total_amount,
    o.order_date
FROM Orders o
JOIN Customers c ON o.customer_id = c.customer_id
JOIN Products p ON o.product_id = p.product_id
ORDER BY o.order_date DESC;
SELECT * FROM Orders
WHERE total_amount = (
    SELECT MAX(total_amount) FROM Orders
);
SELECT name FROM Customers
WHERE customer_id = (
    SELECT customer_id 
    FROM Orders
    GROUP BY customer_id
    ORDER BY COUNT(order_id) DESC
    LIMIT 1
);
