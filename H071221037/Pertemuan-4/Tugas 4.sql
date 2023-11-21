# No 1#
SELECT c.customerName AS 'Nama Customer', c.country AS 'Negara', p.paymentDate AS 'tanggal'
FROM customers c
JOIN payments p
ON c.customerNumber = p.customerNumber
#WHERE YEAR (p.paymentDate) >= 2005 
WHERE p.paymentDate > '2004-12-31'
ORDER BY p.paymentDate DESC 

# No 2 #
SELECT DISTINCT c.customerName, p.productName, pl.textDescription
FROM customers c
JOIN orders o 
ON c.customerNumber = o.customerNumber
JOIN orderdetails od 
ON o.orderNumber = od.orderNumber
JOIN products p 
ON od.productCode = p.productCode
JOIN productlines pl 
ON p.productLine = pl.productLine
WHERE p.productName = 'The Titanic';

# No 3 #
ALTER TABLE products
ADD COLUMN status VARCHAR (20);
SELECT p.productCode, p.productName, od.quantityOrdered, p.`status`
FROM orderdetails od
JOIN products p
ON od.productCode = p.productCode 
ORDER BY od.quantityOrdered DESC 
LIMIT 1
UPDATE products  p
SET p.`status` = 'best selling'
WHERE p.productCode = 'S12_4675'

# no 4#

ALTER TABLE payments DROP FOREIGN KEY payments_ibfk_1;     
ALTER TABLE payments ADD FOREIGN KEY (customerNumber) REFERENCES customers (customerNumber) ON DELETE CASCADE;

ALTER TABLE orders DROP FOREIGN KEY orders_ibfk_1;     
ALTER TABLE orders ADD FOREIGN KEY (customerNumber) R odEFERENCES customers (customerNumber) ON DELETE CASCADE;

ALTER TABLE orderdetails DROP FOREIGN KEY orderdetails_ibfk_1;     
ALTER TABLE orderdetails ADD FOREIGN KEY (orderNumber) REFERENCES orders (orderNumber) ON DELETE CASCADE;

SELECT DISTINCT c.customerNumber, c.customerName, o.`status`
FROM customers c
JOIN orders o
ON c.customerNumber = o.customerNumber
JOIN orderdetails od 
ON o.orderNumber = od.orderNumber
WHERE o.status = 'cancelled'

DELETE c
FROM customers c 
JOIN orders o
ON c.customerNumber = o.customerNumber
WHERE o.status = 'cancelled'

SELECT products.productName, orders.orderDate
FROM products 
JOIN orderdetails 
USING (productCode)
JOIN orders 
USING (orderNumber)
WHERE productName = '1940 Ford Pickup Truck'
ORDER BY orders.orderDate DESC 

    
