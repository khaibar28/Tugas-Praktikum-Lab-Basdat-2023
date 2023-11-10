SELECT 
	YEAR(orderDate) AS Tahun,
	COUNT(orderNumber) AS Jumlah_Pesanan,
	case
	when COUNT(orderNumber) > 150 then 'Banyak'
	when COUNT(orderNumber) < 75 then 'sedikit'
	ELSE 'sedang'
	END AS Kategori_Pesanan
FROM orders
GROUP BY Tahun 
ORDER BY Jumlah_Pesanan DESC 

SELECT 
	CONCAT(employees.firstName, ' ', employees.lastName) AS 'nama pegawai',
	SUM(payments.amount) AS 'gaji',
case 
when SUM(payments.amount) > (SELECT AVG(total)
									FROM (SELECT SUM(payments.amount) AS 'total'
									FROM customers
									JOIN payments
									USING(customerNumber)
									JOIN employees
									ON employeeNumber = salesRepEmployeeNumber
									GROUP BY employeeNumber) AS a) then 'diatas rata-rata gaji'
ELSE 'dibawah rata-rata gaji'
END AS 'Kategori Gaji'
FROM employees 
JOIN customers
ON employees.employeeNumber = customers.salesRepEmployeeNumber
JOIN payments
USING(customerNumber)
GROUP BY employees.employeeNumber

# NO 3#
SELECT 
	customers.customerName AS 'Nama Pelanggan',
	GROUP_CONCAT(LEFT(products.productName, 4)) AS 'Tahun Pembuatan Produk',
	COUNT(products.productCode) AS 'Jumlah Produk',
	SUM(DATEDIFF(orders.shippedDate, orders.orderDate)) AS 'Total Durasi Pengiriman',
case 
when	MONTH(orders.orderDate) % 2 = 1 AND 
		SUM(DATEDIFF(orders.shippedDate, orders.orderDate)) > (
			SELECT AVG(total)
			FROM (SELECT SUM(DATEDIFF(o2.shippedDate, o2.orderDate)) AS 'total'
				FROM orders o2
				GROUP BY customerNumber) AS a)
				then 'Target 1'
when	MONTH(orders.orderDate) % 2 = 0 AND 
		SUM(DATEDIFF(orders.shippedDate, orders.orderDate)) > (
			SELECT AVG(total)
			FROM (SELECT SUM(DATEDIFF(o2.shippedDate, o2.orderDate)) AS 'total'
				FROM orders o2
				GROUP BY customerNumber) AS a)
				then 'Target 2'
	END AS 'Keterangan'
FROM customers 
JOIN orders
USING(customerNumber)
JOIN orderdetails
USING(orderNumber)
JOIN products
USING(productCode)
WHERE products.productName LIKE '18%'
GROUP BY customers.customerNumber
HAVING `Keterangan` IS NOT NULL 