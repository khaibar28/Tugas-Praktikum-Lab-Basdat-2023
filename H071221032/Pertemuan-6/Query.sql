USE classicmodels;

#1
SELECT CONCAT(E.firstName, " ", E.lastName) AS "nama employee", group_concat(O.orderNumber) AS "Nomor orderan", COUNT(O.orderNumber) AS "Jumlah pesanan"
FROM employees AS E
JOIN customers AS C
ON E.employeeNumber = C.salesRepEmployeeNumber
JOIN orders AS O
ON C.customerNumber = O.customerNumber
GROUP BY CONCAT(E.firstName, " ", E.lastName)
having COUNT(O.orderNumber) > 10;

#2
SELECT P.productCode, P.productName, P.quantityInStock, min(O.orderDate)
FROM products AS P
JOIN orderdetails AS O1
ON O1.productCode = P.productCode
JOIN orders AS O
ON O1.orderNumber = O.orderNumber
WHERE P.quantityInStock > 5000
GROUP BY P.productCode;

#3
SELECT O.addressLine1 AS 'Alamat', CONCAT(SUBSTRING(O.phone,1,6),'* **') AS 'Nomor Telp',
COUNT(DISTINCT E.employeeNumber) AS 'Jumlah Karyawan', COUNT(DISTINCT C.customerNumber) AS 'Jumlah Pelanggan', 
round(AVG(P.amount), 2) AS 'Rata-rata Penghasilan'
FROM offices as O
JOIN employees as E 
USING(officeCode)
JOIN customers AS C 
ON E.employeeNumber = C.salesRepEmployeeNumber
JOIN payments AS P 
USING(customerNumber)
GROUP BY O.addressLine1
ORDER BY O.phone;

#4
SELECT C.customerName, YEAR(O.orderDate) AS "tahun order", MONTHname(O.orderDate) AS "bulan order",
COUNT(O.orderNumber) AS "jumlah pesanan", P.amount AS "uang total penjualan"
FROM customers AS C
JOIN orders AS O
USING(customerNumber)
JOIN payments as P
USING(customerNumber)
WHERE YEAR(O.orderDate) = 2003
GROUP BY C.customerName, month(O.orderDate);

#soal tambahan
#2
SELECT C.customerName, round(AVG(DATEDIFF(O.shippedDate, O.orderDate)))
FROM customers AS C
JOIN orders AS O
USING(customerNumber)
GROUP BY C.customerNumber
ORDER BY avg(DATEDIFF(O.shippedDate, O.orderDate)) DESC;

#4
SELECT C.customerName, SUM(O1.quantityOrdered)
FROM customers AS C
JOIN orders AS O
USING(customerNumber)
JOIN orderdetails AS O1
USING(orderNumber)
GROUP BY C.customerName
ORDER BY SUM(O1.quantityOrdered) DESC LIMIT 1;