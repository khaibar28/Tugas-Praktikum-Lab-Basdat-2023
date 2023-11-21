USE classicmodels

-- No.1
SELECT * FROM customers;
SELECT * FROM products;
SELECT * FROM payments;

SELECT c.customerName, pr.productName, py.paymentDate, o.`status`
FROM customers c
JOIN orders o
USING (customerNumber)
JOIN orderdetails od
USING (orderNumber)
JOIN products pr
USING (productCode)
JOIN payments py
USING (customerNumber)
WHERE c.customerName LIKE 'Si%' AND pr.productName LIKE '%Ferrari%' AND o.`status` = "Shipped";

-- No.2
-- A.
SELECT * FROM employees;

SELECT c.customerName, py.paymentDate, e.firstName, e.lastName
FROM customers c
JOIN payments py
USING (customerNumber)
JOIN employees e
ON c.salesRepEmployeeNumber = e.employeeNumber
WHERE MONTH (paymentDate) = '11';
-- B.
SELECT c.customerName, py.paymentDate, CONCAT (e.firstName, ' ', e.lastName) AS EmployeeName, py.amount
FROM customers c
JOIN payments py
USING (customerNumber)
JOIN employees e
ON c.salesRepEmployeeNumber = e.employeeNumber
WHERE MONTH (paymentDate) = '11' ORDER BY py.amount DESC LIMIT 1;
-- C.
SELECT c.customerName, p.productName
FROM customers c
JOIN orders o
USING (customerNumber)
JOIN orderdetails od
USING (orderNumber)
JOIN products p
USING (productCode)
JOIN payments py
USING (customerNumber)
WHERE MONTH (paymentDate) = '11' and c.customerName = 'Corporate Gift Ideas Co.'
-- D.
SELECT c.customerName, GROUP_CONCAT(p.productName ) AS productName
FROM customers c
JOIN orders o 
USING (customerNumber)
JOIN orderdetails od 
USING (orderNumber)
JOIN products p 
USING (productCode)
JOIN payments py
ON c.customerNumber = py.customerNumber
JOIN employees e 
ON c.salesRepEmployeeNumber = e.employeeNumber
WHERE MONTH(py.paymentDate) = 11 AND c.customerName LIKE 'corporate%';

-- No.3
SELECT c.customerName, o.orderDate, o.shippedDate, ABS(DATEDIFF(orderDate, shippedDate)) AS selisih
FROM customers c
JOIN orders o
USING (customerNumber)
WHERE c.customerName LIKE '%Him%';

-- No.4
USE world;

SELECT * FROM country
WHERE `Code` LIKE 'c%k' AND lifeExpectancy IS NOT NULL;

-- Soal Tambahan
SELECT customers.customerName, DAYNAME(orders.orderDate) AS "Hari Pemesanan", products.productName
FROM customers
JOIN orders
USING (customerNumber)
JOIN orderdetails
USING (orderNumber)
JOIN products
USING (productCode)
WHERE DAYNAME(orders.orderDate) IN ("Saturday", "Sunday") AND products.productName LIKE '%Ferrari%'