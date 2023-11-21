USE classicmodels;

-- NOMOR 1
SELECT * FROM customers
SELECT * FROM payments

SELECT customers.customerName AS 'Nama Customer', customers.country AS 'Negara', payments.paymentDate AS 'tanggal'
FROM customers
JOIN payments
ON customers.customerNumber = payments.customerNumber
WHERE paymentDate >= '2005-01-01'
ORDER BY paymentDate;

-- NOMOR 2
SELECT * FROM customers
SELECT * FROM orders
SELECT * FROM orderdetails
SELECT * FROM products
SELECT * FROM productlines 

SELECT DISTINCT customers.customerName AS 'Nama Customer', products.productName, productlines.textDescription
FROM customers
JOIN orders
ON customers.customerNumber = orders.customerNumber
JOIN orderdetails
ON orders.orderNumber = orderdetails.orderNumber
JOIN products
ON orderdetails.productCode = products.productCode
JOIN productlines
ON products.productLine = productlines.productLine
WHERE productName = 'The Titanic'

-- NOMOR 3
SELECT * FROM products
SELECT * FROM orderdetails

ALTER TABLE products
ADD `status` VARCHAR (20);

SELECT * FROM orderdetails
ORDER BY quantityOrdered DESC
LIMIT 1;

UPDATE products
SET `status` = 'best selling'
WHERE productCode = 'S12_4675';

SELECT products.productCode, products.productName, orderdetails.quantityOrdered, products.status
FROM products
JOIN orderdetails
USING (productCode)
ORDER BY quantityOrdered DESC
LIMIT 1;

-- NOMOR 4
SELECT * FROM customers 
SELECT * FROM orders
WHERE STATUS = 'cancelled'

ALTER TABLE orders 
DROP FOREIGN KEY orders_ibfk_1;
ALTER TABLE orders 
ADD FOREIGN KEY (customerNumber) REFERENCES customers(customerNumber) ON DELETE CASCADE;

ALTER TABLE orderdetails 
DROP FOREIGN KEY orderdetails_ibfk_1;
ALTER TABLE orderdetails 
ADD FOREIGN KEY (orderNumber) REFERENCES orders(orderNumber) ON DELETE CASCADE;

ALTER TABLE payments 
DROP FOREIGN KEY payments_ibfk_1;
ALTER TABLE payments 
ADD FOREIGN KEY (customerNumber) REFERENCES customers(customerNumber) ON DELETE CASCADE;

DELETE customers FROM customers
JOIN orders
USING (customerNumber)
WHERE STATUS = 'Cancelled'
SELECT * FROM orders
WHERE `status` = 'Cancelled'

-- SOAL TAMBAHAN
-- Tampilkan semua employee beserta managernya (jika ada)

SELECT * FROM employees

SELECT * FROM employees
WHERE reportsTo = 1056

SELECT emp1.lastName , emp1.firstName , emp1.jobTitle AS "Job Title Employees", emp2.jobTitle AS "Job Title Manager" 
FROM employees as emp2
RIGHT JOIN employees AS emp1
ON emp2.employeeNumber = emp1.reportsTo
