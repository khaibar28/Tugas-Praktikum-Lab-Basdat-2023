
USE classicmodels;
#1

(SELECT C.customerName, P.productName, (O1.quantityOrdered * O1.priceEach) AS 'modal'
FROM customers AS C
JOIN orders AS O USING (customerNumber)
JOIN orderdetails AS O1 USING (orderNumber)
JOIN products AS P USING (productCode)
ORDER BY (O1.quantityOrdered * O1.priceEach) DESC
LIMIT 3)
UNION
(SELECT C.customerName, P.productName, (O1.quantityOrdered * O1.priceEach) AS 'modal'
FROM customers AS C
JOIN orders AS O USING (customerNumber)
JOIN orderdetails AS O1 USING (orderNumber)
JOIN products AS P USING (productCode)
ORDER BY (O1.quantityOrdered * O1.priceEach) ASC
LIMIT 3);
	
#2
SELECT city, COUNT(*) AS total
FROM ((SELECT city, E.firstName AS name
    	FROM offices O
    	JOIN employees E
    	USING (officeCode)
    	WHERE firstname LIKE 'L%')
		UNION
		(SELECT city, customerName
		FROM customers
		WHERE customerName LIKE 'L%')) AS kota
GROUP BY city
ORDER BY total DESC
LIMIT 1;

#3
USE classicmodels;

(SELECT C.customerName AS 'Nama Karyawan/Pelanggan', 'Pelanggan' AS 'status'
FROM customers AS C
JOIN employees AS E ON C.salesRepEmployeeNumber = e.employeeNumber
WHERE e.officeCode IN ( SELECT officeCode FROM employees
GROUP BY officeCode
HAVING COUNT(employeeNumber) = (SELECT COUNT(employeeNumber) FROM employees
									 		GROUP BY (officeCode) 
									 		ORDER BY COUNT(employeeNumber) 
											LIMIT 1)))
UNION
(SELECT CONCAT(firstName, ' ', lastName), 'Karyawan'
FROM employees AS E
WHERE e.officeCode IN ( SELECT officeCode FROM employees
GROUP BY officeCode
HAVING COUNT(employeeNumber) = (SELECT COUNT(employeeNumber) FROM employees
									 		GROUP BY (officeCode) 
									 		ORDER BY COUNT(employeeNumber) 
											LIMIT 1	)))
ORDER BY `Nama Karyawan/Pelanggan`;

#4
USE classicmodels;

(SELECT orderDate AS 'tanggal', 'membayar pesanan dan memesan barang' AS 'riwayat' FROM payments
JOIN orders ON orderDate = paymentDate
WHERE orderDate LIKE '2003-04-__' )	
UNION
(SELECT orderDate , 'memesan barang' FROM orders
WHERE orderDate LIKE '2003-04-__' AND orderDate NOT IN (SELECT orderDate FROM payments
																			JOIN orders ON orderDate = paymentDate
																			WHERE orderDate LIKE '2003-04-__'))
UNION
(SELECT paymentDate , 'membayar pesanan' FROM payments
WHERE paymentDate LIKE '2003-04-__'  AND paymentDate NOT IN (SELECT orderDate FROM payments
																					JOIN orders ON orderDate = paymentDate
																					WHERE orderDate LIKE '2003-04-__'))
ORDER BY `tanggal`;


#soal tambahan
SELECT customerNumber AS "customer/employee Number", customerName, "Customer" AS 'Status' FROM customers
WHERE LEFT(customerName, 1) IN ('a', 'i', 'u', 'e', 'o') AND left(customerName, 2) LIKE "_n"
UNION
(SELECT employeeNumber, firstName, "Employee" FROM employees
WHERE LEFT(firstName, 1) IN ('a', 'i', 'u', 'e', 'o') AND left(firstName, 2) LIKE "_n");
