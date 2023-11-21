USE classicmodels;

-- Nomor 1
SELECT c.customerName, pr.productName, p.paymentDate, o.`status`
FROM customers AS c
JOIN payments AS p ON c.customerNumber = p.customerNumber
JOIN orders AS o ON c.customerNumber = o.customerNumber
JOIN orderdetails AS od ON o.orderNumber = od.orderNumber
JOIN products AS pr ON od.productCode = pr.productCode
WHERE pr.productName LIKE '%Ferrari%' AND o.`status` = 'Shipped';

-- Nomor 2
SELECT c.customerName, p.paymentDate, e.lastName, e.firstName
FROM customers AS c
JOIN employees AS e ON c.salesRepEmployeeNumber = e.employeeNumber
JOIN payments AS p ON c.customerNumber = p.customerNumber
WHERE p.paymentDate LIKE '_____11___';

SELECT c.customerNumber, c.customerName, p.paymentDate, p.amount
FROM customers AS C
JOIN payments as p USING (customerNumber)
JOIN employees AS e ON c.salesRepEmployeeNumber = e.employeeNumber
WHERE p.paymentDate LIKE '_____11___'
ORDER BY p.amount DESC
LIMIT 1;

SELECT c.customerName, pr.productName
FROM customers AS c
JOIN employees AS e ON c.salesRepEmployeeNumber = e.employeeNumber
JOIN payments AS p ON c.customerNumber = p.customerNumber
JOIN orders AS o ON c.customerNumber = o.customerNumber
JOIN orderdetails AS od ON o.orderNumber = od.orderNumber
JOIN products AS pr ON od.productCode = pr.productCode
WHERE c.customerNumber = 321;
and p.paymentDate LIKE '_____11___';

SELECT c.customerName, GROUP_CONCAT(pr.productName) AS productName
FROM customers AS c
JOIN employees AS e ON c.salesRepEmployeeNumber = e.employeeNumber
JOIN payments AS p ON c.customerNumber = p.customerNumber
JOIN orders AS o ON c.customerNumber = o.customerNumber
JOIN orderdetails AS od ON o.orderNumber = od.orderNumber
JOIN products AS pr ON od.productCode = pr.productCode
WHERE c.customerNumber = 321;
and p.paymentDate LIKE '_____11___';

-- Nomor 3
SELECT c.customerName, o.orderDate, o.shippedDate, (o.shippedDate - o.orderDate) AS 'Delay'
FROM customers AS c
JOIN orders AS o ON c.customerNumber = o.customerNumber
WHERE c.customerName = 'GiftsForHim.com'

-- Nomor 4
USE world;

SELECT *
FROM country AS c
WHERE `code` LIKE 'C%K' AND LifeExpectancy IS NOT NULL;