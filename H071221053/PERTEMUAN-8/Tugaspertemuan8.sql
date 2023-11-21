USE classicmodels

##No 1
(SELECT c.customerName, p.productName, (p.buyprice * sum(od.quantityordered)) 'modal'
FROM customers c
JOIN orders o USING(customernumber)
JOIN orderdetails od USING(ordernumber)
JOIN products p USING(productcode)
GROUP BY c.customerName
ORDER BY modal DESC
LIMIT 3)
UNION
(SELECT c.customerName, p.productName, (p.buyprice * sum(od.quantityordered)) 'modal'
FROM customers c
JOIN orders o USING(customernumber)
JOIN orderdetails od USING(ordernumber)
JOIN products p USING(productcode)
GROUP BY c.customerName
ORDER BY modal
LIMIT 3);

##No 2
SELECT city, COUNT(*) AS total
FROM(
	SELECT offices.city, employees.firstname FROM employees 
	JOIN offices USING(officecode)
	WHERE firstName LIKE 'L%'
	UNION
	SELECT city, customername
	FROM customers c
	WHERE c.customerName LIKE 'L%'
) AS EmployeeCustomerCities
GROUP BY city
ORDER BY total DESC
LIMIT 1;

##No 3
SELECT CONCAT(e.firstname, ' ', e.lastname) AS 'Nama Karyawan/Pelanggan', 'Employee' AS `status`
FROM employees e
WHERE e.officeCode IN ( 
	SELECT officecode
	FROM employees
	GROUP BY officecode
	HAVING COUNT(*) = (
		SELECT officecode
		FROM employees 
		GROUP BY officecode
		ORDER BY COUNT(*)
		LIMIT 1)
		)
UNION 
SELECT c.customername AS 'Nama Karyawan/Pelanggan', 'Customer' AS `status`
FROM customers c
JOIN employees e 
ON c.salesrepemployeenumber = e.employeeNumber
WHERE e.officeCode IN(
		SELECT officecode 
		FROM employees 
		GROUP BY officecode
		HAVING COUNT(*) = (
				SELECT officecode
				FROM employees 
				GROUP BY officecode
				ORDER BY COUNT(*)
				LIMIT 1)
			) 
ORDER BY `Nama Karyawan/Pelanggan`;

##No 4
SELECT tanggal, GROUP_CONCAT(riwayat SEPARATOR ' dan ') AS riwayat
FROM (
	SELECT paymentDate AS tanggal, 'membayar pesanan' AS riwayat 
	FROM payments
	WHERE MONTH(paymentDate) = 4 AND YEAR(paymentdate) = 2003
	UNION 
	SELECT orderdate AS tanggal, 'memesan barang' AS riwayat
	FROM orders
	WHERE MONTH(orderdate) = 4 AND YEAR(orderdate)= 2003
	) AS datacustomers
GROUP BY tanggal
ORDER BY tanggal ASC;

##soal tambahan 
#Tampilkan customer dan employee yang berasal atau bekerja dikantor yang terletak di negara yang diawali dan diakhiri dengan huruf vocal, tampilkan pula status yang menandakan dia customer atau employee
SELECT 
	c.customerName AS nama, 
	c.country AS negara, 'Customer' AS status
FROM 
	customers c
WHERE 
	(c.country LIKE 'a%' OR c.country LIKE 'e%' OR c.country LIKE 'i%' OR c.country LIKE 'o%' OR c.country LIKE 'u%')
	AND (c.country LIKE '%a' OR c.country LIKE '%e' OR c.country LIKE '%i' OR c.country LIKE '%o' OR c.country LIKE '%u')
UNION 
SELECT CONCAT(e.firstName, ' ', e.lastName) AS nama, o.country AS negara, 'Employee' AS STATUS
FROM
 	employees e
JOIN offices o ON e.officeCode = o.officeCode
WHERE (o.country LIKE 'a%' OR o.country LIKE 'e%' OR o.country LIKE 'i%' OR o.country LIKE 'o%' OR o.country LIKE 'u%')
AND (o.country LIKE '%a' OR o.country LIKE '%e' OR o.country LIKE '%i' OR o.country LIKE '%o' OR o.country LIKE '%u')


