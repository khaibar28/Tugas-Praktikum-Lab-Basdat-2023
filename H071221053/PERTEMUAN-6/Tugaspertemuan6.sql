USE classicmodels;

##NO1
SELECT CONCAT(e.firstname, ' ', e.lastname) 'nama employee' , group_concat(o.ordernumber) 'Nomor orderan' , COUNT(o.ordernumber) 'Jumlah orderan'
FROM employees e
JOIN customers c ON e.employeeNumber = c.salesRepEmployeeNumber
JOIN orders o USING(customerNumber)
GROUP BY e.employeeNumber
HAVING COUNT(o.orderNumber) > 10;

##NO2
SELECT p.productcode, p.productname, p.quantityinstock, o.orderDate
FROM products p 
JOIN  orderdetails od USING(productcode)
JOIN orders o USING(ordernumber)
WHERE quantityInStock > 5000
GROUP BY p.productcode
ORDER BY o.orderDate

##NO3 
SELECT offices.addressLine1 'Alamat', 
		CONCAT(LEFT(offices.phone, 5), '* **') 'No Telp', 
		count(DISTINCT employees.employeeNumber) 'Jumlah Karyawan', 
		count(DISTINCT customers.customerNumber) 'Jumlah Pelanggan',
		FORMAT(avg(payments.amount), 2) 'Rata-Rata Penghasilan'
FROM offices 
JOIN employees USING(officecode)
left JOIN customers ON customers.salesRepEmployeeNumber = employees.employeeNumber
left JOIN payments USING(customernumber)
GROUP BY offices.officecode
ORDER BY offices.phone
 
##NO4
SELECT customers.customerName, 
		YEAR(orders.orderDate) 'tahun order' , 
		MONTHNAME(orders.orderDate) 'bulan order',
		COUNT(orderdetails.orderNumber) 'jumlah pesanan',
		SUM(payments.amount) 'uang total penjualan'
FROM customers
JOIN payments USING(customerNumber)
JOIN orders USING(customernumber)
JOIN orderdetails USING(ordernumber)
WHERE year(orders.orderDate) = 2003
GROUP BY customers.customerName, MONTHNAME(orders.orderDate); 

##soal tambahan 
##3 
SELECT c.customerName, SUM(p.amount), c.creditLimit, (SUM(p.amount)-c.creditLimit) AS selisih
FROM customers AS c
JOIN payments AS p
ON p.customerNumber = c.customerNumber
GROUP BY c.customerNumber
HAVING selisih > 0 ;

##no4
SELECT c.customerName, SUM(od.quantityOrdered) AS "Jumlah yang dibeli"
FROM customers c
JOIN orders o USING (customerNumber)
JOIN orderdetails od USING (orderNumber)
GROUP BY c.customerName
ORDER BY SUM(od.quantityOrdered) DESC
LIMIT 1;







