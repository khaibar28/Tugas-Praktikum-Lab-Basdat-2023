USE classicmodels;

##no1
SELECT customers.customerName, products.productName, payments.paymentDate, orders.`status`
FROM customers
JOIN payments USING(customerNumber)
JOIN orders USING(customerNumber)
JOIN orderdetails USING(orderNumber)
JOIN products USING(productCode)
WHERE products.productName LIKE '1992%' AND customers.customerName = 'Signal Gift Stores';

##no2
#a
SELECT customers.customerName, payments.paymentDate, employees.lastName, employees.firstName
FROM customers
JOIN payments USING(customerNumber)
JOIN employees on employees.employeeNumber = customers.salesRepEmployeeNumber
WHERE MONTH(payments.paymentDate) = 11;

#b
SELECT customers.customerName, payments.paymentDate, employees.lastName, employees.firstName
FROM customers
JOIN payments USING(customerNumber)
JOIN employees on employees.employeeNumber = customers.salesRepEmployeeNumber
WHERE MONTH(payments.paymentDate) = 11 ORDER BY payments.amount DESC  
LIMIT 1;

#c
SELECT customers.customerName, products.productName 
FROM customers
JOIN payments USING(customerNumber)
JOIN orders USING(customerNumber)
JOIN orderdetails USING(orderNumber)
JOIN products USING(productCode)
WHERE MONTH(payments.paymentDate) = 11 AND customers.customerName = 'Corporate Gift Ideas Co.'

#d
SELECT customers.customerName, group_concat(products.productName) AS productName
FROM customers
JOIN payments USING(customerNumber)
JOIN orders USING(customerNumber)
JOIN orderdetails USING(orderNumber)
JOIN products USING(productCode)
WHERE MONTH(payments.paymentDate) = 11 AND customers.customerName = 'Corporate Gift Ideas Co.'


##no3
SELECT customers.customerName, orders.orderDate, orders.shippedDate, 
DATEDIFF(orders.shippedDate, orders.orderDate) AS 'lama menunggu'
FROM customers
JOIN orders USING(customerNumber)
WHERE customers.customerName = 'GiftsForHim.com';

##no4
USE world;
SELECT country.Name, country.Code, country.LifeExpectancy
FROM country
WHERE country.Code LIKE 'c%k' AND country.LifeExpectancy IS NOT NULL;





