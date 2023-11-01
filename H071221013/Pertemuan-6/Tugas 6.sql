USE classicmodels;
SELECT * FROM employees;
SELECT * FROM orderdetails;
SELECT * FROM products;

#No1
SELECT CONCAT(firstName, ' ', lastName) 'nama employees',
		 GROUP_CONCAT(orderNumber SEPARATOR ';') 'Nomor Orderan',
		 COUNT(orderNumber) 'Jumlah Pesanan'
FROM employees 
JOIN customers 
ON employees.employeeNumber = customers.salesRepEmployeeNumber
JOIN orders 
USING(customerNumber)
GROUP BY employeeNumber
HAVING COUNT(orderNumber) > 10;

#No2
SELECT p.productCode, p.productName, p.quantityInStock, o.orderDate
FROM products p
JOIN orderdetails od
USING(productCode)
JOIN orders o
USING(orderNumber)
GROUP BY p.productCode
HAVING p.quantityInStock > 5000
ORDER BY o.orderDate ASC;

#No3
SELECT * FROM offices;
SELECT * FROM employees; 
SELECT * FROM customers;
SELECT * FROM payments;

SELECT oc.addressLine1 AS Alamat,
		 CONCAT(LEFT(oc.phone, 6), '* ****') Nomor_Telpon,
		 COUNT(DISTINCT e.employeeNumber) 'Jumlah Karyawan',
		 COUNT(DISTINCT c.customerNumber) 'Jumlah Pelanggan',
		 ROUND(AVG(py.amount), 2) AS 'Rata-Rata Penghasilan'
FROM offices oc
LEFT JOIN employees e
USING(officeCode)
LEFT JOIN customers c
ON e.employeeNumber = c.salesRepEmployeeNumber
LEFT JOIN payments py
USING(customerNumber)
GROUP BY oc.officeCode
ORDER BY Nomor_Telpon;

#No4
SELECT * FROM customers;
SELECT * FROM orders;
SELECT * FROM orderdetails;

SELECT c.customerName,
		YEAR(o.orderDate) 'Tahun Order',
		MONTH(o.orderDate) 'Bulan Order',
		COUNT(o.orderNumber) 'Jumlah Pesanan',
		SUM(od.priceEach * od.quantityOrdered) AS 'Total Penjualan'
FROM customers c
JOIN orders o
USING(customerNumber)
JOIN orderdetails od
USING(orderNumber)
WHERE YEAR(o.orderDate) = 2003
GROUP BY c.customerName, MONTH(o.orderDate);

-- Soal Tambahan
#No.4
SELECT c.customerName,  SUM(od.quantityOrdered) AS Jumlah_Pembelian
FROM customers c
JOIN orders o
USING(customerNumber)
JOIN orderdetails od
USING(orderNumber)
GROUP BY c.customerName
ORDER BY Jumlah_Pembelian DESC;

#No.1
SELECT c.customerName, COUNT(py.amount) 'Banyak Belanja', CONCAT(firstName, ' ', lastName) AS 'Nama Karyawan'
FROM customers c
LEFT JOIN payments py
USING(customerNumber)
LEFT JOIN employees e 
ON e.employeeNumber = c.salesRepEmployeeNumber
GROUP BY c.customerName
ORDER BY COUNT(py.amount) DESC;

