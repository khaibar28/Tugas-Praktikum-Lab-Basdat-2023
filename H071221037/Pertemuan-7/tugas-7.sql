# No 1#
SELECT DISTINCT offices.addressLine1, offices.addressLine2, offices.city, offices.country
FROM offices
JOIN employees
USING(officeCode)
JOIN customers
ON customers.salesRepEmployeeNumber = employees.employeeNumber
JOIN payments
USING(customerNumber)
GROUP BY customers.customerNumber 
HAVING COUNT(*) = 
(SELECT COUNT(*)
FROM payments
GROUP BY customerNumber
ORDER BY COUNT(*)
LIMIT 1);
		
# No 2#
SELECT CONCAT(employees.firstName, ' ', employees.firstName) AS 'nama employee', sum(payments.amount) AS 'pendapatan'
FROM employees
JOIN customers
ON employees.employeeNumber = customers.salesRepEmployeeNumber
JOIN payments
USING(customerNumber)
WHERE employees.employeeNumber =
(SELECT employeenumber
	FROM employees 
	JOIN customers  
	ON employees.employeeNumber = customers.salesRepEmployeeNumber
	JOIN payments  
	USING (customernumber)
	GROUP BY employees.employeeNumber
	ORDER BY SUM(payments.amount) ASC
	LIMIT 1)
OR employees.employeeNumber = 
(SELECT employeenumber
	FROM employees e
	JOIN customers c ON e.employeeNumber = c.salesRepEmployeeNumber
	JOIN payments p USING (customernumber)
	GROUP BY e.employeeNumber
	ORDER BY SUM(p.amount) DESC
	LIMIT 1)
GROUP BY CONCAT(employees.firstName, ' ', employees.lastName);

# No 3#


SELECT country.`Name` AS Negara, ((country.Population * countrylanguage.Percentage) / 100 ) AS 'Pengguna Bahasa' 
from country
JOIN countrylanguage
ON countrylanguage.CountryCode = country.`Code`  
WHERE countrylanguage.`Language` = 
(SELECT countrylanguage.`Language`
FROM country
JOIN countrylanguage
ON country.Code = countrylanguage.CountryCode
WHERE country.Continent= 'Asia'
GROUP BY countrylanguage.`Language`
ORDER BY COUNT(countrylanguage.`Language`) DESC 
LIMIT 1
) 

# No 4#
SELECT customers.customerName, 
		SUM(payments.amount) AS 'Total pembayaran', 
		SUM(orderdetails.quantityOrdered) AS 'banyak barang', 
		GROUP_CONCAT(products.productName SEPARATOR ', ') AS 'produk yang dibeli'
FROM customers 
JOIN payments  
USING (customerNumber)
JOIN orders 
USING (customerNumber)
JOIN orderdetails 
USING (orderNumber)
JOIN products 
USING (productCode)
GROUP BY c.customerNumber
HAVING SUM(p.amount) > 
(SELECT AVG(total)
FROM (SELECT SUM(payments.amount) AS total
FROM payments 
GROUP BY customernumber) AS totalpembayaran)
ORDER BY c.customername

SELECT DISTINCT products.productName, customers.creditLimit BETWEEN 1 AND 50000
FROM products
JOIN orderdetails
USING(productCode)
JOIN orders
USING(orderNumber)
JOIN customers
USING(customerNumber)
GROUP BY customers.customerName

SELECT customers.customerName, GROUP_CONCAT(products.productName SEPARATOR ', ') AS 'produk'
FROM products
JOIN orderdetails
USING(productCode)
JOIN orders
USING(orderNumber)
JOIN customers
USING(customerNumber)
WHERE customers.customerName IN 
(SELECT customers.customerName FROM customers WHERE creditLimit BETWEEN 1 AND 50000)
GROUP BY customers.customerName;

SELECT employees.firstName, employees.lastName
FROM employees
JOIN customers
ON employees.employeeNumber = customers.salesRepEmployeeNumber
JOIN orders
USING(customerNumber)
JOIN orderdetails
USING(orderNumber)
JOIN products
USING(productCode)
WHERE products.productCode = 
(SELECT products.productCode
FROM products
GROUP BY products.productCode
ORDER BY SUM(quantityInStock)DESC 
LIMIT 1)

