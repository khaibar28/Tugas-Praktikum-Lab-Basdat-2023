USE classicmodels
-- No.1
SELECT CONCAT_WS(' ', offices.addressline1, offices.addressLine2, offices.city, offices.country) AS "Alamat Lengkap", customers.customerNumber, COUNT(payments.amount) AS "Banyak Pembayaran"
FROM employees
JOIN customers
ON employees.employeeNumber = customers.salesRepEmployeeNumber
JOIN offices
USING (OfficeCode)
JOIN payments
USING (customerNumber)
GROUP BY customerNumber
HAVING COUNT(payments.amount) =
	(SELECT COUNT(payments.amount) FROM payments
	GROUP BY customerNumber
	ORDER BY COUNT(payments.amount) ASC
	LIMIT 1);
	
-- No.2
SELECT CONCAT(employees.firstName, ' ', employees.lastName) AS "Nama Employee", SUM(payments.amount) AS "Pendapatan"
FROM employees
JOIN customers
ON employees.employeeNumber = customers.salesRepEmployeeNumber
JOIN payments
USING (customerNumber)
GROUP BY employees.employeeNumber
HAVING SUM(payments.amount) =
	(SELECT MAX(total_amount)
	FROM 
		(SELECT SUM(payments.amount) AS total_amount
		FROM customers
		JOIN payments
		USING (customerNumber)
		GROUP BY customers.salesRepEmployeeNumber) AS Max_Pembayaran)
OR SUM(payments.amount) =
	(SELECT MIN(total_amount)
	FROM
		(SELECT SUM(payments.amount) AS total_amount
		FROM customers 
		JOIN payments
		USING (customerNumber)
		GROUP BY customers.salesRepEmployeeNumber) AS Min_Pembayaran);
		
-- No.3
USE world
SELECT percentage FROM countrylanguage;
SELECT population FROM country;
SELECT * FROM countryLanguage

SELECT country.name AS "Negara", country.population*countrylanguage.percentage/100 AS "Pengguna Bahasa"
FROM country 
JOIN countrylanguage 
ON country.code = countrylanguage.countryCode
WHERE countrylanguage.`Language` = (
	SELECT countrylanguage.`Language` 
	FROM countrylanguage
	JOIN country
	ON country.code = countrylanguage.countryCode
	WHERE country.continent = "Asia"
	GROUP BY countrylanguage.`Language`
	ORDER BY COUNT(countrylanguage.`Language`) DESC
	LIMIT 1
	);
	
-- No.4
SELECT customers.customerName, SUM(payments.amount) AS "Total Pembayaran", SUM(orderdetails.quantityOrdered) AS "Banyak Barang", GROUP_CONCAT(products.productName SEPARATOR ', ') AS "Produk yang Dibeli"
FROM customers
JOIN payments
USING (customerNumber)
JOIN orders
USING (customerNumber)
JOIN orderdetails
USING (orderNumber)
JOIN products 
USING (productCode)
GROUP BY customers.customerName
HAVING SUM(payments.amount) > (
	SELECT AVG(total)
	FROM (
		SELECT SUM(payments.amount) AS total
		FROM customers
		JOIN payments
		USING (customerNumber)
		GROUP BY customers.customerNumber) AS avg_total);
		
-- Soal Tambahan
-- No.2
SELECT offices.officeCode
FROM offices
JOIN employees
USING (officeCode)
WHERE employees.employeeNumber = (
	SELECT employees.employeeNumber
	FROM employees
	JOIN customers
	ON employees.employeeNumber = customers.salesRepEmployeeNumber
	GROUP BY employees.employeeNumber
	ORDER BY COUNT(customers.customerNumber) DESC
	LIMIT 1);
	
-- No.4
SELECT customerName, LENGTH(customerName)
FROM customers
WHERE LENGTH(customerName) = (
	SELECT MAX(LENGTH(customerName))
	FROM customers)
OR LENGTH(customerName) = (
	SELECT MIN(LENGTH(customerName))
	FROM customers);