USE classicmodels;

-- Nomor 1
SELECT c.customerName AS 'Nama Customer', c.state AS 'Negara', p.paymentDate AS 'tanggal'
FROM customers AS c
JOIN payments AS p
ON c.customerNumber = p.customerNumber
WHERE p.paymentDate >= '2005-01-01'
ORDER BY p.paymentDate;

-- Nomor 2
SELECT DISTINCT c.customerName AS 'Nama Customer', p.productName, p.productDescription
FROM customers AS c
JOIN products AS p
JOIN orderdetails AS od
ON p.productCode = od.productCode
JOIN orders AS o
ON o.orderNumber = od.orderNumber
ON o.customerNumber = c.customerNumber
WHERE p.productName = 'The Titanic';

-- Nomor 3
ALTER TABLE products ADD `status` VARCHAR(20);

UPDATE products AS p
JOIN orderdetails AS od
ON p.productCode = od.productCode
SET p.`status` = 'best selling'
WHERE p.productCode = 'S12_4675';
							
-- Nomor 4
ALTER TABLE orders DROP FOREIGN KEY orders_ibfk_1;
ALTER TABLE orders ADD FOREIGN KEY (customerNumber) REFERENCES customers (customerNumber) ON DELETE CASCADE;

ALTER TABLE orderdetails DROP FOREIGN KEY orderdetails_ibfk_1;
ALTER TABLE orderdetails ADD FOREIGN KEY (customerNumber) REFERENCES customers (customerNumber) ON DELETE CASCADE;

ALTER TABLE payments DROP FOREIGN KEY payments_ibfk_1;
ALTER TABLE payments ADD FOREIGN KEY (customerNumber) REFERENCES customers (customerNumber) ON DELETE CASCADE;

SELECT * FROM customers AS c
LEFT JOIN orders AS o
ON c.customerNumber = o.customerNumber
WHERE o.`status` = 'Cancelled';

-- Nomor 5
SELECT o.orderDate FROM orders AS o
JOIN orderdetails AS od
ON o.orderNumber = od.orderNumber
JOIN products AS p
ON od.productCode = p.productCode
WHERE p.productName = '1940 Ford Pickup Truck'
ORDER BY o.orderDate DESC;