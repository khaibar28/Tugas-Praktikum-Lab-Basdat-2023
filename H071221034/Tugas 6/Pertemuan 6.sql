-- No.1
SELECT CONCAT(e.firstName, " ", e.lastName) AS "Nama Employee", GROUP_CONCAT(o.orderNumber SEPARATOR ", ") AS "Nomor Orderan", COUNT(o.orderNumber) AS "Jumlah Pesanan"
FROM employees e
JOIN customers c
ON c.salesRepEmployeeNumber = e.employeeNumber
JOIN orders o
USING (customerNumber)
GROUP BY e.employeeNumber
HAVING COUNT(o.orderNumber) > 10;

-- No.2
SELECT p.productCode, p.productName, p.quantityInStock, o.orderDate
FROM products p
JOIN orderdetails od
USING (productCode)
JOIN orders o
USING (orderNumber)
GROUP BY p.productCode
HAVING p.quantityInStock > 5000
ORDER BY o.orderDate ASC;

-- No.3
SELECT * FROM offices;
SELECT * FROM employees;

SELECT o.addressLine1 AS "Alamat", REPLACE(o.phone, RIGHT(o.phone, 5), "* ***") AS "Nomor Telp", COUNT(DISTINCT e.employeeNumber) AS "Jumlah Karyawan", COUNT(DISTINCT c.customerName) AS "Jumlah Pelanggan", ROUND(AVG(p.amount), 2) AS "Rata-rata Penghasilan"
FROM offices o
LEFT JOIN employees e
USING (officeCode)
LEFT JOIN customers c
ON c.salesRepEmployeeNumber = e.employeeNumber
LEFT JOIN payments p
USING (customerNumber)
GROUP BY o.officecode
ORDER BY o.phone;

-- No.4
SELECT c.customerName, YEAR(o.orderDate) AS "Tahun Order", MONTH(o.orderDate) AS "Bulan Order", od.quantityOrdered AS "Jumlah Pesanan", SUM(od.quantityOrdered*od.priceEach) AS "Uang Total Penjualan"
FROM customers c
JOIN orders o
USING (customerNumber)
JOIN orderdetails od
USING (orderNumber)
WHERE YEAR(o.orderDate) = 2003
GROUP BY c.customerName, MONTH(o.orderDate);

-- Soal Tambahan
-- 1
SELECT c.customerName, COUNT(py.amount) AS "Banyak Belanja", CONCAT(e.firstName, " ", e.lastName) AS "Nama Employee"
FROM customers c
LEFT JOIN payments py
USING (customerNumber)
LEFT JOIN employees e
ON c.salesRepEmployeeNumber = e.employeeNumber
GROUP BY c.customerName
ORDER BY COUNT(py.amount) DESC 

-- 4
SELECT c.customerName, SUM(od.quantityOrdered) AS "Jumlah Pembelian"
FROM customers c
JOIN orders o
USING (customerNumber)
JOIN orderdetails od
USING (orderNumber)
GROUP BY c.customerName
ORDER BY SUM(od.quantityOrdered) DESC;