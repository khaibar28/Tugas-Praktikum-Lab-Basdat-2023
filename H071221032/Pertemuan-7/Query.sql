USE classicmodels;

#1
SELECT distinct O.addressline1, 
		O.addressLine2, 
		O.city, 
		O.country 
FROM employees as E
JOIN customers AS C
ON E.employeeNumber = C.salesRepEmployeeNumber
JOIN offices O
USING(officeCode)
WHERE C.customerNumber IN (
		SELECT customerNumber FROM payments
		GROUP BY customernumber
		HAVING COUNT(*) = 
			(SELECT COUNT(*) FROM payments
			GROUP BY customernumber
			ORDER BY COUNT(*)
			LIMIT 1));

#2
SELECT CONCAT(E.firstName, ' ', E.lastName) AS 'NAMA EMPLOYEE', 
       SUM(P.amount) AS 'PENDAPATAN'
FROM employees E
JOIN customers C
ON E.employeeNumber = C.salesRepEmployeeNumber
JOIN payments P
USING (customerNumber)
GROUP BY E.employeeNumber
HAVING SUM(P.amount) = 
       (SELECT SUM(P.amount) FROM payments P
        JOIN customers C
        USING (customerNumber)
        JOIN employees E
        ON E.employeeNumber = C.salesRepEmployeeNumber
        GROUP BY E.employeeNumber
        ORDER BY SUM(P.amount) DESC
        LIMIT 1)
OR SUM(P.amount) = 
       (SELECT SUM(P.amount) FROM payments P
        JOIN customers C
        USING (customerNumber)
        JOIN employees E
        ON E.employeeNumber = C.salesRepEmployeeNumber
        GROUP BY E.employeeNumber
        ORDER BY SUM(P.amount)
        LIMIT 1);


#3
USE  world;
countrylanguage

SELECT
    C.`Name` AS 'NEGARA',
    (C.Population * CL.Percentage/100) AS 'PENGGUNA BAHASA'
FROM country C
JOIN countrylanguage CL
ON C.`Code` = CL.CountryCode
WHERE CL.`language` = 
    (SELECT countrylanguage.`language`
    FROM countrylanguage
    JOIN country
    ON country.`Code` = countrylanguage.CountryCode
    WHERE country.Continent = 'Asia'
    GROUP BY countrylanguage.`language`
    ORDER BY COUNT(countrylanguage.`language`) DESC
    LIMIT 1)
ORDER BY (C.Population * CL.Percentage) asc;


#4
USE classicmodels;

SELECT C.customerName, 
    SUM(P.amount) AS 'TOTAL PEMBAYARAN', 
    SUM(O1.quantityOrdered) AS 'BANYAK BARANG', 
    GROUP_CONCAT(P1.productName SEPARATOR ' - ') AS 'PRODUK YANG DIBELI'
FROM payments P
JOIN customers C
USING (customerNumber)
JOIN orders O
USING (customerNumber)
JOIN orderdetails O1
USING (orderNumber)
JOIN products P1
USING (productCode)
GROUP BY customerNumber
HAVING SUM(P.amount) > 
    (SELECT AVG(jumlah)
    FROM (SELECT SUM(amount) AS 'jumlah'
        FROM payments
        GROUP BY customerNumber) AS A)
ORDER BY C.customerName;

#soal tambahan
SELECT C.customerName, (SELECT COUNT(O1.productCode)
								FROM orders O
								JOIN orderdetails O1
								USING(orderNumber)
								WHERE O.customerNumber = C.customerNumber) 
							AS jumlah_pembelian
FROM customers C;
