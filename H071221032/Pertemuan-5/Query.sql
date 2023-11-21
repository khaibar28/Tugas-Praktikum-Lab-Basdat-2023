#1
SELECT C.customerName, P.productName, P1.paymentDate, O.status
FROM customers AS C
JOIN payments AS P1
ON C.customerNumber = P1.customerNumber
JOIN orders AS O
ON C.customerNumber = O.customerNumber
JOIN orderdetails AS O1
ON O.orderNumber = O1.orderNumber
JOIN products AS P
ON O1.productCode = P.productCode
WHERE P.productName LIKE "%Ferrari%" AND O.status = "Shipped" AND customerName = "Signal Gift Stores";

#2
	#a
SELECT C.customerName, P.paymentDate, concat(E.firstName, " ", E.lastName) AS employeeName, P.amount
FROM customers AS C
JOIN payments AS P
ON C.customerNumber = P.customerNumber
JOIN employees AS E
ON C.salesRepEmployeeNumber = E.employeeNumber
WHERE MONTH(P.paymentDate) = '11';

	#b
SELECT C.customerName, P.paymentDate, E.firstName, E.lastName
FROM customers AS C
JOIN payments AS P
ON C.customerNumber = P.customerNumber
JOIN employees AS E
ON C.salesRepEmployeeNumber = E.employeeNumber
WHERE MONTH(P.paymentDate) = '11'
ORDER BY P.amount DESC LIMIT 1;

	#c
SELECT C.customerName, P.productName
FROM customers AS C
JOIN orders AS O
ON C.customerNumber = O.customerNumber
JOIN orderdetails AS O1
ON O.orderNumber = O1.orderNumber
JOIN products AS P
ON O1.productCode = P.productCode
WHERE C.customerName = "Corporate Gift Ideas Co.";

	#d
SELECT C.customerName, GROUP_CONCAT(DISTINCT P.productName) AS productName
FROM customers AS C
JOIN orders AS O
ON C.customerNumber = O.customerNumber
JOIN orderdetails AS O1
ON O.orderNumber = O1.orderNumber
JOIN products AS P
ON O1.productCode = P.productCode
WHERE C.customerName = "Corporate Gift Ideas Co.";

#3
SELECT C.customerName, O.orderDate, O.shippedDate, concat(DATEDIFF(O.shippedDate, O.orderDate), " ", "Hari") AS waitTime
FROM customers AS C
JOIN orders AS O
ON C.customerNumber = O.customerNumber
WHERE C.customerName = "GiftsForHim.com"
ORDER BY O.orderDate DESC;

#4
USE world;
select * FROM country
WHERE Code LIKE "C%K" AND LifeExpectancy IS NOT NULL;