-- NOMOR 1
SELECT DISTINCT CONCAT('Jalan ', o.addressLine1," ", o.addressLine2, ' kota ', o.city, ' negara ', o.country) Alamat
FROM offices o
JOIN employees e 
USING (officeCode)
JOIN customers c 
ON e.employeeNumber = c.salesRepEmployeeNumber
WHERE customerNumber IN (SELECT customerNumber
								 FROM payments
								 GROUP BY customerNumber
								 HAVING COUNT(*) = (SELECT COUNT(*)
														  FROM payments
														  GROUP BY customerNumber
														  ORDER BY COUNT(*)
														  LIMIT 1)
);

-- NOMOR 2 
SELECT CONCAT(e.firstName, ' ', e.lastName) AS `Nama Karyawan`, SUM(p.amount) AS Pendapatan
FROM employees e
JOIN customers c 
ON e.employeeNumber = c.salesRepEmployeeNumber
JOIN payments p 
USING (customerNumber)
WHERE e.employeeNumber IN (
		  (SELECT e.employeeNumber 
		   FROM employees e 
			JOIN customers c 
			ON e.employeeNumber = c.salesRepEmployeeNumber 
			JOIN payments p 
			USING (customerNumber) 
			GROUP BY e.employeeNumber 
			ORDER BY SUM(p.amount) 
			DESC LIMIT 1), 
		  (SELECT e.employeeNumber 
		   FROM employees e 
		   JOIN customers c 
		   ON e.employeeNumber = c.salesRepEmployeeNumber 
		   JOIN payments p 
		   USING (customerNumber) 
		   GROUP BY e.employeeNumber 
		   ORDER BY SUM(p.amount) 
		   LIMIT 1)
)
GROUP BY e.employeeNumber;

-- NOMOR 3
USE world;
SELECT c.Name AS Negara, (cl.Percentage * c.Population)/100 'Pengguna bahasa'
FROM country c
JOIN countrylanguage cl
ON c.Code = cl.CountryCode 
WHERE LANGUAGE = (SELECT cl.LANGUAGE 
						FROM countrylanguage cl
						JOIN country c
						ON c.Code = cl.CountryCode 
						WHERE Continent = 'asia'
						GROUP BY LANGUAGE
						ORDER BY COUNT(*) DESC 
						LIMIT 1
);

-- NOMOR 4
USE classicmodels;
SELECT c.customerName,
   SUM(amount) as totalPayment, 
   SUM(od.quantityOrdered) as Total, 
   GROUP_CONCAT(p.productName SEPARATOR ', ') as productsPurchased
FROM customers c
JOIN orders o 
USING (customerNumber)
JOIN orderdetails od 
USING (orderNumber)
JOIN products p 
USING (productCode)
JOIN payments 
USING (customerNumber)
GROUP BY c.customerNumber
HAVING SUM(amount) > (SELECT AVG(TotalPaymentCustomer)
    							FROM (SELECT SUM(amount) TotalPaymentCustomer
    							FROM payments
								GROUP BY customerNumber) totalPurchased);

-- SOAL TAMBAHAN
-- Tampilkan officeCode kantor yang karyawannya melayani customer terbanyak
SELECT offices.officeCode
FROM offices
JOIN employees
USING (officeCode)
WHERE employees.employeeNumber = (SELECT employees.employeeNumber 
											 FROM employees
											 JOIN customers
											 ON employees.employeeNumber = customers.salesRepEmployeeNumber
											 GROUP BY employees.employeeNumber
											 ORDER BY COUNT(customers.customerNumber) DESC 
											 LIMIT 1);
											 
SELECT employees.employeeNumber, COUNT(customers.customerNumber) AS `jumlah melayani`
FROM employees
JOIN customers
ON employees.employeeNumber = customers.salesRepEmployeeNumber
GROUP BY employees.employeeNumber
ORDER BY `jumlah melayani` DESC

											 											 
										
