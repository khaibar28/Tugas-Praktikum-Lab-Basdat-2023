-- NOMOR 1
SELECT CONCAT (e.firstName, ' ' ,e.lastName) 'nama employee',
	GROUP_CONCAT(o.orderNumber SEPARATOR ", ") 'Nomor Orderan',
	COUNT(o.orderNumber) 'Jumlah Orderan'
FROM employees e
LEFT JOIN customers c 
ON e.employeeNumber = c.salesRepEmployeeNumber
LEFT JOIN orders o 
USING (customerNumber)
GROUP BY e.employeeNumber
HAVING COUNT(o.orderNumber) > 10;

-- NOMOR 2
SELECT p.productCode , p.productName , p.quantityInStock, o.orderDate 
FROM products p
JOIN orderdetails od 
USING (productCode)
JOIN orders o 
USING (orderNumber)
WHERE p.quantityInStock > 5000
GROUP BY p.productCode, p.productName;

-- NOMOR 3
SELECT o.addressLine1 'Alamat', 
CONCAT(SUBSTRING(o.phone, 1, LENGTH(o.phone) - 6), '* ****') 'Nomor Telp',  
COUNT(DISTINCT e.employeeNumber) 'Jumlah Karyawan', 
COUNT(DISTINCT c.customerNumber) 'Jumlah Pelanggan', 
FORMAT(AVG(amount), 2) 'Rata-rata Penghasilan' 
FROM offices o
JOIN employees e 
USING (officeCode)
LEFT JOIN customers c 
ON  c.salesRepEmployeeNumber = e.employeeNumber
LEFT JOIN payments p 
USING(customerNumber)
GROUP BY o.officecode
ORDER BY o.phone;

-- NOMOR 4
SELECT 
   c.customerName , 
   YEAR(o.orderDate) 'Tahun order', 
   MONTHNAME(o.orderDate) 'Bulan order', 
   COUNT(od.orderNumber) 'Jumlah pesanan', 
   SUM(od.priceEach * od.quantityOrdered) 'uang total pesanan'
FROM customers c
JOIN orders o 
USING (customerNumber)
JOIN orderdetails od
USING (orderNumber)
WHERE YEAR(o.orderDate) = 2003
GROUP BY c.customerName, MONTHNAME(o.orderDate);


-- SOAL TAMBAHAN
-- 2. Hitung rata-rata selisih hari antara tanggal order dan tanggal 
-- pengiriman untuk setiap pelanggan yang dipesan berdasarkan selisih terbesar
SELECT c.customerName, AVG(DATEDIFF(o.shippedDate,  o.orderDate)) AS "Rata-rata selisih hari"
FROM customers AS c
JOIN orders AS o
USING (customerNumber)
GROUP BY customerNumber
ORDER BY AVG(DATEDIFF(o.shippedDate,  o.orderDate)) DESC 

-- 5. Tampilkan informasi jumlah orderan serta keuntungan untuk penjualan 2001 Ferrari Enzo yang keuntungannya lebih besar dari 5000
--  a. Nama produk dalam huruf Kapital
--  b. Jumlah diorder
--  c. Waktu Orderan dipisah koma
--  d. Harga Beli
--  e. Harga Jual
--  f. Total Kuantitas Orderan
--  g. Keuntungan bersih yang diperoleh

SELECT 
   UPPER(p.productName) 'Nama Produk',
   COUNT(o.orderNumber) 'Jumlah di Order',
   GROUP_CONCAT(o.orderDate SEPARATOR ", ") 'Waktu Orderan',
   p.buyPrice 'Harga Beli',
   od.priceEach 'Harga Jual',
   SUM(od.quantityOrdered) 'Total Jumlah Orderan',
   CONCAT ((od.priceEach * SUM(od.quantityOrdered)), ' - ',(p.buyPrice * SUM(od.quantityOrdered)), ' = ', (od.priceEach - p.buyPrice) * SUM(od.quantityOrdered)) 'Keuntungan Bersih'
FROM products p
JOIN orderdetails od 
USING (productCode)
JOIN orders o 
USING (orderNumber)
WHERE p.productName = '2001 Ferrari Enzo' 
GROUP BY od.priceEach
HAVING ((od.priceEach - p.buyPrice) * SUM(od.quantityOrdered)) > 5000
ORDER BY (od.priceEach - p.buyPrice) * SUM(od.quantityOrdered) DESC ;
