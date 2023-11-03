-- NO.1
(SELECT c.customerName, p.productName,  (p.buyPrice * SUM(od.quantityOrdered)) AS modal 
FROM customers c
JOIN orders o
USING(customerNumber)
JOIN orderdetails od
USING (orderNumber)
JOIN products p
USING(productCode)
GROUP BY c.customerName
ORDER BY modal DESC 
LIMIT 3)
UNION
(SELECT c.customerName, p.productName, (p.buyPrice * SUM(od.quantityOrdered)) AS modal
FROM customers c
JOIN orders o
USING(customerNumber)
JOIN orderdetails od
USING (orderNumber)
JOIN products p
USING(productCode)
GROUP BY c.customerName
ORDER BY modal ASC 
LIMIT 3);

-- NO.2
SELECT city, COUNT(*) AS total
FROM (
    (SELECT o.city, e.firstname
     FROM offices o
     JOIN employees e 
	  USING (officeCode)
     WHERE firstname LIKE 'L%')
    UNION
    (SELECT city, customerName
     FROM customers
     WHERE customerName LIKE 'L%')
) AS kota
GROUP BY city
ORDER BY total DESC
LIMIT 1;

-- NO.3
SELECT CONCAT(e.firstName, ' ', e.lastName) AS NamaKaryawanPelanggan, 'Employee' AS Status
FROM employees e
WHERE e.officeCode IN (
	SELECT officeCode
	FROM employees
	GROUP BY officeCode
	HAVING COUNT(*) = (
		SELECT MIN(employee_count)
		FROM (
		   SELECT COUNT(*) AS employee_count
		   FROM employees
		   GROUP BY officeCode
		) AS OfficeEmployeeCounts
	)
)
UNION
SELECT c.customerName, 'Customer'
FROM customers c
WHERE c.salesRepEmployeeNumber IN (
	SELECT employeeNumber
	FROM employees
	WHERE officeCode IN (
		SELECT officeCode
		FROM employees
		GROUP BY officeCode
		HAVING COUNT(*) = (
	      SELECT MIN(employee_count)
			FROM (
			   SELECT COUNT(*) AS employee_count
			   FROM employees
			   GROUP BY officeCode
			) AS OfficeEmployeeCounts
		)
   )
)
ORDER BY NamaKaryawanPelanggan;

-- NO.4 
SELECT Tanggal, GROUP_CONCAT(status SEPARATOR ' dan ') AS Riwayat
FROM (
    SELECT o.orderDate AS Tanggal, 'memesan barang' AS status
    FROM orders o
    WHERE MONTH(o.orderDate) = 4 AND YEAR(o.orderDate) = 2003
    
    UNION

    SELECT p.paymentDate AS Tanggal, 'membayar pesanan' AS status
    FROM payments p
    WHERE MONTH(p.paymentDate) = 4 AND YEAR(p.paymentDate) = 2003
) AS CombinedData
GROUP BY Tanggal
ORDER BY Tanggal;

-- soal tambahamn
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