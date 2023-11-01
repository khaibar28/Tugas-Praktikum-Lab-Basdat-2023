USE classicmodels;

-- Nomor 1
SELECT CONCAT(e.firstName, ' ', e.lastName) AS 'nama employee', 
		GROUP_CONCAT(o.orderNumber) AS 'Nomor Orderan', 
		COUNT(o.orderNumber) AS 'Jumlah pesanan'
FROM employees AS e
JOIN customers AS C ON e.employeeNumber = c.salesRepEmployeeNumber
JOIN orders AS o USING (customerNumber)
GROUP BY e.employeeNumber
HAVING COUNT(o.orderNumber) > 10;

-- Nomor 2
SELECT p.productCode, p.productName, p.quantityInStock, o.orderDate
FROM products AS p
JOIN orderdetails AS od USING (productCode)
JOIN orders AS o USING (orderNumber)
WHERE p.quantityInStock > 5000
GROUP BY p.productCode
ORDER BY o.orderDate;

-- Nomor 3
SELECT o.addressLine1 AS 'Alamat',
		CONCAT(LEFT(o.phone, 6), '*****') AS 'Nomor Telp',
		COUNT(DISTINCT e.employeeNumber) AS 'Jumlah Karyawan',
		COUNT(DISTINCT c.customerNumber) AS 'Jumlah Pelanggan',
		FORMAT(AVG(p.amount), 2) AS 'Rata-rata Penghasilan'
FROM offices AS o
LEFT JOIN employees AS e USING (officeCode)
LEFT JOIN customers AS c ON e.employeeNumber = c.salesRepEmployeeNumber
LEFT JOIN payments AS p USING (customerNumber)
GROUP BY o.officeCode;

-- Nomor 4
SELECT c.customerName, 
		YEAR(o.orderDate) AS 'tahun order',
		MONTH(o.orderDate) AS 'bulan order',
		od.quantityOrdered AS 'jumlah pesanan',
		(od.quantityOrdered * od.priceEach) AS 'uang total penjualan'
FROM customers AS c
JOIN orders AS o USING (customerNumber)
JOIN orderdetails AS od USING (orderNumber)
WHERE YEAR(o.orderDate) = 2003
GROUP BY c.customerNumber, YEAR(o.orderDate), MONTH(o.orderDate);

-- Nomor 5
SELECT c.customerName,
		CEIL(AVG(DATEDIFF(o.shippedDate, o.orderDate))) AS 'rata-rata selisih hari'
FROM orders AS o
JOIN customers AS c USING (customerNumber)
GROUP BY c.customerNumber
ORDER BY AVG(DATEDIFF(o.shippedDate, o.orderDate)) DESC;