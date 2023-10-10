-- NO.1
SELECT c.customerName, p.productName,py.paymentdate, o.`status`
FROM customers c
JOIN orders o
USING(customerNumber)
JOIN orderdetails
USING(orderNumber)
JOIN products p
USING(productCode)
JOIN payments py
USING(customerNumber)
WHERE p.productName LIKE '%Ferrari%' AND o.`status`= 'Shipped'

-- NO.2
-- a
SELECT c.customerName, p.paymentDate, e.lastName, e.firstName
FROM customers c
JOIN payments p
USING(customerNumber)
JOIN employees e
ON c.salesRepEmployeeNumber = e.employeeNumber
WHERE MONTH(p.paymentDate)= 11

-- b
SELECT c.customerName, p.customerNumber, p.paymentDate, p.amount
FROM payments p
JOIN customers c
USING(customerNumber)
WHERE MONTH(p.paymentDate)=11
ORDER BY p.amount DESC
LIMIT 1

-- c
SELECT c.customerName, p.productName
FROM customers c
JOIN orders o
USING(customerNumber)
JOIN orderdetails od
USING(orderNumber)
JOIN products p
USING(productCode)
JOIN payments py
USING(customerNumber)
WHERE MONTH(py.paymentDate)=11 AND customerName = 'Corporate Gift Ideas Co.';

-- d
SELECT GROUP_CONCAT(c.customerName), (p.productName)
FROM customers c
JOIN orders o
USING(customerNumber)
JOIN orderdetails od
USING(orderNumber)
JOIN products p
USING(productCode)
JOIN payments py
USING(customerNumber)
WHERE MONTH(py.paymentDate)=11 AND customerName = 'Corporate Gift Ideas Co.'

-- NO.3
SELECT c.customerName, o.orderDate, o.shippedDate, o.shippedDate - o.orderDate AS Menunggu
FROM customers c
JOIN orders o
USING(customerNumber)
WHERE c.customerName = 'GiftsForHim.com'

-- NO.4
-- a
SELECT *
FROM country c
WHERE c.code LIKE 'C%K'

-- b
SELECT * 
FROM country c
WHERE c.lifeExpectancy IS NOT NULL

-- tambahan
SELECT MAX(amount) AS Terbesar, MIN(amount) AS terkecil, (MAX(amount) - MIN(amount)) AS selisih
FROM payments

-- Euro+ Shopping Channel
-- Tokyo Collectables, Ltd

 
