-- NO.1
SELECT * FROM customers

SELECT customerName, city, country FROM customers WHERE country='USA';

-- NO.2
SELECT * FROM products

SELECT distinct productVendor FROM products;

-- NO.3
SELECT * FROM payments

SELECT * FROM payments WHERE customerNumber = 124 ORDER BY paymentDate DESC;

-- NO.4
SELECT * FROM products

SELECT productName AS 'Nama Produk', buyPrice AS 'Harga Beli', quantityInStock AS 'Jumlah Dalam Stok' from products WHERE quantityInStock >1000 AND quantityInStock <3000 ORDER BY buyPrice ASC LIMIT 5,10

-- tambahan no 3
SELECT * FROM employees

SELECT * FROM employees WHERE reportsTo=1143;

-- tambahan NO 8
SELECT * FROM orderdetails

SELECT * FROM orderdetails WHERE quantityOrdered > 70 ORDER by orderLineNumber ASC;