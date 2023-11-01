USE classicmodels

-- No.1
SELECT * FROM offices 
SELECT * FROM employees
SELECT * FROM payments

SELECT DISTINCT CONCAT_WS('|', o.addressline1, o.addressline2, o.city, o.country) AS Alamat, c.customerNumber, COUNT(py.amount) AS 'Banyak Pembayaran', py.amount AS 'Jumlah Pembayaran'
FROM employees e
JOIN offices o
USING(officeCode)
JOIN customers c
ON c.salesRepEmployeeNumber = e.employeeNumber
JOIN payments py
USING(customerNumber)
GROUP BY c.customerNumber
HAVING COUNT(py.amount) = (
		SELECT COUNT(py.amount)
		FROM payments py
		GROUP BY py.amount
		LIMIT 1
	);

-- NO.2
SELECT CONCAT(e.firstName, ' ', e.lastName) AS 'Nama Employee', SUM(py.amount) AS Pendapatan
FROM employees e
JOIN customers c
ON e.employeeNumber = c.salesRepEmployeeNumber
JOIN payments py
USING(customernumber)
GROUP BY e.employeeNumber
HAVING SUM(py.amount) = 
	(SELECT SUM(py.amount)
	FROM employees e
	JOIN customers c
	ON e.employeeNumber = c.salesRepEmployeeNumber
	JOIN payments py
	USING(customernumber)
	GROUP BY e.employeeNumber
	ORDER BY SUM(py.amount) DESC
	LIMIT 1) OR
SUM(py.amount) = 
	(SELECT SUM(py.amount)
	FROM employees e
	JOIN customers c
	ON e.employeeNumber = c.salesRepEmployeeNumber
	JOIN payments py
	USING(customernumber)
	GROUP BY e.employeeNumber
	ORDER BY SUM(py.amount) ASC
	LIMIT 1);
	 
-- No.3
SELECT * FROM country
SELECT * FROM countrylanguage

SELECT c.`Name` AS 'Negara', (c.Population * (cl.Percentage/100)) AS 'Pengguna Bahasa'
FROM country c
JOIN countrylanguage cl
ON c.`Code` = cl.CountryCode
WHERE cl.`Language` = (SELECT cl.Language 
		FROM countrylanguage cl
		JOIN country c
		ON c.`Code` = cl.CountryCode
		WHERE c.Continent = "Asia"
		GROUP BY cl.`Language`
		ORDER BY COUNT(cl.`Language`) DESC
		LIMIT 1
		);

-- No.4
SELECT * FROM orderdetails 

SELECT c.customerName,
		SUM(py.amount) AS Total_Pembayaran,
		SUM(od.quantityOrdered) AS Banyak_Barang,
		GROUP_CONCAT(p.productName) AS 'Produk Yang Dibeli'
FROM customers c
JOIN payments py 
USING(customerNumber)
JOIN orders o
USING(customerNumber)
JOIN orderdetails od
USING(orderNumber)
JOIN products p
USING(productCode)
GROUP BY c.customerName
HAVING SUM(py.amount) > (
		SELECT AVG(total)
		FROM(
			SELECT SUM(py.amount) AS total
			FROM payments py
			GROUP BY py.customerNumber) AS Total_Pembayaran)
		ORDER BY SUM(od.quantityOrdered) DESC;		
		
-- Soal Tambahan
SELECT * FROM employees

SELECT CONCAT(firstName, ' ', lastName) AS Daftar_Karyawan, reportsTo
FROM employees 
WHERE  reportsTo IN 
	( SELECT e2.employeeNumber
	  FROM employees e2
	  JOIN employees e3
	  ON e2.reportsTo = e3.employeeNumber
	  WHERE e3.firstName = 'Diane' AND e3.lastName = 'Murphy'
	);