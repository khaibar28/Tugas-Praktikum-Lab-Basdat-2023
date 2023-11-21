-- Nomor 1
USE classicmodels;

(	SELECT c.customerName, p.productName, SUM(od.quantityOrdered * od.priceEach) AS 'modal'
	FROM customers AS c
	JOIN orders AS o USING (customerNumber)
	JOIN orderdetails AS od USING (orderNumber)
	JOIN products AS p USING (productCode)
	GROUP BY o.customerNumber
	ORDER BY SUM(od.quantityOrdered * od.priceEach) DESC
	LIMIT 3	)
UNION
(	SELECT c.customerName, p.productName, SUM(od.quantityOrdered * od.priceEach) AS 'modal'
	FROM customers AS c
	JOIN orders AS o USING (customerNumber)
	JOIN orderdetails AS od USING (orderNumber)
	JOIN products AS p USING (productCode)
	GROUP BY o.customerNumber
	ORDER BY SUM(od.quantityOrdered * od.priceEach) ASC
	LIMIT 3);
	
-- Nomor 2
USE classicmodels;

(	SELECT o.city FROM offices AS o
	JOIN employees AS e USING (officeCode)
	WHERE e.firstName LIKE 'L%'
	GROUP BY e.employeeNumber
	ORDER BY COUNT(*) DESC
	LIMIT 1	)
UNION
(	SELECT c.city FROM customers AS c
	WHERE c.customerName LIKE 'L%'
	GROUP BY c.city
	ORDER BY COUNT(*) DESC
	LIMIT 1	);

-- Nomor 3
USE classicmodels;

(	SELECT c.customerName AS 'Nama Karyawan/Pelanggan', 'Pelanggan' AS 'status'
	FROM customers AS c
	JOIN employees AS e ON c.salesRepEmployeeNumber = e.employeeNumber
	WHERE e.officeCode IN ( SELECT officeCode FROM employees
								   GROUP BY officeCode 
								   HAVING COUNT(employeeNumber) = ( SELECT COUNT(employeeNumber) FROM employees
									 		  									GROUP BY (officeCode) 
									 		  									ORDER BY COUNT(employeeNumber) 
																				LIMIT 1	) ) )
UNION
(	SELECT CONCAT(firstName, ' ', lastName), 'Karyawan'
	FROM employees AS e
	WHERE e.officeCode IN ( SELECT officeCode FROM employees
								   GROUP BY officeCode 
								   HAVING COUNT(employeeNumber) = ( SELECT COUNT(employeeNumber) FROM employees
									 		  									GROUP BY (officeCode) 
									 		  									ORDER BY COUNT(employeeNumber) 
																				LIMIT 1	) ) )
ORDER BY `Nama Karyawan/Pelanggan`;

-- Nomor 4
USE classicmodels;

(	SELECT orderDate AS 'tanggal', 'membayar pesanan dan memesan barang' AS 'riwayat' FROM payments
	JOIN orders ON orderDate = paymentDate
	WHERE orderDate LIKE '2003-04-__' )	
UNION
(	SELECT orderDate , 'memesan barang' FROM orders
	WHERE orderDate LIKE '2003-04-__' AND orderDate NOT IN ( SELECT orderDate FROM payments
																				JOIN orders ON orderDate = paymentDate
																				WHERE orderDate LIKE '2003-04-__') )
UNION
(	SELECT paymentDate , 'membayar pesanan' FROM payments
	WHERE paymentDate LIKE '2003-04-__'  AND paymentDate NOT IN ( SELECT orderDate FROM payments
																					  JOIN orders ON orderDate = paymentDate
																					  WHERE orderDate LIKE '2003-04-__') )
ORDER BY `tanggal`;

-- Nomor 5
USE classicmodels;

(	(	SELECT p.productLine, p.productName AS 'nama produk', SUM(od.quantityOrdered) AS 'total produk yang terjual', 'Laris' AS 'status'
		FROM products AS p
		JOIN orderdetails AS od USING (productCode)
		WHERE p.productLine = 'Classic Cars'
		GROUP BY p.productCode
		ORDER BY SUM(od.quantityOrdered) DESC
		LIMIT 1)
	UNION
	(	SELECT p.productLine, p.productName, SUM(od.quantityOrdered), 'Kurang Laris'
		FROM products AS p
		JOIN orderdetails AS od USING (productCode)
		WHERE p.productLine = 'Classic Cars'
		GROUP BY p.productCode
		ORDER BY SUM(od.quantityOrdered)
		LIMIT 1)	)
UNION
(	(	SELECT p.productLine, p.productName AS 'nama produk', SUM(od.quantityOrdered) AS 'total produk yang terjual', 'Laris' AS 'status'
		FROM products AS p
		JOIN orderdetails AS od USING (productCode)
		WHERE p.productLine = 'Motorcycles'
		GROUP BY p.productCode
		ORDER BY SUM(od.quantityOrdered) DESC
		LIMIT 1)
	UNION
	(	SELECT p.productLine, p.productName, SUM(od.quantityOrdered), 'Kurang Laris'
		FROM products AS p
		JOIN orderdetails AS od USING (productCode)
		WHERE p.productLine = 'Motorcycles'
		GROUP BY p.productCode
		ORDER BY SUM(od.quantityOrdered)
		LIMIT 1)	)
UNION
(	(	SELECT p.productLine, p.productName AS 'nama produk', SUM(od.quantityOrdered) AS 'total produk yang terjual', 'Laris' AS 'status'
		FROM products AS p
		JOIN orderdetails AS od USING (productCode)
		WHERE p.productLine = 'Planes'
		GROUP BY p.productCode
		ORDER BY SUM(od.quantityOrdered) DESC
		LIMIT 1)
	UNION
	(	SELECT p.productLine, p.productName, SUM(od.quantityOrdered), 'Kurang Laris'
		FROM products AS p
		JOIN orderdetails AS od USING (productCode)
		WHERE p.productLine = 'Planes'
		GROUP BY p.productCode
		ORDER BY SUM(od.quantityOrdered)
		LIMIT 1)	)
UNION
(	(	SELECT p.productLine, p.productName AS 'nama produk', SUM(od.quantityOrdered) AS 'total produk yang terjual', 'Laris' AS 'status'
		FROM products AS p
		JOIN orderdetails AS od USING (productCode)
		WHERE p.productLine = 'Ships'
		GROUP BY p.productCode
		ORDER BY SUM(od.quantityOrdered) DESC
		LIMIT 1)
	UNION
	(	SELECT p.productLine, p.productName, SUM(od.quantityOrdered), 'Kurang Laris'
		FROM products AS p
		JOIN orderdetails AS od USING (productCode)
		WHERE p.productLine = 'Ships'
		GROUP BY p.productCode
		ORDER BY SUM(od.quantityOrdered)
		LIMIT 1)	)
UNION
(	(	SELECT p.productLine, p.productName AS 'nama produk', SUM(od.quantityOrdered) AS 'total produk yang terjual', 'Laris' AS 'status'
		FROM products AS p
		JOIN orderdetails AS od USING (productCode)
		WHERE p.productLine = 'Ships'
		GROUP BY p.productCode
		ORDER BY SUM(od.quantityOrdered) DESC
		LIMIT 1)
	UNION
	(	SELECT p.productLine, p.productName, SUM(od.quantityOrdered), 'Kurang Laris'
		FROM products AS p
		JOIN orderdetails AS od USING (productCode)
		WHERE p.productLine = 'Ships'
		GROUP BY p.productCode
		ORDER BY SUM(od.quantityOrdered)
		LIMIT 1)	)
UNION
(	(	SELECT p.productLine, p.productName AS 'nama produk', SUM(od.quantityOrdered) AS 'total produk yang terjual', 'Laris' AS 'status'
		FROM products AS p
		JOIN orderdetails AS od USING (productCode)
		WHERE p.productLine = 'Trains'
		GROUP BY p.productCode
		ORDER BY SUM(od.quantityOrdered) DESC
		LIMIT 1)
	UNION
	(	SELECT p.productLine, p.productName, SUM(od.quantityOrdered), 'Kurang Laris'
		FROM products AS p
		JOIN orderdetails AS od USING (productCode)
		WHERE p.productLine = 'Trains'
		GROUP BY p.productCode
		ORDER BY SUM(od.quantityOrdered)
		LIMIT 1) )
UNION
(	(	SELECT p.productLine, p.productName AS 'nama produk', SUM(od.quantityOrdered) AS 'total produk yang terjual', 'Laris' AS 'status'
		FROM products AS p
		JOIN orderdetails AS od USING (productCode)
		WHERE p.productLine = 'Trucks and Buses'
		GROUP BY p.productCode
		ORDER BY SUM(od.quantityOrdered) DESC
		LIMIT 1)
	UNION
	(	SELECT p.productLine, p.productName, SUM(od.quantityOrdered), 'Kurang Laris'
		FROM products AS p
		JOIN orderdetails AS od USING (productCode)
		WHERE p.productLine = 'Trucks and Buses'
		GROUP BY p.productCode
		ORDER BY SUM(od.quantityOrdered)
		LIMIT 1)	)
UNION
(	(	SELECT p.productLine, p.productName AS 'nama produk', SUM(od.quantityOrdered) AS 'total produk yang terjual', 'Laris' AS 'status'
		FROM products AS p
		JOIN orderdetails AS od USING (productCode)
		WHERE p.productLine = 'Vintage Cars'
		GROUP BY p.productCode
		ORDER BY SUM(od.quantityOrdered) DESC
		LIMIT 1)
	UNION
	(	SELECT p.productLine, p.productName, SUM(od.quantityOrdered), 'Kurang Laris'
		FROM products AS p
		JOIN orderdetails AS od USING (productCode)
		WHERE p.productLine = 'Vintage Cars'
		GROUP BY p.productCode
		ORDER BY SUM(od.quantityOrdered)
		LIMIT 1)	)