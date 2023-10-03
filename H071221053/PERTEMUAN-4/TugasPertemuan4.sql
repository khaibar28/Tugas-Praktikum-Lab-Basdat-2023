##no1
SELECT
    customers.customerName AS Nama_Customer,
    customers.country AS Negara,
    payments.paymentDate AS tanggal
FROM customers
JOIN payments ON customers.customerNumber = payments.customerNumber
WHERE payments.paymentDate > '2004-12-31'
ORDER BY payments.paymentDate DESC;

##no 2
SELECT DISTINCT
    c.customerName AS Nama_Customer,
    p.productName AS productName,
    p.productLine AS textDescription
FROM customers c
JOIN orders o ON c.customerNumber = o.customerNumber
JOIN orderdetails od ON o.orderNumber = od.orderNumber
JOIN products p ON od.productCode = p.productCode
WHERE p.productName = 'The Titanic';

##no3
SELECT * FROM products

ALTER TABLE products 
ADD COLUMN `status` VARCHAR(20);

SELECT p.productCode, p.productName, od.quantityOrdered, p.`status`
FROM products p 
JOIN orderdetails od 
ON od.productCode = p.productCode
ORDER BY od.quantityOrdered DESC 
LIMIT 1

UPDATE products 
SET STATUS = 'best selling'
WHERE productCode = 'S12_4675';

##no 4
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
WHERE o.`status` = 'cancelled';

SELECT * FROM orders 
WHERE orders.`status` = 'cancelled';


##soal tambahan 
SELECT p.productName, orderdetails.priceEach
FROM products p 
JOIN orderdetails USING (productCode) 
WHERE orderdetails.priceEach < (MSRP * 0.8)
ORDER BY orderdetails.priceEach ASC 
