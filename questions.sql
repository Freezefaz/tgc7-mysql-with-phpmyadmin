-- Base on http://mysqltutorial.org//tryit/

-- Qn 1 1
SELECT * FROM customers where creditLimit > 20000;
-- 2
SELECT * FROM customers where creditLimit > 20000 and country = "USA";
-- 3
SELECT * FROM customers where customerName like "%gift%";
-- 4 bracket optional
SELECT * FROM customers where country = "France" or 
country = "USA" and creditLimit < 20000;
-- 5 Must match the data in the columns and tables with each other
SELECT customerNumber,customerName,salesRepEmployeeNumber,
employees.firstName,employees.lastName FROM customers
JOIN employees ON employees.employeeNumber = customers.salesRepEmployeeNumber


-- Qn 2 1
SELECT * FROM products where productVendor = "Welly Diecast Productions";
-- 2 Don't put space in the %% if not no results
-- REGEXP "[[:<:]]car[[:>:]]" to find exactly car
SELECT * FROM products where productName like "%car%";
-- 3 Between means inclusive >= <=
SELECT * FROM products where buyPrice > 50.00 and buyPrice < 80.00;
-- 4
SELECT * FROM products where productName like "%car%" 
and buyPrice > 50.00 and buyPrice <80.00;
-- 5
SELECT * FROM products where quantityInStock >= 7000 and 
buyPrice <= 50.00;
-- 6
SELECT productLine, productName, productDescription FROM products;


-- Qn 3 1
SELECT * FROM payments where 
year(paymentDate) = "2004" and month(paymentDate) = "06";
-- 2
SELECT sum(amount) FROM payments where 
paymentDate >= "2004-06-01" and paymentDate < "2005-04-01";
-- 3 customer may have purchase multiple times
SELECT distinct contactFirstName, contactLastName
FROM customers join payments on customers.customerNumber =
payments.customerNumber where year(paymentDate) = "2005";
-- 4
SELECT distinct customerName FROM customers join payments
on customers.customerNumber = payments.customerNumber
-- where year(paymentDate) = "2005"; --hard coding
where year(now()) - year(payment.paymentDate) >= 15;
-- 5
SELECT country, sum(amount)FROM customers join payments on 
customers.customerNumber = payments.customerNumber
where amount -- no need put still can work, sum must be in the select
group by country
order by sum(amount) DESC; -- after group by
-- 6 DESC must put sum if not not accurate
SELECT customerName, sum(amount) FROM customers join payments on 
customers.customerNumber = payments.customerNumber
where amount > 20000
group by customerName
order by sum(amount) DESC;
-- 7
SELECT customerName, sum(amount) FROM customers join payments on 
customers.customerNumber = payments.customerNumber
group by customerName
order by sum(amount) DESC
limit 3;
-- 8 Need sum if not it will not give the total
SELECT firstName, lastName, sum(amount),employeeNumber
FROM payments, customers, employees 
where payments.customerNumber = customers.customerNumber
and customers.salesRepEmployeeNumber = employees.employeeNumber
group by employeeNumber
order by sum(amount) DESC
limit 3;
-- 9 Need to group by product key
SELECT products.productCode, productName, sum(quantityOrdered) 
FROM products
join orderdetails
on products.productCode = orderdetails.productCode
group by productCode
order by sum(quantityOrdered) ASC
limit 3;



