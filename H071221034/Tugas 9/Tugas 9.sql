-- No.1
SELECT YEAR(orderDate) AS 'Tahun', COUNT(orderNumber) AS 'Jumlah Pesanan',
CASE
WHEN COUNT(orderNumber) >= 150 THEN 'Banyak'
WHEN COUNT(orderNumber) <= 75 THEN 'Sedikit'
ELSE 'Sedang'
END AS 'Kategori Pesanan'
FROM orders
GROUP BY YEAR(orderDate)
ORDER BY YEAR(orderDate);

-- No.2
SELECT CONCAT(employees.firstName, ' ', employees.lastName) AS 'Nama Pegawai', SUM(payments.amount) AS 'Gaji',
CASE
WHEN SUM(payments.amount) > (SELECT AVG(total) 
							FROM (SELECT SUM(amount) AS 'total' 
								FROM customers
	 							JOIN payments 
								USING (customerNumber)
	 							JOIN employees 
								ON employeeNumber = salesRepEmployeeNumber
	 							GROUP BY employeeNumber) AS a) THEN 'Di atas rata-rata gaji'
ELSE 'Di bawah rata-rata gaji' 
END AS 'Kategori Gaji'
FROM employees
JOIN customers 
ON employees.employeeNumber = customers.salesRepEmployeeNumber
JOIN payments 
USING (customerNumber)
GROUP BY employees.employeeNumber
ORDER BY SUM(payments.amount) DESC;

-- No.3
SELECT * FROM products;

SELECT c.customerName 'Nama Pelanggan', GROUP_CONCAT(LEFT(p.productName, 4)) 'Tahun Pembuatan Produk', COUNT(p.productCode) 'Jumlah Produk',SUM(DATEDIFF(o.shippedDate, o.orderDate)) 'Total Durasi Pengiriman',
CASE
WHEN 
   MONTH(o.orderDate) % 2 = 1 AND SUM(DATEDIFF(o.shippedDate, o.orderDate)) > (
    	SELECT AVG(`Total`) 
    	FROM (SELECT SUM(DATEDIFF(o2.shippedDate, o2.orderDate)) 'Total'
    		FROM orders o2
    		GROUP BY customernumber) AS a
	) THEN 'TARGET 1'
WHEN 
   MONTH(o.orderDate) % 2 = 0 AND SUM(DATEDIFF(o.shippedDate, o.orderDate)) > (
    SELECT AVG(`Total`) 
    FROM (SELECT SUM(DATEDIFF(o2.shippedDate, o2.orderDate)) 'Total'
    		FROM orders o2
    		GROUP BY customernumber) AS a
   ) THEN 'TARGET 2'
END 'Keterangan'
FROM customers c
JOIN orders o 
USING (customernumber)
JOIN orderdetails od
USING (ordernumber)
JOIN products p
USING (productcode)
WHERE p.productName LIKE '18%'
GROUP BY c.customernumber
HAVING `Keterangan` IS NOT NULL

UNION

SELECT c.customerName 'Nama Pelanggan', GROUP_CONCAT(LEFT(p.productName, 4)) 'Tahun Pembuatan Produk', COUNT(p.productCode) 'Jumlah Produk', SUM(DATEDIFF(o.shippedDate, o.orderDate)) 'Total Durasi Pengiriman',
CASE
WHEN 
   MONTH(o.orderDate) % 2 = 1 AND COUNT(p.productCode) > 10 * (
       SELECT AVG(product_count)
       FROM (
		 SELECT COUNT(p2.productCode) AS product_count
           FROM products p2
           GROUP BY p2.productCode
		 ) AS counts
	)   
	THEN 'TARGET 3'
WHEN 
   MONTH(o.orderDate) % 2 = 0 AND
   COUNT(p.productCode) > 10 * (
       SELECT AVG(product_count)
       FROM (
		 SELECT COUNT(p2.productCode) AS product_count
           FROM products p2
           GROUP BY p2.productCode
		 ) AS counts
	)   
   THEN 'TARGET 4'
END 'Keterangan'
FROM customers c
JOIN orders o 
USING (customernumber)
JOIN orderdetails od
USING (ordernumber)
JOIN products p
USING (productcode)
WHERE p.productName LIKE '19%'
GROUP BY c.customernumber
HAVING `Keterangan` IS NOT NULL
 	
UNION 

SELECT c.customerName 'Nama Pelanggan', GROUP_CONCAT(LEFT(p.productName, 4)) 'Tahun Pembuatan Produk', COUNT(p.productCode) 'Jumlah Produk', SUM(DATEDIFF(o.shippedDate, o.orderDate)) 'Total Durasi Pengiriman',
CASE
WHEN 
   MONTH(o.orderDate) % 2 = 1 AND COUNT(p.productCode) > 3 * (
       SELECT MIN(product_count)
       FROM (
           SELECT COUNT(p2.productCode) AS product_count
           FROM products p2
           GROUP BY p2.productCode
       ) AS counts
	)
   THEN 'TARGET 5'
WHEN 
   MONTH(o.orderDate) % 2 = 0 AND COUNT(p.productCode) > 3 * (
       SELECT MIN(product_count)
       FROM (
           SELECT COUNT(p2.productCode) AS product_count
           FROM products p2
           GROUP BY p2.productCode
       ) AS counts
	)
   THEN 'TARGET 6'
END 'Keterangan'
FROM customers c
JOIN orders o 
USING (customernumber)
JOIN orderdetails od
USING (ordernumber)
JOIN products p
USING (productcode)
WHERE productName LIKE '20%'
GROUP BY c.customernumber
HAVING `Keterangan` IS NOT NULL
ORDER BY `Keterangan` ASC;