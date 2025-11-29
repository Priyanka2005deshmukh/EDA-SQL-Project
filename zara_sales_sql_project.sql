show databases;
create database zara_sales_eda;
use zara_sales_db;

show tables;
desc zara_sales_eda;
select * from zara_sales_eda;

select * from zara_sales_eda order by `product id` limit  10 ;
select count(`product id`) from zara_sales_eda;
-- Count the number of unique brands and unique product categories--
select distinct(brand) from zara_sales_eda;
select distinct(`product category`) from zara_sales_eda ;

-- 4.Identify columns with missing (NULL) values--
select `product id` from zara_sales_eda where `product id` is null;
select `product position` from zara_sales_eda where `product position` is null;
select `promotion` from zara_sales_eda where `promotion` is null;
select `product category` from zara_sales_eda where `product category` is null;
select `seasonal` from zara_sales_eda where `seasonal` is null;
select `sales volume` from zara_sales_eda where `sales volume` is null;
select `brand` from zara_sales_eda where `brand` is null;
select `url` from zara_sales_eda where `url` is null;
select `product id` from zara_sales_eda where `product id` is null;
select `name` from zara_sales_eda where `name` is null;
select `description` from zara_sales_eda where `description` is null;
select `price` from zara_sales_eda where `price` is null;
select `currency` from zara_sales_eda where `currency` is null;
select `terms` from zara_sales_eda where `terms` is null;
select `section` from zara_sales_eda where `section` is null;
select `season` from zara_sales_eda where `season` is null;
select `material` from zara_sales_eda where `material` is null;
select `origin` from zara_sales_eda where `origin` is null;

-- 5.Find the average, minimum, and maximum price of all products.--

select name, avg(price) from zara_sales_eda group by name;
select name, min(price) from zara_sales_eda group by name;
select name, max(price) from zara_sales_eda group by name;

-- 6.Find the average sales volume per brand and list them in descending order--

SELECT 
    brand, AVG(`sales volume`) AS 'avg_sales_volume'
FROM
    zara_sales_eda
GROUP BY brand
ORDER BY avg_sales_volume desc;

-- 7.7. Calculate total sales volume by product category.--

select `product category`,sum(`sales volume`) from zara_sales_eda group by `product category`;

-- 8. Find the number of products in each store section (e.g., WOMAN, MAN).--
select (`section`), count(`product id`) as "total_products"  from zara_sales_eda group by `section`;
select distinct(`section`) from zara_sales_eda;

-- 9.9. Find the number of products listed in each season.-- 
select count(`product id`) as "total_products" , `season` from zara_sales_eda group by `season`;

-- 10. Count how many products were included in promotions and how many were not

select `promotion` ,count(`product id`) as "Total_count" from zara_sales_eda group by `promotion`;
select `promotion` from zara_sales_eda;

-- 11. Find the average price for each product category.
select  `product category` ,avg(price) as "avg_price" from zara_sales_eda group by `product category`;

-- 12. For each brand, calculate both the average price and average sales volume.

select `brand` , avg(`sales volume`) as "avg_sales_volume" , avg(price) as "avg_price"  from zara_sales_eda group by `brand`;


-- 13. Show product count by origin country.
select origin, count(`product id`) as "total_products" from zara_sales_eda group by origin ;
select country from zara_sales_eda;


-- 14. Find the average price for each material type.

select material,avg(price) as "avg price" from zara_sales_eda group by material ;

-- 15 Compare average sales volume between promoted and non-promoted items.

select * from zara_sales_eda;
select promotion, avg(`sales volume`) as "avg sales volumes" from zara_sales_eda group by promotion ;

-- 16. Show total sales volume for each season.
select  season, sum(`sales volume`) as "total_sales_volume" from zara_sales_eda group by season;


-- 17. For each season, find which product category sells the most units.

select season, `product category`, sum(`sales volume`) as "total_sales_volume" from zara_sales_eda group by season, `product category`;

-- 18. Display the top 5 highest-priced products per section (use window functions).

SELECT *
FROM (
    SELECT
        section,
       name as  product,
        price,
        RANK() OVER (PARTITION BY section ORDER BY price DESC) AS price_rank
    FROM zara_sales_eda
) AS t
WHERE price_rank <= 5;

-- 19. Identify brands that have more than 50 products listed.

SELECT 
    brand,
    COUNT(*) AS product_count
FROM zara_sales_eda
GROUP BY brand
HAVING COUNT(*) > 50;


-- *21. Which product category has the highest average sales volume?

select `product category`, avg(`sales volume`) as "avg_sales_volume"  from zara_sales_eda group by `product category` order by avg_sales_volume desc;

-- 22 List the top 3 most expensive brands by average price.
select brand , avg(price) as "avg_price" from zara_sales_eda group by brand order by avg_price desc limit 3;
select distinct(brand) from zara_sales_eda;

-- 23. Compare the average price of promoted vs. non-promoted products.
select promotion ,avg(price) from zara_sales_eda group by promotion;

-- 24. Determine which season has the highest number of promotions.
select season, count(promotion) as "highest_no_promotion" from zara_sales_eda group by season order by highest_no_promotion desc limit 1;

-- 25. Find the most common material used in each section.
select count(material), section from zara_sales_eda group by section;
select material,section from zara_sales_eda;

-- 26. Calculate total revenue per product category (price × sales volume).
select `product category`, sum(price * `sales volume`) as "total revenue" from zara_sales_eda group by `product category`;

--  27.. Rank brands by total revenue (use ranking functions).

SELECT 
    brand,
    SUM(price * `sales volume`) AS total_revenue,
    RANK() OVER (ORDER BY SUM(price * `sales volume`) DESC) AS revenue_rank
FROM zara_sales_eda
GROUP BY brand;

-- 28. Find the average sales volume for each origin country.
select origin, avg(`sales volume`) as "avg_sale_volume"   from zara_sales_eda group by origin;


