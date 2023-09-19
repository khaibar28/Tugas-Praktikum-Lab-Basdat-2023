USE classicmodels;

-- No.1 
SELECT * FROM customers;
SELECT customername, city, country
FROM customers
WHERE country = 'USA';

-- No.2
SELECT * FROM products;
SELECT DISTINCT productvendor
FROM products;

-- No.3
SELECT * FROM payments;
SELECT customernumber, checknumber, paymentdate, amount
FROM payments
WHERE customernumber = 124
ORDER BY paymentdate DESC;

-- No.4
SELECT * FROM products;
SELECT productname, buyprice, quantityinstock
FROM products
WHERE quantityinstock >1000 AND quantityinstock <=3000
ORDER BY buyprice
LIMIT 5, 10;


-- soal tambahan
-- No.8
SELECT * FROM orderdetails;S
SELECT ordernumber, productcode, quantityordered, priceeach, orderlinenumber
FROM orderdetails
WHERE quantityordered >70
ORDER BY orderlinenumber 

-- No 2
SELECT * FROM products;
SELECT productcode AS 'Kode Produk', productname AS'Nama Produk', quantityinstock AS 'Sisa Stok'
FROM products
ORDER BY quantityinstock ASC   
LIMIT 10;
