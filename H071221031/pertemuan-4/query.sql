-- no.1
SELECT * FROM customers
SELECT c.customerName AS "Nama Customer", c.country AS "Negara", p.paymentDate AS "tanggal"
FROM customers c
JOIN payments p
ON c.customerNumber = p.customerNumber
WHERE p.paymentDate > "2004-12-31"
ORDER BY p.paymentDate DESC

-- NO.2
SELECT DISTINCT c.customerName AS "Nama Customer", p.productName, l.textDescription
FROM customers c
JOIN orders o
ON c.customerNumber = o.customerNumber
JOIN orderdetails od
ON o.orderNumber = od.orderNumber
JOIN products p
ON od.productCode = p.productCode
JOIN productlines l
ON p.productLine = l.productLine
WHERE p.productName = "The Titanic"

-- NO.3
ALTER TABLE products
ADD COLUMN status VARCHAR(20);

UPDATE products
SET status='best selling'
WHERE productCode='S12_4675';

SELECT p.productCode, p.productName, od.quantityOrdered, p.`status`
FROM products p
JOIN orderdetails od 
ON od.productCode = p.productCode
ORDER BY od.quantityOrdered DESC
LIMIT 1

-- NO.4
ALTER TABLE payments DROP FOREIGN KEY payments_ibfk_1;     
ALTER TABLE payments ADD FOREIGN KEY (customerNumber) REFERENCES customers (customerNumber) ON DELETE CASCADE;

ALTER TABLE orders DROP FOREIGN KEY orders_ibfk_1;     
ALTER TABLE orders ADD FOREIGN KEY (customerNumber) REFERENCES customers (customerNumber) ON DELETE CASCADE;

ALTER TABLE orderdetails DROP FOREIGN KEY orderdetails_ibfk_1;     
ALTER TABLE orderdetails ADD FOREIGN KEY (orderNumber) REFERENCES orders (orderNumber) ON DELETE CASCADE;

DELETE c
FROM customers c
JOIN orders o
ON c.customerNumber = o.customerNumber
WHERE o.status = "cancelled"

SELECT * FROM orders
WHERE `status` = "cancelled"
 


