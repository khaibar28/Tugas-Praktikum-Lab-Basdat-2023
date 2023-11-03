# No 1# 
(SELECT customers.customerName, products.productName, (products.buyPrice * SUM(orderdetails.quantityOrdered)) AS Modal
FROM customers
JOIN orders
USING(customerNumber)
JOIN orderdetails
USING(orderNumber)
JOIN products
USING(productCode)
GROUP BY customers.customerName
ORDER BY modal DESC 
LIMIT 3)
UNION
(SELECT customers.customerName, products.productName, (products.buyPrice * SUM(orderdetails.quantityOrdered)) AS Modal
FROM customers
JOIN orders
USING(customerNumber)
JOIN orderdetails
USING(orderNumber)
JOIN products
USING(productCode)
GROUP BY customers.customerName
ORDER BY modal ASC 
LIMIT 3)

# No 2#
SELECT Kota FROM (
	SELECT 
		CONCAT(employees.firstName, ' ', employees.lastName) AS `Nama Karyawan`,
		offices.city AS Kota
	FROM employees
	JOIN offices
	USING(officeCode)
	WHERE CONCAT(employees.firstName, ' ', employees.lastName) LIKE 'L%'
	union
	SELECT customerName, city AS Kota
	FROM customers
	WHERE customerName LIKE 'L%'
) AS Kota
GROUP BY Kota
ORDER BY COUNT(`Nama Karyawan`) DESC LIMIT 1

# No 3#
(SELECT customers.customerName AS 'Nama Karyawan / Pelanggan', 'Pelanggan' AS `Status`
FROM customers
JOIN employees
ON customers.salesRepEmployeeNumber = employees.employeeNumber
JOIN offices
USING(officeCode)
WHERE offices.officeCode IN 
	(SELECT offices.officeCode
	FROM employees
	JOIN offices
	USING(officeCode)
	GROUP BY offices.officeCode
	HAVING COUNT(employees.employeeNumber) =
		(SELECT COUNT(employees.employeeNumber)
		FROM employees
		JOIN offices
		USING(officeCode)
		GROUP BY offices.officeCode
		ORDER BY COUNT(employees.employeeNumber)
		LIMIT 1 ) ) )
UNION
(SELECT CONCAT(employees.firstName, ' ', employees.lastName) AS 'nama Karyawan / Pelanggann', 'Karyawan' AS `Status`
FROM employees
JOIN offices
USING(officeCode)
WHERE offices.officeCode IN 
	(SELECT offices.officeCode
	FROM employees
	JOIN offices
	USING(officeCode)
	GROUP BY offices.officeCode
	HAVING COUNT(employees.employeeNumber) =
		(SELECT COUNT(employees.employeeNumber)
		FROM employees
		JOIN offices
		USING(officeCode)
		GROUP BY offices.officeCode
		ORDER BY COUNT(employees.employeeNumber)
		LIMIT 1 ) ) )
		

# No 4#
SELECT DISTINCT payments.paymentDate AS 'Tanggal', 'Membayar Pesanan' AS `riwayat`
FROM payments
WHERE YEAR(payments.paymentDate) = '2003' AND MONTH(payments.paymentDate) = '04' AND payments.paymentDate NOT IN 
(SELECT orderDate
FROM orders
WHERE YEAR(orderDate) = '2003' AND MONTH(orderDate) = '04') 
UNION 
SELECT orderDate AS 'Tanggal', 'Memesan Barang' AS `riwayat`
FROM orders
WHERE YEAR(orderDate) = '2003' AND MONTH(orderDate) = '04' AND orderDate NOT IN
(SELECT DISTINCT paymentDate
FROM payments
WHERE YEAR(paymentDate) = '2003' AND MONTH(paymentDate) = '04')
UNION
SELECT orderDate AS 'Tanggal', 'Membayar Pesanan dan Memesan Barang' AS `riwayat`
FROM orders
WHERE orderDate IN 
(SELECT DISTINCT paymentDate
FROM payments
WHERE YEAR(paymentDate) = '2003' AND MONTH(paymentDate) = '04')
ORDER BY Tanggal ASC 

# No 5#
SELECT productLine, productName, totalSale, 'Terlaris' AS Status
FROM (
    SELECT productLine, productName, SUM(quantityOrdered) AS totalSale
    FROM products
    JOIN orderdetails 
	 USING(productCode)
    GROUP BY productLine, productName
    ORDER BY productLine, totalSale DESC
) AS MostSold
GROUP BY productLine

UNION 

SELECT productLine, productName, totalSale, 'Kurang Laris' AS Status
FROM (
    SELECT productLine, productName, SUM(quantityOrdered) AS totalSale
    FROM products
    JOIN orderdetails 
    USING(productCode)
    GROUP BY productLine, productName
    ORDER BY productLine, totalSale ASC
) AS LeastSold
GROUP BY productLine
ORDER BY productLine, totalSale DESC 



