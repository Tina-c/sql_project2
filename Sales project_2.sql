-- Sales project - 2


CREATE TABLE RETAILS(
	CUSTOMER_ID INT,
	CATEGORY VARCHAR(50),
	TOTAL_SALE INT,
    SALES_DATE DATE,
    SALE_TIME TIME
    );
    
ALTER TABLE RETAILS
ADD COLUMN TRANSACTION_ID INT FIRST;

INSERT INTO retails VALUES
(1, 101, 'Clothing', 50.00, '2022-11-01', '10:30:00'),
(2, 102, 'Electronics', 200.00, '2022-11-02', '14:00:00'),
(3, 101, 'Clothing', 75.00, '2022-11-03', '11:15:00'),
(4, 103, 'Groceries', 30.00, '2022-11-04', '09:45:00'),
(5, 104, 'Electronics', 150.00, '2022-11-05', '16:20:00'),
(6, 102, 'Clothing', 60.00, '2022-11-06', '12:10:00'),
(7, 105, 'Groceries', 25.00, '2022-11-07', '08:30:00'),
(8, 101, 'Electronics', 300.00, '2022-11-08', '18:00:00');

SELECT * FROM RETAILS;

-- 1.Total Revenue by Category;

SELECT CATEGORY,SUM(TOTAL_SALE) FROM RETAILS
GROUP BY 1;

-- 2.Top 5 Customers Overall

SELECT customer_id, SUM(total_sale) AS total_spent
FROM retails
GROUP BY customer_id
ORDER BY total_spent DESC
LIMIT 5;

-- 3.Monthly Sales Trend

select SUM(TOTAL_SALE) AS TOTAL,DATE_FORMAT(SALES_DATE,'%Y-%M') AS MONTH FROM RETAILS
GROUP BY 2;

-- 4.Average Order Value

SELECT AVG(total_sale) AS avg_order_value
FROM retails;

-- 5.Early vs Late Orders

    SELECT 
CASE 
    WHEN sale_time <= '12:00:00' THEN 'EARLY'
    ELSE 'LATE'
END AS order_type,
COUNT(*) AS total_orders
FROM retails
GROUP BY order_type;

-- 6.Highest Sale per Category

SELECT category, MAX(total_sale) AS max_sale
FROM retails
GROUP BY category;

-- 7.Customers with More Than 2 Orders

SELECT customer_id, COUNT(*) AS total_orders
FROM retails
GROUP BY customer_id
HAVING COUNT(*) > 2;

-- 8.Running Total per Customer (Window Function ⭐)

select customer_id,category,sales_date,total_sale,
sum(total_sale) over(partition by customer_id order by sales_date) as running_total
from retails;

-- 9. Top 2 Sales per Category (Window Function ⭐)

SELECT *
FROM (
    SELECT *, 
    RANK() OVER (PARTITION BY category ORDER BY total_sale DESC) AS rnk
    FROM retails
) t
WHERE rnk <= 2;

-- 10. Sales in Last 30 Days

SELECT *
FROM retails
WHERE sales_date >= CURRENT_DATE - INTERVAL 30 DAY;

-- 11.Customers Above Average Spending

SELECT customer_id, SUM(total_sale) AS total_spent
FROM retails
GROUP BY customer_id
HAVING total_spent > (
    SELECT AVG(total_sale) FROM retails
);

-- End of project--

