--product_id	product_name	category	price


CREATE TABLE product (
    product_id   VARCHAR2(10) PRIMARY KEY,
    product_name VARCHAR2(20) NOT NULL,
    category     VARCHAR(15) NOT NULL,
    price        NUMBER(10, 3) NOT NULL
);
alter table product
MODIFY product_id varchar2(20);
--select * from product desc;
desc product;
SELECT
    *
FROM
    product;

--order_id	customer_id	product_id	order_date	quantity	payment_method

CREATE TABLE orders (
    order_id       VARCHAR2(20) PRIMARY KEY,
    customer_id    VARCHAR2(20),
    product_id     VARCHAR2(20),
    order_date     DATE,
    quantity       NUMBER(5, 2),
    payment_method VARCHAR2(10)
);

SELECT
    *
FROM
    orders;

--customer_id	gender	age	city	signup_date	loyalty_member
COMMIT;

CREATE TABLE customers (
    customer_id    VARCHAR2(10) PRIMARY KEY,
    gender         VARCHAR2(10) NOT NULL,
    city           VARCHAR2(20) NOT NULL,
    age            NUMBER(3) NOT NULL,
    signup_date    DATE NOT NULL,
    loyalty_member VARCHAR2(9) NOT NULL
);


--Customers 
--01. Show all customers
SELECT *
FROM customers;
--02. show only customer_id and city
SELECT
    customer_id,
    city
FROM
    customers;
    
    
--03. Find customers from specific city
SELECT CUSTOMER_ID, gender 
from customers 
where city='London';


--04. count no of customers
select count(customer_id)
from customers;


--05. find average age
select AVG(age) 
from customers;


--06. find customers who are royalty_members
select customer_id, loyalty_member 
from customers 
where lower(loyalty_member)='yes'; 


--Products
--07. show all products
select *
from product;

--08. find products with price grater than value
select product_name from product where price>100.76;

select product_name from product where price>70;

select product_name from product where price>60;

select product_name from product where price>50;

select product_name from product where price>40;

select product_name from product where price>30;

select product_name from product where price>20;

--09. sort products by price(high to low)
select * from product order by price desc;
-- sort products by price(low to high)low
select * from product order by price asc;


--10. count total products
select  count(product_name) from product;


--orders
--11. show all orders
select * from orders;

--12. find orders with quantity more than 2
select order_id , product_id
from orders 
where quantity>2;

--13. count total orders 
select COUNT(order_id) 
from orders;

--14. Show unique pyment method
select payment_method, count(*)
from orders 
GROUP BY  payment_method ;



--15. number of customers per city
select count(customer_id), city
from customers
group by city;

--16. numbers of customers by gender
select count(Customer_id) , gender
from customers
group by gender;

--17.  average age per city
select city, avg(age)
from customers 
group by city;

--18. count product by category
select  category , COUNT(category)
from product
group by category;

--19.average price per category
select category ,AVG(price) 
from product
GROUP by category;

--20. total quantity ordered according to no of quantity 
select quantity ,sum(quantity)
from orders
group by quantity;


--21. total quantity ordered
select sum(quantity)
from orders;


--22. oeders count per payment method
select  payment_method ,count(payment_method)
from orders 
group by payment_method;


--23. show customer details with their orders
SELECT
 c.customer_id ,
 c.gender ,
 c.city,         
 c.age,            
 c.signup_date,    
 c.loyalty_member
 from customers c
 JOIN orders o
 ON c.customer_id=o.customer_id
 order by age;


--24.show customer_id,product_id, quantity together
select 
o.product_id,
p.product_name,
o.quantity
from orders o
join product p
on o.product_id=p.product_id
order by quantity;


--25. show customer city with ordered products
select 
c.customer_id,
c.city,
p.product_name
from customers c
 join orders o
 on c.customer_id=o.customer_id
 join product p
 ON p.product_id=o.product_id
 order by c.customer_id;
 
 
-- 26. show customer city with ordered products
select 
c.customer_id,
c.city,
p.product_name
from customers c
join orders o
on c.customer_id=o.customer_id
join product p
on p.product_id=o.product_id
order by  c.customer_id;


--27. count number of orders per customer
select 
c.customer_id, 
sum(o.quantity) 
from orders o
join customers c
on c.customer_id=o.customer_id
group by c.customer_id
order by c.customer_id;

--28. count number of orders per product
select 
p.product_id, 
sum(o.quantity) 
from orders o
join product p
on p.product_id=o.product_id
group by p.product_id
order by p.product_id;


--Analysis
--29. Total sales amount
select 
p.product_id,
p.product_name,
sum((o.quantity)*(p.price)) as total 
from orders o
join product p
on p.product_id=o.product_id
group by p.product_name, p.product_id
order by  p.product_id, p.product_name
--group by p.product_id
--order by p.product_id
;

--30. Total revenue per product
select 
p.product_id,
p.product_name,
sum((o.quantity)*(p.price)) as Revenue
from orders o
join product p
on p.product_id=o.product_id
group by p.product_id,p.product_name
order by p.product_id ;




--Show unique pyment_method
--select  max(payment_method)
--from orders 
--order BY  payment_method ;


--31. most used payment method
select
payment_method,
count(*) as total_used
from orders 
group by payment_method 
 order by total_used desc
fetch first 1 rows only ;


--32.Top 5 most sold products
select 
p.product_name,
o.quantity, 
sum(o.quantity) 
from orders o
join product p
on p.product_id=o.product_id
group by o.quantity,p.product_name
order by o.quantity asc
fetch first 5 row only;

--given by gpt
--32.Top 5 most sold products
select 
p.product_id,
p.product_name,
sum(o.quantity) as total_quantity_sold 
from orders o
join product p
on p.product_id=o.product_id
group by p.product_id, p.product_name
order by total_quantity_sold  desc 
fetch first 5 row only;

--33.city with highest number of orders
select 
c.city,
count(o.order_id) as highest_numbr_of_orders
from orders o
join customers c
on c.customer_id=o.customer_id
group by c.city
order by highest_numbr_of_orders desc
fetch first 5 rows only;

--34. top 5 customers who ordered most
select 
c.customer_id,
count(o.order_id) AS total_orders
from customers c
JOIN orders o
on c.customer_id=o.customer_id
group by c.customer_id
order by total_orders desc
fetch first 5 rows only;

--35.Total revenue by payment method
select 
o.payment_method ,
sum(o.quantity*p.price) AS Total_Revenue
from product p
join orders o
on p.product_id=o.product_id
group by o.payment_method
order by Total_Revenue ASC;

--36. Average order quantity per customer
select 
AVG(o.quantity) as Avg_quantity,
c.customer_id
from orders o
join customers c
on c.customer_id=o.customer_id
group by c.customer_id
order by Avg_quantity desc;

--37.Find customers who never ordered
select
--o.quantity,
c.customer_id ,
o.order_id
from customers c
left join orders o
on c.customer_id=o.customer_id
where o.order_id is NULL;


--38. Find products which is never ordered
SELECT
p.product_id,
p.product_name,
o.quantity
--o.order_id
from product p
left join orders o
on p.product_id=o.product_id
where o.quantity =0 
fetch first 5 rows only;

--find caegory generating highest revenue
select
p.category,
sum(p.price*o.quantity) as total_revenue
from product p
join orders o
on p.product_id=o.product_id
group by p.category
order by total_revenue ASC;


select category from product;


--find customers whose total spending average spendindg
select 
o.customer_id,
sum(p.price*o.quantity) as total_ 
from product p
join (
select  avg(p.price*o.quantity) as Avg_revenue
from product p
group by c.customer_id
order by total_revenue )
join customers c
on c.customer_id=o.customer_id; 


