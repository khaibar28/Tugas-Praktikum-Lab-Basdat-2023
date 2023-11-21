# no 1#
SELECT customerName, city,country FROM customers where country = "USA"

#no 2#
SELECT DISTINCT productVendor FROM products 

# no 3#
SELECT customerNumber, checkNumber, paymentDate, amount FROM payments WHERE customerNumber = 124 ORDER BY paymentDate DESC 

#no 4#
SELECT productname AS 'Nama Produk', buyprice AS 'Harga beli', quantityin	stock AS 'Jumlah dalam stok'FROM products WHERE quantityinstock > 1000 AND quantityinstock < 3000 ORDER BY buyprice ASC LIMIT 5, 10

#no 5 soal no 6#
SELECT productCode, productName, MSRP FROM products order by MSRP DESC LIMIT 5, 10

#no 6 soal no 9#
SELECT * FROM orders ORDER BY requiredDate DESC LIMIT 1, 1