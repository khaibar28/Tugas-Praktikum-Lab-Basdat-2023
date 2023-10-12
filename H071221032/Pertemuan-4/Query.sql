#1
SELECT C.customerName, C.country,  P.paymentDate 
FROM customers AS C
JOIN payments AS P
ON C.customerNumber = P.customerNumber
WHERE P.paymentDate > '2004-12-31'
ORDER BY P.paymentDate asc;

#2
SELECT distinct C.customerName, P.productName, P.productDescription
FROM customers AS C
JOIN orders
ON C.customerNumber = orders.customerNumber
JOIN orderdetails
ON orders.orderNumber = orderdetails.orderNumber
JOIN products AS P
ON P.productCode = orderdetails.productCode
WHERE P.productName = "The Titanic";

#3
ALTER TABLE products
ADD COLUMN status VARCHAR(20);

SELECT * FROM orderdetails;

SELECT P.productCode, O.quantityOrdered
FROM products AS P
join orderdetails AS O
ON p.productCode = O.productCode
WHERE P.productCode = 'S12_4675'
ORDER BY O.quantityOrdered DESC;

UPDATE products AS P
SET P.status = 'Best Selling'
WHERE P.productCode = 'S12_4675';

ALTER TABLE products
DROP column status;

SELECT P.productCode, P.productName,  P.status
FROM products AS P;

#4
ALTER TABLE payments 
DROP FOREIGN KEY payments_ibfk_1;

ALTER TABLE payments
ADD CONSTRAINT payments_ibfk_1
FOREIGN KEY (customorderserNumber)
REFERENCES customers(customerNumber) ON delete CASCADE;

ALTER TABLE orders 
DROP FOREIGN KEY orders_ibfk_1;

ALTER TABLE orders
ADD CONSTRAINT orders_ibfk_1
FOREIGN KEY (customerNumber)
REFERENCES customers(customerNumber) ON delete CASCADE;

ALTER TABLE orderdetails 
DROP FOREIGN KEY orderdetails_ibfk_1;

ALTER TABLE orderdetails
ADD CONSTRAINT orderdetails_ibfk_1
FOREIGN KEY (orderNumber)
REFERENCES orders(orderNumber) ON delete CASCADE;

DELETE C, O
FROM customers AS C
JOIN orders AS O
ON C.customerNumber = O.customerNumber
WHERE O.status = 'Cancelled';
