#1
SELECT productName, QuantityPerUnit FROM products
#2
SELECT productID, ProductName FROM products WHERE discontinued = FALSE ORDER BY ProductName # en booleen FALSE est similaire a 0 et TRUE est similaire à 1
#3
SELECT productID, ProductName FROM products WHERE discontinued = TRUE ORDER BY ProductName
#4
SELECT ProductName, UnitPrice FROM products WHERE UnitPrice=(SELECT max(UnitPrice) FROM products) OR UnitPrice =(SELECT min(UnitPrice)FROM products) ORDER BY UnitPrice DESC
#OU#
SELECT max(UnitPrice) as 'MAX', min(UnitPrice) as 'MIN' FROM products # alias permet de renommer temporairement une colonne ou une table dans une requête.
#5
SELECT ProductID, ProductName, UnitPrice FROM products WHERE UnitPrice < '20' ORDER BY UnitPrice ASC
#6
SELECT ProductID, ProductName, UnitPrice FROM products WHERE UnitPrice BETWEEN '15' AND '25' ORDER BY UnitPrice ASC
#7
SELECT ProductName, UnitPrice FROM products WHERE UnitPrice > (SELECT avg(UnitPrice) FROM products) ORDER BY UnitPrice ASC
#8
SELECT ProductName, UnitPrice FROM products ORDER BY UnitPrice DESC LIMIT 10
#9
SELECT DISTINCT (select count(discontinued) FROM products WHERE discontinued = FALSE) as 'produit en cours', (select count(discontinued) FROM products WHERE discontinued = TRUE) as 'produit abandonnés' FROM products
#OU#
SELECT discontinued, count('discontinued') FROM products GROUP BY discontinued
#10
SELECT ProductName, UnitsOnOrder, UnitsInStock FROM products WHERE UnitsInStock < UnitsOnOrder ORDER BY UnitsInStock ASC