USE classicmodels

-- No.1
SELECT * FROM customers;
SELECT * FROM payments;

SELECT c.customerName AS "Nama Customer", c.country AS "Negara", p.paymentDate AS "Tanggal"
FROM customers c
JOIN payments p
ON c.customerNumber = p.customerNumber
WHERE p.paymentDate >= "2005-01-01" ORDER BY p.paymentDate ASC;

-- No.2
SELECT * FROM products;

SELECT DISTINCT c.customerName AS "Nama Customer", p.productName, pl.textDescription
FROM customers c
JOIN orders o
ON c.customerNumber = o.customerNumber
JOIN orderdetails od
ON o.orderNumber = od.orderNumber
JOIN products p
ON od.productCode = p.productCode
JOIN productlines pl
ON p.productLine = pl.productLine
WHERE p.productName = "The Titanic";

-- No.3
ALTER TABLE products
ADD `status` VARCHAR(20);

SELECT * FROM orderdetails ORDER BY quantityOrdered DESC;

UPDATE products p
JOIN orderdetails od
ON p.productCode = od.productCode
SET `status` = "Best Selling"
WHERE od.quantityOrdered = 97;

SELECT p.productCode, p.productName, od.quantityOrdered, p.`status`
FROM products p
JOIN orderdetails od
ON p.productCode = od.productCode
WHERE p.`status` = "Best SElling";

-- No.4
ALTER TABLE orders
DROP FOREIGN KEY orders_ibfk_1;

ALTER TABLE orders
ADD CONSTRAINT orders_ibfk_1
FOREIGN KEY (customerNumber)
REFERENCES customers (customerNumber) 
ON DELETE CASCADE
ON UPDATE CASCADE;

ALTER TABLE payments
DROP FOREIGN KEY payments_ibfk_1;

ALTER TABLE payments
ADD CONSTRAINT payments_ibfk_1
FOREIGN KEY (customerNumber)
REFERENCES customers (customerNumber)
ON DELETE CASCADE
ON UPDATE CASCADE;

ALTER TABLE orderdetails
DROP FOREIGN KEY orderDetails_ibfk_1;

ALTER TABLE orderdetails
ADD CONSTRAINT orderdetails_ibfk_1
FOREIGN KEY (orderNumber)
REFERENCES orders (orderNumber)
ON DELETE CASCADE
ON UPDATE CASCADE;

DELETE c
FROM customers c
JOIN orders o
ON c.customerNumber = o.customerNumber
WHERE o.`status` = 'cancelled';

SELECT DISTINCT o.`status` FROM orders o;

-- SOAL TAMBAHAN
SELECT * FROM products;
SELECT * FROM orderdetails;

SELECT products.productName, orderdetails.priceEach
FROM products
JOIN orderdetails
ON products.productCode = orderdetails.productCode
WHERE orderdetails.priceEach < (0.8*products.MSRP);