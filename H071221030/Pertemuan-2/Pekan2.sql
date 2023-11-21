USE classicmodels
-- Nomor 1
SELECT customerName, city, country FROM customers WHERE country = "USA"

-- Nomor 2
SELECT DISTINCT productVendor FROM products

-- Nomor 3
SELECT customerNumber, checkNumber, paymentDate, amount FROM payments WHERE customerNumber = "124" ORDER BY paymentDate DESC

-- Nomor 4
SELECT productName AS "Nama produk", buyPrice AS "Harga beli", quantityInStock AS "Jumlah dalam stok" FROM products WHERE quantityInStock >= 1000 and quantityInStock <= 3000 ORDER BY buyPrice LIMIT 5, 10

-- Soal Tambahan
SELECT * FROM orders ORDER BY requiredDate DESC LIMIT 1, 1