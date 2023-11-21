USE classicmodels;

#1
SELECT * FROM customers WHERE country = 'USA';

#2
SELECT DISTINCT productVendor FROM products;

#3
SELECT * FROM payments WHERE customerNumber = 124 ORDER BY paymentDate DESC;

#4
SELECT productName AS 'Nama produk', buyPrice AS 'Harga beli', quantityInStock AS 'Jumlah dalam stok' 
FROM products
WHERE quantityInStock > 1000 AND quantityInStock < 3000
ORDER BY buyPrice ASC LIMIT 5,10;