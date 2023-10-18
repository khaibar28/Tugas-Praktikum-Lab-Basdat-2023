-- NO.1
SELECT CONCAT(e.firstName, ' ', e.lastName) AS "Nama Employee", 
		GROUP_CONCAT( o.orderNumber ) AS "Nomor Orderan", 
		COUNT(o.orderNumber) AS "Jumlah Pesanan"
FROM employees e
JOIN customers c
ON e.employeeNumber = c.salesRepEmployeeNumber
JOIN orders o
USING(customerNumber)
GROUP BY e.employeeNumber
HAVING COUNT(o.orderNumber) > 10

-- NO.2
SELECT p.productCode, p.productName, p.quantityInStock, o.orderDate
FROM products p
JOIN orderdetails od
USING(productCode)
JOIN orders o
USING(orderNumber)
WHERE p.quantityInStock > 5000
GROUP BY p.quantityInStock
ORDER BY o.orderDate asc

-- NO.3
SELECT oc.addressLine1 AS 'Alamat',
		CONCAT(SUBSTRING(oc.phone,1,6),'* **') AS 'Nomor Telp', 
		COUNT(DISTINCT e.employeeNumber) AS 'Jumlah Karyawan',
		COUNT(DISTINCT c.customerNumber) AS 'Jumlah Pelanggan',
		ROUND (AVG(py.amount) ,2) AS 'Rata-rata Penghasilan'
FROM offices oc
LEFT JOIN employees e 
USING(officeCode)
LEFT JOIN customers c 
ON e.employeeNumber = c.salesRepEmployeeNumber
LEFT JOIN payments py 
USING(customerNumber)
GROUP BY oc.addressLine1
ORDER BY oc.phone ASC ;

-- NO.4
SELECT c.customerName, YEAR(o.orderDate) AS "Tahun Order",
		MONTH(o.orderDate) AS "Bulan Order",
		COUNT(o.orderNumber) AS "Jumlah Pesanan",
		SUM(od.priceEach * od.quantityOrdered) AS "Uang Total Penjualan"
FROM customers c
JOIN orders o
USING (customerNumber)
JOIN orderdetails od 
USING(orderNumber)
WHERE YEAR(o.orderDate) = 2003
GROUP BY c.customerName, MONTH(o.orderDate)

-- soal tambahan
SELECT upper(p.productname) 'nama produk', 
		COUNT(o.ordernumber) 'jumlah diorder', 
		GROUP_CONCAT(o.orderdate) 'waktu diorder', 
		od.priceeach 'harga jual',
		p.buyprice 'harga beli',
		SUM(od.quantityOrdered) AS 'Total Jumlah Orderan',
		CONCAT((SUM(od.quantityordered * od.priceeach)), "-", SUM(od.quantityordered * p.buyprice), "=", (SUM(od.quantityordered * od.priceeach)) - SUM(od.quantityordered * p.buyprice)) AS "pendapatan - model = keuntungan"
FROM products p
JOIN orderdetails od USING(productcode)
JOIN orders o USING(ordernumber)
WHERE p.productName = '2001 ferrari enzo'
GROUP BY od.priceEach
HAVING SUM(od.quantityordered * od.priceeach) - SUM(od.quantityordered * p.buyprice) > 5000
ORDER BY SUM(od.quantityordered * od.priceeach) - SUM(od.quantityordered * p.buyprice) DESC;
