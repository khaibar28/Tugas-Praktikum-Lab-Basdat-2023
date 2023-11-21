USE classicmodels;

-- NOMOR 1
SELECT customerName, city, country 
FROM customers 
WHERE country = "USA"
ORDER BY customerName ASC;

-- NOMOR 2
SELECT DISTINCT productVendor FROM products;

-- NOMOR 3
SELECT customerNumber, checkNumber, paymentDate, amount 
FROM payments
WHERE customerNumber = 124 
ORDER BY paymentDate DESC;

-- NOMOR 4
SELECT productName AS "Nama produk", buyprice AS "Harga beli", quantityinstock AS "Jumlah dalam stok"
FROM products WHERE quantityinstock > 1000 AND quantityinstock < 3000
ORDER BY buyprice ASC 
LIMIT 5, 10;

-- NOMOR 5
-- tampilkan 5 orderan terakhir terakhir pada uratan 
-- kapan orderan tersebut dibutuhkan
SELECT * FROM orders
ORDER BY requiredDate DESC LIMIT 5;

-- NOMOR 6
-- Urutkan produk dengan harga eceran menurun. 
-- Ambil produk pada urutan 6 - 15 dan tampilkan kode produk, nama produk,
SELECT MSRP, productCode, productName FROM products
ORDER BY MSRP DESC LIMIT 5, 10
