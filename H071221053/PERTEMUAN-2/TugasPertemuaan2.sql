USE classicmodels;

##NO 1 
SELECT 
		customername,
		city,
		country 
FROM customers
WHERE country = 'USA'


## NO 2 
SELECT DISTINCT productVendor 
FROM products;

##NO 3 

SELECT * 
FROM payments 
WHERE customerNumber = '124' 
ORDER BY paymentDate DESC;

##NO 4 
SELECT 
		productName AS 'Nama produk' , 
		buyPrice AS 'Harga beli', 
		quantityInStock AS 'Jumlah dalam stok'		
FROM products
WHERE  quantityInStock between 1000 and 3000
ORDER BY buyPrice ASC 
LIMIT 5,10;

##no 5 soal tambahan 
##NO6
SELECT 
		productCode,
		productName,
		MSRP
FROM products
ORDER BY MSRP DESC  
LIMIT 5,10;


##NO7
SELECT *
FROM customers
WHERE 
		country != 'USA' and creditLimit <0
ORDER BY customerName ASC 
LIMIT 9,10;



		
		

