# No 1# 
SELECT CONCAT(firstName,' ',LastName)AS `nama employee`, GROUP_CONCAT(orders.orderNumber), COUNT(orders.orderNumber)
FROM employees
LEFT JOIN customers 
ON employees.employeeNumber = customers.salesRepEmployeeNumber
LEFT JOIN orders
USING (customerNumber)
GROUP BY employees.employeeNumber 
HAVING COUNT(orders.orderNumber) > 10;

# No 2#	
SELECT products.productCode, products.productName, products.quantityInStock, MIN(orders.orderDate)
FROM products
JOIN orderdetails
USING (productCode)
JOIN orders
WHERE products.quantityInStock > 5000
GROUP BY products.productCode;

# No 3#
SELECT 
		offices.addressLine1 AS 'Alamat Kantor',
		CONCAT(LEFT(offices.phone, 6),'* **') AS 'No Telepon',
		COUNT(DISTINCT employees.employeeNumber) AS 'Jumlah karyawan',
		COUNT(DISTINCT customers.customerNumber) AS 'Jumlah Pelanggan',
		ROUND(AVG(payments.amount),2) AS 'Rata-rata penghasilan' 
FROM offices
JOIN employees
USING (officeCode)
JOIN customers
ON customers.salesRepEmployeeNumber = employees.employeeNumber
JOIN payments
USING (customerNumber)
GROUP BY offices.addressLine1
ORDER BY offices.phone ASC; 

SELECT 
    customers.customerName AS CustomerName, 
    YEAR(orders.orderDate) AS TahunOrder, 
    MONTH(orders.orderDate) AS BulanOrder, 
    COUNT(orderdetails.orderNumber) AS JumlahPesanan, 
    SUM(orderdetails.priceEach * orderdetails.quantityOrdered) AS TotalPenjualan
FROM customers  
JOIN orders
USING (customerNumber)
JOIN orderdetails
USING(orderNumber)
WHERE YEAR(orders.orderDate) = 2003
GROUP BY customers.customerName, YEAR(orders.orderDate), MONTH(orders.orderDate);

# no 5 soal nomor 1#
SELECT customers.customerName, CONCAT(firstName,'', LastName) AS `Nama Employee` , COUNT(payments.amount)
FROM employees
JOIN customers
ON employees.employeeNumber = customers.salesRepEmployeeNumber
JOIN payments
USING(customerNumber)
GROUP BY customers.customerName;

# No 6 soal nomor 4#
SELECT customers.customerName, SUM(orderdetails.quantityOrdered) AS `Total_quantity`
FROM customers
JOIN orders
USING(customerNumber)
JOIN orderdetails
USING(orderNumber)
GROUP BY customers.customerName 
ORDER BY `Total_quantity` DESC 
LIMIT 1;




