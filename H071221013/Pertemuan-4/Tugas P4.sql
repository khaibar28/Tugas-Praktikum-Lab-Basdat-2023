SELECT * FROM customers
SELECT * FROM payments 
SELECT * FROM products
SELECT * FROM orders
SELECT * FROM orderdetails 
SELECT * FROM productlines 
DESCRIBE products

-- No.1
SELECT customers.customerName AS 'Nama Customer', customers.country AS 'Negara', payments.paymentDate AS 'Tanggal'
FROM customers 
JOIN payments 
ON customers.customerNumber = payments.customerNumber 
WHERE payments.paymentDate >= '2005-01-01'
ORDER BY payments.paymentDate ASC;

-- No.2
SELECT DISTINCT customers.customerName AS 'Nama Customer', products.productName, productlines.textDescription
FROM customers
JOIN orders 
ON customers.customerNumber = orders.customerNumber
JOIN orderDetails
ON orders.orderNumber = orderDetails.orderNumber
-- USING (orderNumber)
JOIN products 
ON orderDetails.productCode = products.productCode
JOIN productlines 
ON products.productLine = productlines.productLine
WHERE products.productName = 'The Titanic'

-- No.3
ALTER TABLE products 
ADD `Status` VARCHAR(20);

SELECT products.productCode, products.productName, orderdetails.quantityOrdered, products.`Status`
FROM products
JOIN orderdetails 
ON products.productCode = orderdetails.productCode
ORDER BY orderdetails.quantityOrdered DESC
LIMIT 1;

UPDATE products 
SET `Status` = 'Best Selling'
WHERE productCode = 'S12_4675';

-- No.4
SELECT * FROM orders
WHERE `status` = 'cancelled'

ALTER TABLE orderdetails 
DROP FOREIGN KEY orderdetails_ibfk_1;

ALTER TABLE orderdetails 
ADD FOREIGN KEY (orderNumber) REFERENCES orders(orderNumber)
ON DELETE CASCADE;

ALTER TABLE payments 
DROP FOREIGN KEY payments_ibfk_1;

ALTER TABLE payments 
ADD FOREIGN KEY (customerNumber) REFERENCES customers(customerNumber)
ON DELETE CASCADE;

ALTER TABLE orders 
DROP FOREIGN KEY orders_ibfk_1;

ALTER TABLE orders 
ADD FOREIGN KEY (customerNumber) REFERENCES customers(customerNumber)
ON DELETE CASCADE;

DELETE c
FROM  customers c
JOIN orders o
USING(customerNumber)
WHERE o.`status` = 'cancelled'

-- soal tambahan 
SELECT * FROM products
SELECT * FROM orders

SELECT products.productName, orders.orderDate
FROM products
JOIN orderdetails
USING (productCode)
JOIN orders 
USING (orderNumber)
WHERE productName = '1940 Ford Pickup Truck'
ORDER BY orders.orderDate DESC;
