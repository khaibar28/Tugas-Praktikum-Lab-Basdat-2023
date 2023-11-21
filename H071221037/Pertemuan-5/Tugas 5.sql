SELECT customers.customerName, products.productName, payments.paymentDate, orders.status
FROM products 
JOIN orderdetails 
USING (productCode)
JOIN orders 
USING (orderNumber)
JOIN customers 
USING (customerNumber)
JOIN payments 
USING (customerNumber)
WHERE products.productName = '1992 Ferrari 360 Spider Red' AND status = 'shipped'
LIMIT 3


# no 2#
SELECT DISTINCT customers.customerName, payments.paymentDate, employees.firstName, employees.lastName
FROM payments 
JOIN customers 
USING (customerNumber)
JOIN employees
ON customers.salesRepEmployeeNumber = employees.employeeNumber
JOIN orders 
USING (customerNumber)
JOIN orderdetails
USING (orderNumber)
WHERE MONTH (payments.paymentDate) = '11'
ORDER BY payments.paymentDate DESC 

# 2 b#
SELECT DISTINCT customers.customerName, payments.paymentDate, CONCAT (employees.firstName, employees.lastName) AS employeeName, payments.amount
FROM payments 
JOIN customers 
USING (customerNumber)
JOIN employees
ON customers.salesRepEmployeeNumber = employees.employeeNumber
JOIN orders 
USING (customerNumber)
JOIN orderdetails
USING (orderNumber)
WHERE MONTH (payments.paymentDate) = '11'
ORDER BY payments.amount DESC 
LIMIT 1


# 2 c#
SELECT customers.customerName, products.productName
FROM payments 
JOIN customers 
USING (customerNumber)
JOIN employees
ON customers.salesRepEmployeeNumber = employees.employeeNumber
JOIN orders 
USING (customerNumber)
JOIN orderdetails
USING (orderNumber)
JOIN products 
USING (productCode)
WHERE MONTH (payments.paymentDate) = '11' AND customers.customerName = 'Corporate Gift Ideas Co.'

# 2 d #
SELECT customers.customerName, GROUP_CONCAT(products.productName) AS productName
FROM payments
JOIN customers 
USING (customerNumber)
JOIN employees 
ON customers.salesRepEmployeeNumber = employees.employeeNumber
JOIN orders
USING (customerNumber)
JOIN orderdetails
USING (orderNumber)
JOIN products 
USING (productCode)
WHERE MONTH (payments.paymentDate) = '11' AND customers.customerName = 'corporate Gift Ideas Co.'
# 3#
SELECT customers.customerName, orders.orderDate, orders.shippedDate
FROM customers
JOIN orders
USING (customerNumber)
WHERE customers.customerName = 'GiftsForHim.com'
ORDER BY orders.orderDate DESC 

# 4 #
SELECT code, lifeExpectancy
FROM country
WHERE code LIKE 'C%K'
ORDER BY lifeExpectancy DESC 
LIMIT 1

# 5#
SELECT orderdetails.priceEach, products.buyPrice ,orderdetails.priceEach - products.buyPrice AS Selisih 
FROM products 
JOIN orderdetails
USING (productCode)

SELECT MAX(amount) AS besar, MIN(amount) AS kecil, (MAX(amount) - MIN(amount)) AS selisih 
FROM payments