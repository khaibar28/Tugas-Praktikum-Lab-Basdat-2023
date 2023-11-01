USE classicmodels;
SELECT * FROM customers
WHERE customerName = 'GiftsForHim.com';
SELECT * FROM payments
SELECT * FROM employees
SELECT * FROM orderdetails
SELECT * FROM orders
SELECT * FROM products


-- No.1
SELECT c.customerName, p.productName, py.paymentDate, o.`status`
FROM payments py
JOIN customersc
USING (customerNumber)
JOIN orders o
USING (customerNumber)
JOIN orderdetails od
USING (orderNumber)
JOIN products p
USING (productCode)
WHERE productName LIKE '%Ferrari%' AND `status` = 'Shipped'
LIMIT 3;

-- No.2
#a
SELECT c.customerName, py.paymentDate, e.firstName, e.lastName
-- CONCAT (e.firstName, ' ', e.lastName) AS 'Nama Karyawan'
FROM employees e
JOIN customers c
ON c.salesRepEmployeeNumber = e.employeeNumber
JOIN payments py
USING (customerNumber)
WHERE 
		MONTH(paymentDate) = 11;
		
#b
SELECT c.customerName, py.paymentDate, CONCAT (e.firstName, ' ', e.lastName) AS 'Nama Karyawan', py.amount
FROM employees e
JOIN customers c
ON c.salesRepEmployeeNumber = e.employeeNumber
JOIN payments py
USING (customerNumber)
WHERE 
		MONTH(paymentDate) = 11
ORDER BY amount DESC 
LIMIT 1;

#c
SELECT c.customerName, p.productName
FROM customers c
join payments py
USING (customerNumber)
JOIN orders o
ON c.customerNumber = o.customerNumber
JOIN orderdetails od
USING (orderNumber)
JOIN products p
USING (productCode)
WHERE MONTH(paymentDate) = 11 AND customername = 'Corporate Gift Ideas Co.'

#d
SELECT c.customerName, GROUP_CONCAT(p.productName) 
FROM customers c
join payments py
USING (customerNumber)
JOIN orders o
ON c.customerNumber = o.customerNumber
JOIN orderdetails od
USING (orderNumber)
JOIN products p
USING (productCode)
WHERE MONTH(paymentDate) = 11 AND customername = 'Corporate Gift Ideas Co.'

-- No.3
SELECT c.customerName, o.orderDate, o.shippedDate, o.shippedDate - o.OrderDate AS 'Wakta Tunggu'
FROM customers c
JOIN orders o
USING (customerNumber)
WHERE c.customerName = 'GiftsForHim.com';

-- No.4
USE world
SELECT * FROM country

SELECT `code`, `Name`, lifeExpectancy
FROM country
WHERE `code` LIKE 'c%k' AND lifeExpectancy IS NOT NULL;


-- soal tambahan \

SELECT c.customerName, p.productName
FROM customers c
JOIN orders o
USING (customerNumber)
JOIN orderdetails od
USING (orderNumber)
JOIN products p
USING (productCode)
WHERE productName LIKE '%198%'
ORDER BY productName ASC;