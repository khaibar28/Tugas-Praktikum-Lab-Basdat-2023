-- No.1
(SELECT customers.customerName, products.productName, products.buyPrice*SUM(orderdetails.quantityOrdered) AS "Modal"
FROM customers
JOIN orders
USING (customerNumber)
JOIN orderdetails
USING (orderNumber)
JOIN products
USING (productCode)
GROUP BY customers.customerNumber
ORDER BY products.buyPrice*SUM(orderdetails.quantityOrdered) DESC 
LIMIT 3)
UNION
(SELECT customers.customerName, products.productName, products.buyPrice*SUM(orderdetails.quantityOrdered) AS "Modal"
FROM customers
JOIN orders
USING (customerNumber)
JOIN orderdetails
USING (orderNumber)
JOIN products
USING (productCode)
GROUP BY customers.customerNumber
ORDER BY products.buyPrice*SUM(orderdetails.quantityOrdered)
LIMIT 3);

-- No.2
SELECT city, COUNT(*) AS total
FROM (
   SELECT offices.city
	FROM employees
	JOIN offices
	USING(officeCode)
	WHERE firstName LIKE 'L%'
	UNION ALL
	SELECT customers.city
	FROM customers
	WHERE customers.customerName LIKE 'L%') AS EmployeeCustomerCities
GROUP BY city
ORDER BY total DESC
LIMIT 1;

-- No.3
SELECT CONCAT(employees.firstName, ' ', employees.lastName) AS `Nama Karyawan/Pelanggan`, 'Karyawan' AS `Status`
FROM employees
WHERE employees.officeCode IN (
  SELECT officeCode
  FROM employees
  GROUP BY officeCode
  HAVING COUNT(*) = (
    SELECT MIN(numEmployees)
    FROM (
      SELECT officeCode, COUNT(*) AS numEmployees
      FROM employees
      GROUP BY officeCode) AS OfficeEmployeeCounts
  )
)
UNION
SELECT customers.customerName AS `Nama Karyawan/Pelanggan`, 'Pelanggan' AS `Status`
FROM customers
WHERE customers.salesRepEmployeeNumber IN (
  SELECT employeeNumber
  FROM employees
  WHERE officeCode IN (
    SELECT officeCode
    FROM employees
    GROUP BY officeCode
    HAVING COUNT(*) = (
      SELECT MIN(numEmployees)
      FROM (
        SELECT officeCode, COUNT(*) AS numEmployees
        FROM employees
        GROUP BY officeCode) AS OfficeEmployeeCounts
    )
  )
)
ORDER BY `Nama Karyawan/Pelanggan`;

-- No.4
SELECT tanggal, GROUP_CONCAT(riwayat SEPARATOR ' dan ') AS riwayat
FROM (
    SELECT paymentDate as tanggal, 'membayar pesanan' AS riwayat
    FROM payments
    WHERE MONTH(paymentDate) = 4 AND YEAR(paymentDate) = 2003
    UNION
    SELECT orderDate AS tanggal, 'memesan barang' AS riwayat
    FROM orders
    WHERE MONTH(orderDate) = 4 AND YEAR(orderDate) = 2003) AS dataCustomers
GROUP BY tanggal
ORDER BY tanggal;

-- Soal Tambahan
-- No.2
SELECT customerName, customerNumber
FROM customers
WHERE customerNumber % 2 = 0 AND customerNumber NOT IN(SELECT customerNumber FROM orders)