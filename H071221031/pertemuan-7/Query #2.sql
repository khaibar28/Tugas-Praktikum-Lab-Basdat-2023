# Nomor 1		
SELECT distinct CONCAT_WS(' ', o.addressline1, o.addressLine2, o.city, o.country) AS "Alamat Lengkap"
FROM employees e
JOIN customers c
ON e.employeeNumber = c.salesRepEmployeeNumber
JOIN offices o
USING(officeCode)
JOIN payments p
USING(customerNumber)
GROUP BY customerNumber
HAVING COUNT(p.amount) =
	(SELECT COUNT(payments.amount) FROM payments
	GROUP BY customerNumber
	ORDER BY COUNT(payments.amount) ASC
	LIMIT 1);

-- nomor2
SELECT CONCAT_WS( ' ',e.firstName, e.lastName) 'nama employee', SUM(p.amount) 'pendapatan'
FROM employees e
JOIN customers c
ON e.employeeNumber = c.salesRepEmployeeNumber
JOIN payments p
USING (customernumber)
GROUP BY e.employeeNumber
HAVING SUM(p.amount) = 
		(SELECT SUM(p.amount) FROM payments p
		JOIN customers c
		USING (customernumber)
		JOIN employees e
		ON e.employeeNumber = c.salesRepEmployeeNumber
		GROUP BY e.employeeNumber
		ORDER BY SUM(p.amount) DESC
		LIMIT 1,1)
OR SUM(p.amount) = 
		(SELECT SUM(p.amount) FROM payments p
		JOIN customers c
		USING (customernumber)
		JOIN employees e
		ON e.employeeNumber = c.salesRepEmployeeNumber
		GROUP BY e.employeeNumber
		ORDER BY SUM(p.amount)
		LIMIT 1,1);

-- Nomor 3 
USE world;
SELECT
    c.Name 'Negara',
    (c.Population * (cl.Percentage/100)) 'Pengguna Bahasa'
FROM country c
JOIN countrylanguage cl
ON c.`Code` = cl.CountryCode
WHERE cl.language = 
	(SELECT countrylanguage.language
	FROM countrylanguage
	JOIN country
	ON country.Code = countrylanguage.CountryCode
	WHERE country.Continent = 'Asia'
	GROUP BY countrylanguage.language
	ORDER BY COUNT(countrylanguage.language) DESC
	LIMIT 1);

-- Nomor 4 
USE classicmodels;

SELECT c.customerName, 
		SUM(p.amount) AS 'Total pembayaran', 
		SUM(od.quantityOrdered) 'banyak barang', 
		GROUP_CONCAT(pr.productName SEPARATOR '; ')'produk yang dibeli'
FROM payments p
JOIN customers c
USING (customerNumber)
JOIN orders o
USING (customerNumber)
JOIN orderdetails od
USING (orderNumber)
JOIN products pr
USING (productcode)
GROUP BY customerNumber
HAVING SUM(p.amount) > 
		(SELECT AVG(jumlah)
		FROM (
			SELECT SUM(amount) 'jumlah'
			FROM payments
			GROUP BY customernumber) AS a)
ORDER BY c.customerName;

#Tampilkan jumlah barang yang pernah dibeli oleh masing-masing customer
SELECT c.customerName, 
       (SELECT COUNT(od.quantityOrdered) 
        FROM orders o
        JOIN orderdetails od
        USING(orderNumber)
        JOIN products p
        USING(productCode)
        WHERE o.customerNumber = c.customerNumber) as 'banyak_barang'
FROM customers c
ORDER BY banyak_barang DESC;



#Tampilkan karyawan yang tidak pernah melayani pelanggan
SELECT e.employeeNumber, e.jobTitle
FROM employees e
WHERE e.employeeNumber NOT IN (
    SELECT DISTINCT c.salesRepEmployeeNumber
    FROM customers c
    WHERE c.salesRepEmployeeNumber IS NOT NULL
);