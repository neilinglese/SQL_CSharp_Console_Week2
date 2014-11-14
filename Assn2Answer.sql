/*
Answer all the following questions using as instructed SQL or explaining in words (English)
You can paste all of this precommented text into a new SQLQuery1.sql which you can add to the same project 
that you used for Assignment 1. Rename the default filename, SQLQuery1.sql, to Assn2Answer.sql.
Make sure that you save this file into your project folder and that it is included in your zip upload.
All of the questions use the same database, SalesOrdersExamples.mdf, as used for the first assignment.
*/
-- 1. Explain how the Employees table is related to the Orders Table (English)

--both the employees and orders tables contain the field for EmployeeID, thus could be joined using the EmployeeID field
select * from Employees inner join Orders on Employees.EmployeeID = Orders.EmployeeID

-- 2. Display all of the order information and the employee first and last names 
-- associated with Employees who are in Texas (TX).
-- Order the output by OrderDate (SQL)

select Orders.*, Employees.EmpFirstName,Employees.EmpLastName 
from Orders inner join Employees on Orders.EmployeeID = Employees.EmployeeID 
where Employees.EmpState = 'TX' order by OrderDate asc

-- 3. Explain how the Customers table is related to the Orders Table (English)

-- both the Customers and Order tables contain a field for CustomerID, thus could be joined by using the CustomerID field
select * from Orders inner join Customers on Orders.CustomerID = Customers.CustomerID

-- 4. Display all of the order information and the customer first and last names, 
-- and customer zip code
-- associated with Customers who live in California (CA)
-- Order the output by CustZipCode and then by OrderDate (SQL)

select Orders.*, Customers.CustFirstName, Customers.CustLastName, Customers.CustZipCode 
from Orders inner join Customers on Orders.CustomerID = Customers.CustomerID
where CustState = 'CA' order by CustZipCode, OrderDate asc

-- 5. We want to display the Order Information, the Customer Name and Employee Name 
-- information. Explain the three tables are related. (English)

--Using Orders, Employees, and Customers tables
--Orders table contains fields for EmployeeID and CustomerID, therefore the tables could be joined by linking Orders EmployeeID field to Employees EmployeeID field, and Orders CustomerID
--field to Customers CustomerID field
select * from Orders inner join Employees on Orders.EmployeeID = Employees.EmployeeID inner join Customers on Orders.CustomerID = Customers.CustomerID

-- 6. Display all of the order information, the customer first and last names, 
-- and the employee first and last name 
-- for orders where the Customers lives in California (CA)
-- and the employee is Kathryn Patterson (EmployeeID 707)
-- Order this by ShipDate (SQL)

select Orders.*, Customers.CustFirstName, Customers.CustLastName, Employees.EmpFirstName, Employees.EmpLastName
from Orders inner join Customers on Orders.CustomerID = Customers.CustomerID inner join Employees on Orders.EmployeeID = Employees.EmployeeID
where Customers.CustState = 'CA' and Employees.EmployeeID = 707
order by ShipDate asc

-- 6. Pick any order number and show the orderNumber, Order and Ship Dates, 
-- the Product Name, the retail cost of Product as well as 
-- the total purchase of each order details (QuotedPrice * QuantityOrdered) in this order.  
-- You will need to relate the Order table to the Order_Details table
-- and Order_Details will relate to Products
-- Order the output by OrderDate
-- In this example I am limiting the output to those of OrderNumber 1 (OrderNumber = 1)
-- Limiting the output to a single order makes it easier to
-- better understand the output of the query. (SQL)



select Orders.OrderNumber, Orders.OrderDate, Orders.ShipDate, Products.ProductName, Products.RetailPrice, (Order_Details.QuantityOrdered*Order_Details.QuotedPrice) as 'total purchase'
from Orders inner join Order_Details on Order_Details.OrderNumber = Orders.OrderNumber inner join Products on Order_Details.ProductNumber = Products.ProductNumber
where Orders.OrderNumber = 1
order by Orders.OrderDate



-- 7. Modify the query from problem and order it by the total purchase,
-- QuotedPrice * QuantityOrdered from highest to lowest
-- You should only have to modify the order by line to solve this problem (SQL)

select Orders.OrderNumber, Orders.OrderDate, Orders.ShipDate, Products.ProductName, Products.RetailPrice, (Order_Details.QuotedPrice*Order_Details.QuantityOrdered) as 'total purchase'
from Orders inner join Order_Details on Order_Details.OrderNumber = Orders.OrderNumber inner join Products on Order_Details.ProductNumber = Products.ProductNumber
where Orders.OrderNumber = 1
order by [total purchase] desc

-- 8. Find all of the order details where there is a difference between the
-- quoted price and the retail price. In addition to all the fields used in 
-- the previous section also show the difference between the quoted and retail prices
-- (quotedPrice - retailPrice)
-- Essential some of the order_detail records are giving the customer a discount.
-- Order this by the greatest difference to least (SQL)

select Orders.OrderNumber, Orders.OrderDate, Orders.ShipDate, Products.ProductName, Products.RetailPrice, (Order_Details.QuotedPrice*Order_Details.QuantityOrdered) as 'total purchase', 
(Order_Details.QuotedPrice - Products.RetailPrice) as 'difference in price'
from Orders inner join Order_Details on Order_Details.OrderNumber = Orders.OrderNumber inner join Products on Order_Details.ProductNumber = Products.ProductNumber
where Order_Details.QuotedPrice not like Products.RetailPrice
order by [difference in price] asc


-- 9.If you succeeded with the above query you would see that the ProductName, the difference 
-- between the Quoted and Real Price do not change.
-- Remove the fields that do change (orderNumber, orderDate, ShipDate)
-- and then use the distinct keyword
-- select distint <fields> so that you can see only one line per product (SQL)

select distinct Products.ProductName, Products.RetailPrice, (Order_Details.QuotedPrice*Order_Details.QuotedPrice) as 'total purchase', 
(Order_Details.QuotedPrice - Products.RetailPrice) as 'difference in price'
from Orders inner join Order_Details on Order_Details.OrderNumber = Orders.OrderNumber inner join Products on Order_Details.ProductNumber = Products.ProductNumber
where Order_Details.QuotedPrice not like Products.RetailPrice
order by [difference in price] asc


-- 10. If you included the Orders table in the above query (9) try then to 
-- remove that table and see if the query produces the same results.
-- Explain why removing the orders table has no affect upon the output. (English)

-- we removed all the fields used in the orders table and since the ProductNumber from Products table is joined to ProductNumber from Orders_Details table we do not need
--the orders table

select distinct Products.ProductName, Products.RetailPrice, (Order_Details.QuotedPrice*Order_Details.QuotedPrice) as 'total purchase', 
(Order_Details.QuotedPrice - Products.RetailPrice) as 'difference in price'
from Products inner join Order_Details on Order_Details.ProductNumber = Products.ProductNumber
where Order_Details.QuotedPrice not like Products.RetailPrice
order by [difference in price] asc


-- EXTRA CREDIT: 
-- Find all the unique (ie distinct) product names purchased by
-- the customer Andrew Cencini (customer id = 1009)

select distinct ProductName from Products inner join Order_Details on Products.ProductNumber = Order_Details.ProductNumber 
inner join Orders on Order_Details.OrderNumber =Orders.OrderNumber 
where Orders.CustomerID = 1009

