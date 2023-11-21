USE classicmodels;                                        
                                                          
-- No.1                                                   
SELECT customerName, city, country FROM customers WHERE country="USA";
                                                          
-- No.2                                                   
SELECT DISTINCT productVendor FROM products;              
                                                          
-- No.3                                                   
SELECT customerNumber, checkNumber, paymentDate, amount FROM payments WHERE customerNumber = 124 ORDER BY paymentDate DESC;
                                                          
-- No.4                                                   
SELECT productName AS "Nama produk", buyPrice AS "Harga beli", quantityInStock AS "Jumlah dalam stok" FROM products WHERE quantityInStock >= 1000 AND quantityInStock <=3000 ORDER BY buyPrice ASC LIMIT 5, 10;
                                                          
-- Soal Tambahan No.3                                     
DESCRIBE employees;                                       
SELECT * FROM employees WHERE reportsTo = 1143;
                                                          
-- Soal Tambahan No.5 
DESCRIBE payments;                                  
SELECT amount FROM payments ORDER BY amount DESC LIMIT 10;