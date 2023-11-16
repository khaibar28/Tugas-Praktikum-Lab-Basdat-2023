USE classicmodels;

-- NOMOR 1
SELECT YEAR(orderDate) AS 'tahun', COUNT(orderNumber) AS 'jumlah pesanan', case
when COUNT(orderNumber) > 150 then 'banyak'
when COUNT(orderNumber) < 75 then 'sedikit'
ELSE 'sedang' 
END AS 'kategori pesanan'
FROM orders
GROUP BY YEAR(orderDate)

-- NOMOR 2
SELECT CONCAT(e.firstName, " " , e.lastName) AS 'nama pegawai', SUM(p.amount) AS 'gaji', case
when SUM(amount) > (SELECT AVG(amountTotal) 
						  FROM (SELECT SUM(amount) amountTotal 
						  FROM customers
						  JOIN payments 
						  USING (customerNumber) 
						  JOIN employees
						  ON salesRepEmployeeNumber = employeeNumber
						  GROUP BY employeeNumber) AS a) then 'di atas rata-rata'
ELSE 'di bawah rata-rata'
END AS 'kategori gaji'
FROM employees AS e 
JOIN customers AS c
ON e.employeeNumber = c.salesRepEmployeeNumber
JOIN payments AS p
USING (customerNumber)
GROUP BY employeeNumber
ORDER BY `gaji` DESC 

--- NOMOR 3
SELECT C.customerName, 
		group_concat(LEFT(P.productName, 4)) AS "tahun pembuatan", 
		count(LEFT(P.productName, 4)) AS "jumlah produk", 
		sum(DATEDIFF(O.shippedDate, O.orderDate)) AS "durasi pengiriman",
		CASE
			WHEN MONTH(O.orderDate) % 2 = 1 AND sum(DATEDIFF(O.shippedDate, O.orderDate)) > (SELECT AVG(Total) FROM (SELECT SUM(DATEDIFF(O2.shippedDate, O2.orderDate)) AS 'Total' FROM orders O2 GROUP BY customernumber) AS a) THEN 'TARGET 1' 
        	WHEN MONTH(O.orderDate) % 2 = 0 AND sum(DATEDIFF(O.shippedDate, O.orderDate)) > (SELECT AVG(Total) FROM (SELECT SUM(DATEDIFF(O2.shippedDate, O2.orderDate)) AS 'Total' FROM orders O2 GROUP BY customernumber) AS a) THEN 'TARGET 2'
        	END AS Keterangan
FROM customers C
JOIN orders O
USING(customerNumber)
JOIN orderdetails O1
USING(orderNumber)
JOIN products P
USING(productCode)
WHERE P.productName LIKE "18%"
GROUP BY C.customerNumber
HAVING Keterangan IS NOT NULL

UNION

SELECT C.customerName, 
		group_concat(LEFT(P.productName, 4)) AS "tahun pembuatan", 
		count(LEFT(P.productName, 4)) AS "jumlah produk", 
		sum(DATEDIFF(O.shippedDate, O.orderDate)) AS "durasi pengiriman",
		CASE
        WHEN MONTH(O.orderDate) % 2 = 1 AND count(LEFT(P.productName, 4)) > 10 * (SELECT AVG(product_count) FROM (SELECT COUNT(P2.productCode) AS product_count FROM products P2 GROUP BY P2.productCode) AS c) then 'TARGET 3'
		  WHEN MONTH(O.orderDate) % 2 = 0 AND count(LEFT(P.productName, 4)) > 10 * (SELECT AVG(product_count) FROM (SELECT COUNT(P2.productCode) AS product_count FROM products P2 GROUP BY P2.productCode) AS c) THEN 'TARGET 4'
        END AS Keterangan
FROM customers C
JOIN orders O
USING(customerNumber)
JOIN orderdetails O1
USING(orderNumber)
JOIN products P
USING(productCode)
WHERE P.productName LIKE "19%"
GROUP BY C.customerNumber
HAVING Keterangan IS NOT NULL

UNION

SELECT C.customerName, 
		group_concat(LEFT(P.productName, 4)) AS "tahun pembuatan", 
		count(LEFT(P.productName, 4)) AS "jumlah produk", 
		sum(DATEDIFF(O.shippedDate, O.orderDate)) AS "durasi pengiriman",
		CASE
		  WHEN MONTH(O.orderDate) % 2 = 1 AND count(LEFT(P.productName, 4)) > 3 * (SELECT MIN(product_count) FROM (SELECT COUNT(P2.productCode) AS product_count FROM products P2 GROUP BY P2.productCode) AS c) THEN 'TARGET 5'
		  WHEN MONTH(O.orderDate) % 2 = 0 AND count(LEFT(P.productName, 4)) > 3 * (SELECT MIN(product_count) FROM (SELECT COUNT(P2.productCode) AS product_count FROM products P2 GROUP BY P2.productCode) AS c) THEN 'TARGET 6'
        END AS Keterangan
FROM customers C
JOIN orders O
USING(customerNumber)
JOIN orderdetails O1
USING(orderNumber)
JOIN products P
USING(productCode)
WHERE P.productName LIKE "20%"
GROUP BY C.customerNumber
HAVING Keterangan IS NOT NULL

ORDER BY Keterangan;