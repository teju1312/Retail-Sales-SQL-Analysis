-- Database Creation 

create database sales_analysis;
use sales_analysis;

-- Tables Creation

create table customers
(
customer_id int primary key,
name varchar(255) not null,
city varchar(255) not null
);

create table products
(
product_id int primary key,
product_name varchar(255) not null,
category varchar(255) not null,
price decimal(10,2) not null
);

create table orders
(
order_id int primary key,
customer_id int not null,
product_id int not null,
quantity int not null,
order_date date not null,
foreign key(customer_id)references customers(customer_id),
foreign key(product_id)references products(product_id)
);

-- Create index to Speed-up query performance (optional for this Tables)
-- CREATE INDEX idx_customer ON orders(customer_id);
-- CREATE INDEX idx_product ON orders(product_id);
-- CREATE INDEX idx_orderdate ON orders(order_date);



-- Data Insertion
insert into customers values
(1,'Ravi Kumar','Hyderabad'),
(2,'Anjali Rao','Chennai'),
(3,'Arjun Reddy','Bangalore'),
(4,'Sneha Sharma','Hyderabad');

select * from customers;
-- Checking of Null values
DELETE FROM customers WHERE customer_id IS NULL;
SELECT COUNT(*) FROM customers;

insert into products values
(101,'Laptop','Electronics',55000),
(102,'Headphones','Electronics',2000),
(103,'Office Chair','Furniture',7000),
(104,'Smart Phone','Electronics',30000);

select * from products;

insert into orders values
(1001, 1, 101,1,'2024-01-10'),
(1002, 2, 102,2,'2024-01-12'),
(1003, 3, 104,1,'2024-02-05'),
(1004, 1, 103,1,'2024-02-10'),
(1005, 4, 101,1,'2024-03-15');

select * from orders;

-- Analysis Queries

-- 1.Total Revenue 
select sum(quantity * price) as Total_Revenue
from orders o 
join products p on o.product_id = p.product_id;

-- 2.Total Sales per Product
select p.product_name,sum(o.quantity) as Total_sales
from orders o
join products p on o.product_id = p.product_id
group by product_name;

-- 3.Top Customers
select c.name,sum(o.quantity * p.price) as Total_revenue
from orders o
join customers c on o.customer_id = c.customer_id
join products p on o.product_id = p.product_id
group by name
order by Total_revenue desc;

-- 4.Monthly Revenue
select month(o.order_date) as month,sum(o.quantity * p.price) as Total_revenue     -- or date_format(order_date,'%Y-%m')
from orders o
join products p on o.product_id = p.product_id
group by month(order_date)
order by month;




