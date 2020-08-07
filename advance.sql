-- All must be set to date type during creation 
-- to extract date
SELECT * FROM orders where requiredDate = "2003-01-13";
SELECT orderDate, year(orderDate), month(orderDate), day(orderDate) FROM orders;
-- orders in 2003
SELECT * FROM orders where year(orderDate) = "2003";
-- orders in 2003 in June
SELECT * FROM orders where year(orderDate) = "2003" and month(orderDate) = "6";
-- show all orders after 13 Jan
SELECT * FROM orders where orderDate > "2003-01-13";
-- find shipment after orderdates in 3 days
select * from orders where requriedDate = NOW() = 3;


-- JOINING STUFF
-- clauses order not important
select * from employees JOIN offices on
employees.officecode = offices.officecode where country = "USA"
-- join is no.1, where, select, order by, limit
-- DESC -> descending
Order by firstName DESC
-- like top 10 list will be last
Limit 3

-- TO REMOVE DUPLICATE
select distinct lastName from employees;

-- COUNT
select count(*) from employees;

-- Sum TYPE must be int, float 
Select sum(creditLimit) from customers where country = "USA";

-- Min lowest sum, Max highest sum, ave
select min(creditLimit) from customer Where country = "USA";

-- Methods to use group by
-- 1. figure out criteria to group by
-- 2. which table?
-- 3. What do i want to surmarize
-- 4. always select column that you group by

-- to get average by country use group by
select avg(creditLimit), country from customers group by country --4
select avg(creditLimit), country from customers 
where country = "USA" or country = "France" or country = "Canada"  --1 filter out groups not wanted in groups
-- where country in( "USA", "France", "Canada") short form
group by country -2
having avg(creditLimit) > 0 -- 3 filter out results from the chosen ones
order by avg(creditLimit) DESC  --5
limit 3 --6


--  to count by employees
select count(*), officecode from employees group by officecode

-- Using all with join with the sequence of query event
select -- 6
count(*) as "nummber_of_sales_rep", country from offices -- 1
join employees on offices.officecode = employees.officecode -- 2
where employee.jobtitle = 'Sales rep' -- 3
group by country -- 4
having   number_of_sales_rep > 3 --5
order by number_of_sales_rep descending --7
limit 2  -- 8

--  using sub query
select * from customers where country in (select distinct country)

-- DO SUBQUERY FIRST
-- want to find orders in the best money making year
select * from orders where year(orderdate) = 
(select sum(amount), year(paymentDate) FROM group by year(paymentDate)
order by sum(amount) descending
limit 1)

-- find all products that have never been ordered
-- A - B = C, all products - all produts ordered = never ordered before
select productCode, productName from products where productCode
not in (select distinct productCode from orderdetails;)

-- find all customer in usa whose credit limit is higher or equal to lowest credit
-- limit if customers from france
-- credit limit from france is subquery as you need that first to compare
select * from customers where country = "USA" and creditLimit >
(select min(creditLimit) from customers where country = "France");

-- find all the customers who have bought the top 3 products purchased by quantity

select * from customers join orders
    on customers.customerNumber = orders.customerNumber
    join orderdetails
    on orderdetails.orderNumbers = orders.orderNumbers
(select productCode from orderdetails
group by productCode
order by sum(quantityOrdered) desc
limit 3)

-- each product 


