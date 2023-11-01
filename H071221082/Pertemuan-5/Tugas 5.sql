USE classicmodels;

-- NOMOR 1
SELECT c.customerName, pr.productName, p.paymentDate, o.`status`
FROM customers AS c
JOIN payments AS p ON c.customerNumber = p.customerNumber
JOIN orders AS o ON c.customerNumber = o.customerNumber
JOIN orderdetails AS od ON o.orderNumber = od.orderNumber
JOIN products AS pr ON od.productCode = pr.productCode
WHERE pr.productName LIKE '%Ferrari%' AND o.`status` = 'Shipped' AND c.customerName = 'Signal Gift Stores';

-- NOMOR 2
SELECT c.customerName, p.paymentDate, e.lastName, e.firstName
FROM customers AS c
JOIN employees AS e ON c.salesRepEmployeeNumber = e.employeeNumber
JOIN payments AS p ON c.customerNumber = p.customerNumber
WHERE MONTH	(p.paymentDate) = 11;

SELECT c.customerNumber, c.customerName, p.paymentDate, p.amount
FROM customers AS C
JOIN payments as p USING (customerNumber)
JOIN employees AS e ON c.salesRepEmployeeNumber = e.employeeNumber
WHERE MONTH	(p.paymentDate) = 11
ORDER BY p.amount DESC
LIMIT 1;

SELECT c.customerName, pr.productName
FROM customers AS c
JOIN employees AS e ON c.salesRepEmployeeNumber = e.employeeNumber
JOIN payments AS p ON c.customerNumber = p.customerNumber
JOIN orders AS o ON c.customerNumber = o.customerNumber
JOIN orderdetails AS od ON o.orderNumber = od.orderNumber
JOIN products AS pr ON od.productCode = pr.productCode
WHERE MONTH	(p.paymentDate) = 11 AND c.customerNumber = 321 ;

SELECT c.customerName, GROUP_CONCAT(pr.productName) AS 'productName'
FROM customers AS c
JOIN employees AS e ON c.salesRepEmployeeNumber = e.employeeNumber
JOIN payments AS p ON c.customerNumber = p.customerNumber
JOIN orders AS o ON c.customerNumber = o.customerNumber
JOIN orderdetails AS od ON o.orderNumber = od.orderNumber
JOIN products AS pr ON od.productCode = pr.productCode
WHERE MONTH	(p.paymentDate) = 11 AND c.customerNumber = 321 ;

-- NOMOR 3
SELECT c.customerName, o.orderDate, o.shippedDate, DATEDIFF(o.shippedDate, o.orderDate) AS 'Delay'
FROM customers AS c
JOIN orders AS o ON c.customerNumber = o.customerNumber
WHERE c.customerName = 'GiftsForHim.com'

-- NOMOR 4
USE world;

SELECT * FROM country AS c
WHERE `code` LIKE 'C%K' AND LifeExpectancy IS NOT NULL;

-- Soal Tambahan
#siapa saja customer yang berkomentar yang menggunakan DHL
SELECT c.customerName, o.comments 
FROM customers AS c
JOIN orders AS o
USING (customerNumber)
WHERE comments LIKE '%DHL%'