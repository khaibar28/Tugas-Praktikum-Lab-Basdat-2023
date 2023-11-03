SELECT * FROM products

-- No.1
(SELECT c.customerName, p.productName, p.buyPrice * SUM(od.quantityOrdered) AS modal
FROM customers c
JOIN orders o
USING(customerNumber)
JOIN orderdetails od
USING(orderNumber)
JOIN products p
USING(productCode)
GROUP BY c.customernumber
ORDER BY modal DESC 
LIMIT 3)
UNION 
(SELECT c.customerName, p.productName, p.buyPrice * SUM(od.quantityOrdered) AS modal
FROM customers c
JOIN orders o
USING(customerNumber)
JOIN orderdetails od
USING(orderNumber)
JOIN products p
USING(productCode)
GROUP BY c.customernumber
ORDER BY modal ASC 
LIMIT 3)

-- No.2
SELECT * FROM offices 

SELECT city, COUNT(*) AS total
FROM (
   SELECT offices.city FROM employees
	JOIN offices USING(officeCode)
	WHERE firstName LIKE 'L%'

    UNION ALL

	SELECT c.city
	FROM customers c
	WHERE c.customerName LIKE 'L%'
) AS EmployeeCustomerCities
GROUP BY city
ORDER BY total DESC
LIMIT 1;

-- No.3
SELECT * FROM employees;
SELECT * FROM customers;

SELECT CONCAT(e.firstName, ' ', e.lastName) AS 'Nama Karyawan/Pelanggan', 'Employee' AS status
FROM Employees e
WHERE e.officeCode IN (
	SELECT officeCode
	FROM Employees
	GROUP BY officeCode
	HAVING COUNT(*) = (
    SELECT MIN(numEmployees)
    FROM (
      SELECT officeCode, COUNT(*) AS numEmployees
      FROM Employees
      GROUP BY officeCode
    ) AS apa
  )
)

UNION

SELECT C.customerName AS 'Nama Karyawan/Pelanggan', 'Customer' AS status
FROM Customers C
WHERE C.salesRepEmployeeNumber IN (
	SELECT employeeNumber
	FROM Employees
	WHERE officeCode IN (
    SELECT officeCode
    FROM Employees
    GROUP BY officeCode
    HAVING COUNT(*) = (
      SELECT MIN(numEmployees)
      FROM (
        SELECT officeCode, COUNT(*) AS numEmployees
        FROM Employees
        GROUP BY officeCode
      ) AS apa
    )
  )
)
ORDER BY `Nama Karyawan/Pelanggan`


-- No.4
SELECT * FROM orders

SELECT tanggal, GROUP_CONCAT(riwayat SEPARATOR  ' & ') AS riwayat
FROM (
    SELECT paymentDate as tanggal, 'membayar pesanan' as riwayat
    FROM payments
    WHERE MONTH(paymentDate) = 4 AND YEAR(paymentDate) = 2003

    UNION

    SELECT orderDate as tanggal, 'memesan barang' as riwayat
    FROM orders
    WHERE MONTH(orderDate) = 4 AND YEAR(orderDate) = 2003

     ) as dataCustomers
GROUP BY tanggal
ORDER BY tanggal

-- Soal Tambahan
SELECT * FROM employees

SELECT
	  c.customerNumber AS 'customerNumber/employeeNumber',
     c.customerName AS nama, 'Customer' AS status
FROM customers c
WHERE c.customerName LIKE 'an%' OR c.customerName LIKE 'en%' OR c.customerName LIKE 'in%' OR c.customerName LIKE 'on%' OR c.customerName LIKE 'un%'

UNION ALL 

SELECT
	 e.employeeNumber AS 'customerNumber/employeeNumber',
    CONCAT(e.firstName, ' ', e.lastName) AS nama,'Employee' AS status
FROM employees e
WHERE e.firstName LIKE 'an%' OR e.firstName LIKE 'en%' OR e.firstName LIKE 'in%' OR e.firstName LIKE 'on%' OR e.firstName LIKE 'un%';
