-- Nomor 1
USE classicmodels;

SELECT o.addressLine1, o.addressLine2, o.state, o.country
FROM offices AS o
JOIN employees AS e USING (officeCode)
JOIN customers AS c ON e.employeeNumber = c.salesRepEmployeeNumber
JOIN payments AS p USING (customerNumber)
GROUP BY p.customerNumber
HAVING COUNT(p.customerNumber) = (SELECT COUNT(customerNumber) FROM payments GROUP BY customerNumber ORDER BY COUNT(customerNumber) LIMIT 1);
									
-- Nomor 2
USE classicmodels;

SELECT CONCAT(e.firstName, ' ', e.lastName) AS 'nama employee', p.amount AS 'pendapatan'
FROM employees AS e
JOIN customers AS c ON e.employeeNumber = c.salesRepEmployeeNumber
JOIN payments AS p USING (customerNumber)
WHERE p.amount = (SELECT MAX(amount) FROM payments) 
	OR p.amount = (SELECT MIN(amount) FROM payments);
	
-- Nomor 3
USE world;

SELECT c.`Name` AS 'Negara', (c.Population * (cl.Percentage/100)) AS 'Pengguna Bahasa'
FROM country AS c
JOIN countrylanguage AS cl ON c.`Code` = cl.CountryCode
WHERE cl.`Language` = ( SELECT cl.`Language`
								FROM countrylanguage AS cl
								JOIN country AS c ON cl.CountryCode = c.`Code`
								WHERE c.Continent = 'Asia'
								GROUP BY cl.`Language`
								ORDER BY COUNT(cl.`Language`) DESC
								LIMIT 1 );
								
-- Nomor 4
USE classicmodels;

SELECT c.customerName, 
		CEIL(SUM(p.amount)) AS 'Total pembayaran', 
		SUM(od.quantityOrdered) AS 'banyak barang', 
		GROUP_CONCAT(pr.productName SEPARATOR ', ') AS 'produk yang dibeli'
FROM customers AS c
JOIN payments AS p USING (customerNumber)
JOIN orders AS o USING (customerNumber)
JOIN orderdetails AS od USING (orderNumber)
JOIN products AS pr USING (productCode)
GROUP BY c.customerNumber
HAVING SUM(p.amount) > (SELECT AVG(amount) FROM payments);

-- Nomor 5
USE classicmodels;

SELECT e.employeeNumber, CONCAT(e.firstName, ' ', e.lastName) AS 'Nama Karyawan'
FROM employees AS e
JOIN offices AS o USING (officeCode)
WHERE o.officeCode = ( SELECT officeCode FROM offices WHERE officeCode LIKE '%0' )
	OR o.officeCode = ( SELECT officeCode FROM offices WHERE officeCode LIKE '%2' )
	OR o.officeCode = ( SELECT officeCode FROM offices WHERE officeCode LIKE '%4' )
	OR o.officeCode = ( SELECT officeCode FROM offices WHERE officeCode LIKE '%6' )
	OR o.officeCode = ( SELECT officeCode FROM offices WHERE officeCode LIKE '%8' );