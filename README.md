**# 📊 Retail Sales Analysis SQL Project**



**## 📌 Project Overview**

**This SQL project analyzes retail sales data to uncover customer purchasing behavior, category performance, sales trends, and revenue insights.**



**The project simulates real-world business analysis tasks commonly performed by Data Analysts using SQL.**



### CREATE TABLE FOR SALES\_DATA



CREATE TABLE RETAILS(

&#x09;CUSTOMER\_ID INT,

&#x09;CATEGORY VARCHAR(50),

&#x09;TOTAL\_SALE INT,

&#x20;   SALES\_DATE DATE,

&#x20;   SALE\_TIME TIME

&#x20;   );



### INSERT DATA INTO TABLES



INSERT INTO retails VALUES

(1, 101, 'Clothing', 50.00, '2022-11-01', '10:30:00'),

(2, 102, 'Electronics', 200.00, '2022-11-02', '14:00:00'),

(3, 101, 'Clothing', 75.00, '2022-11-03', '11:15:00'),

(4, 103, 'Groceries', 30.00, '2022-11-04', '09:45:00'),

(5, 104, 'Electronics', 150.00, '2022-11-05', '16:20:00'),

(6, 102, 'Clothing', 60.00, '2022-11-06', '12:10:00'),

(7, 105, 'Groceries', 25.00, '2022-11-07', '08:30:00'),

(8, 101, 'Electronics', 300.00, '2022-11-08', '18:00:00');





###### **NOW, WE CAN START LOOK UP TO SOME QUESTIONS**



**1.Total Revenue by Category;**



SELECT CATEGORY,SUM(TOTAL\_SALE) FROM RETAILS

GROUP BY 1;



&#x20;**2.Top 5 Customers Overall**



SELECT customer\_id, SUM(total\_sale) AS total\_spent

FROM retails

GROUP BY customer\_id

ORDER BY total\_spent DESC

LIMIT 5;



&#x20;**3.Monthly Sales Trend**



select SUM(TOTAL\_SALE) AS TOTAL,DATE\_FORMAT(SALES\_DATE,'%Y-%M') AS MONTH FROM RETAILS

GROUP BY 2;



**4.Average Order Value**



SELECT AVG(total\_sale) AS avg\_order\_value

FROM retails;



**5.Early vs Late Orders**



&#x20;   SELECT 

CASE 

&#x20;   WHEN sale\_time <= '12:00:00' THEN 'EARLY'

&#x20;   ELSE 'LATE'

END AS order\_type,

COUNT(\*) AS total\_orders

FROM retails

GROUP BY order\_type;



**6.Highest Sale per Category**



SELECT category, MAX(total\_sale) AS max\_sale

FROM retails

GROUP BY category;



**7.Customers with More Than 2 Orders**



SELECT customer\_id, COUNT(\*) AS total\_orders

FROM retails

GROUP BY customer\_id

HAVING COUNT(\*) > 2;



**8.Running Total per Customer (Window Function ⭐)**



select customer\_id,category,sales\_date,total\_sale,

sum(total\_sale) over(partition by customer\_id order by sales\_date) as running\_total

from retails;



**9. Top 2 Sales per Category (Window Function ⭐)**



SELECT \*

FROM (

&#x20;   SELECT \*, 

&#x20;   RANK() OVER (PARTITION BY category ORDER BY total\_sale DESC) AS rnk

&#x20;   FROM retails

) t

WHERE rnk <= 2;



&#x20;**10. Sales in Last 30 Days**



SELECT \*

FROM retails

WHERE sales\_date >= CURRENT\_DATE - INTERVAL 30 DAY;



**11.Customers Above Average Spending**



SELECT customer\_id, SUM(total\_sale) AS total\_spent

FROM retails

GROUP BY customer\_id

HAVING total\_spent > (

&#x20;   SELECT AVG(total\_sale) FROM retails

);



**-- End of project--**





