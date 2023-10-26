USE classicmodels
##no1
SELECT CONCAT("Jalan ", o.addressLine1) , CONCAT("Jalan ", o.addressLine2) AS 'Alamat' , o.city, o.country
FROM offices o
JOIN employees e USING(officecode)
JOIN customers c ON e.employeeNumber = c.salesRepEmployeeNumber
JOIN payments p USING(customernumber)
GROUP BY c.customerNumber
having COUNT(*) = (SELECT COUNT(*) FROM payments GROUP BY customerNumber
ORDER BY COUNT(*)
LIMIT 1);

##no2
SELECT CONCAT(e.firstName, ' ', e.lastName) 'nama employee', sum(p.amount) 'pendapatan'
FROM employees e
JOIN customers c
ON e.employeeNumber = c.salesRepEmployeeNumber
JOIN payments p
USING (customernumber)
WHERE e.employeeNumber IN  ((SELECT employeenumber 
										FROM employees e
										JOIN customers c ON e.employeeNumber = c.salesRepEmployeeNumber
										JOIN payments p USING (customernumber)
										GROUP BY e.employeeNumber
										ORDER BY SUM(p.amount) ASC
										LIMIT 1),
									(SELECT employeenumber 
										FROM employees e
										JOIN customers c ON e.employeeNumber = c.salesRepEmployeeNumber
										JOIN payments p USING (customernumber)
										GROUP BY e.employeeNumber
										ORDER BY SUM(p.amount) DESC 
										LIMIT 1))
GROUP BY CONCAT(e.firstName, ' ', e.lastName); #untuk mengelompokkan hasil berdasarkan gabungan dari nama depan dan nama belakang karyawan

##no3
USE world
SELECT
    c.name 'Negara',
    c.Population*cl.percentage/100 'Pengguna Bahasa' #mengambil populasi negara dari tabel 'country' dan mengalikannya dengan persentase pengguna bahasa dari tabel 'countrylanguage'. Persentase dibagi 100 karena persentase biasanya disimpan sebagai bilangan bulat antara 0 hingga 100. Hasil ini diberi alias 'Pengguna Bahasa'
FROM country c
JOIN countrylanguage cl
ON c.Code = cl.CountryCode
WHERE cl.language = 
(SELECT countrylanguage.language
FROM countrylanguage
JOIN country
ON country.Code = countrylanguage.CountryCode
WHERE country.Continent = 'Asia'
GROUP BY countrylanguage.language
ORDER BY COUNT(countrylanguage.language) DESC #dr tertinggi 
LIMIT 1);

#no4
SELECT c.customerName,
    SUM(p.amount) 'Total pembayaran',
	 SUM(od.quantityOrdered) 'banyak barang',
    GROUP_CONCAT(pr.productName SEPARATOR ', ') 'produk yang dibeli'
FROM customers c
JOIN payments p USING(customernumber)
JOIN orders o USING(customernumber)
JOIN orderdetails od USING(ordernumber)
JOIN products pr USING(productcode)
GROUP BY c.customername
HAVING SUM(p.amount) > ( #membandingkan total pembayaran pelanggan (SUM(p.amount)) dengan rata-rata total pembayaran dari semua pelanggan. 
	SELECT AVG(total)
	FROM (
		SELECT SUM(payments.amount) AS total
		FROM customers
		JOIN payments
		USING (customerNumber)
		GROUP BY customers.customerNumber) AS rata_total);
		
		
#Soal Tambahan 
##no1
#Tampilkan semua produk yang pernah dibeli oleh customer dengan creditLimit tertinggi
SELECT customers.customerName, products.productName 
FROM customers 
JOIN orders USING(customerNumber)
JOIN orderdetails USING(orderNumber)
JOIN products USING(productCode)
WHERE customers.customerName = (
										SELECT customerName 
										FROM customers
										ORDER BY creditLimit DESC 
										LIMIT 1);

##no5
#Tampilkan karyawan yang bekerja di kantor dengan officeCode genap
SELECT DISTINCT officeCode
FROM employees
WHERE officeCode IN (
							SELECT officeCode
							FROM employees
							WHERE officeCode % 2 = 0)