select * 

from `bigquery-public-data.thelook_ecommerce.order_items`; 

 

SELECT 

  MIN(created_at) AS start_date, 

  MAX(created_at) AS end_date 

FROM 

  `bigquery-public-data.thelook_ecommerce.orders`; 

 

SELECT 

  COUNT(DISTINCT order_id) AS total_orders, 

  COUNT(DISTINCT user_id) AS total_users 

FROM 

  `bigquery-public-data.thelook_ecommerce.orders`; 

 

 

SELECT 

  SUM(sale_price) AS total_revenue 

FROM 

  `bigquery-public-data.thelook_ecommerce.order_items`; 

 

  SELECT 

  EXTRACT(YEAR FROM o.created_at) AS year, 

  COUNT(DISTINCT o.order_id) AS orders, 

  SUM(oi.sale_price) AS revenue, 

  SUM(oi.sale_price) / COUNT(DISTINCT o.order_id) AS aov 

FROM 

  `bigquery-public-data.thelook_ecommerce.orders` o 

JOIN 

  `bigquery-public-data.thelook_ecommerce.order_items` oi 

ON 

  o.order_id = oi.order_id 

GROUP BY year 

ORDER BY year; 

 

WITH first_order AS ( 

  SELECT 

    user_id, 

    MIN(created_at) AS first_order_date 

  FROM 

    `bigquery-public-data.thelook_ecommerce.orders` 

  GROUP BY user_id 

) 

 

SELECT 

  EXTRACT(YEAR FROM o.created_at) AS year, 

  COUNT(DISTINCT o.user_id) AS total_users, 

  COUNT(DISTINCT CASE  

    WHEN EXTRACT(YEAR FROM fo.first_order_date) = EXTRACT(YEAR FROM o.created_at) 

    THEN o.user_id 

  END) AS new_users, 

  SAFE_DIVIDE( 

    COUNT(DISTINCT CASE  

      WHEN EXTRACT(YEAR FROM fo.first_order_date) = EXTRACT(YEAR FROM o.created_at) 

      THEN o.user_id 

    END), 

    COUNT(DISTINCT o.user_id) 

  ) AS new_user_ratio 

FROM 

  `bigquery-public-data.thelook_ecommerce.orders` o 

JOIN 

  first_order fo 

ON 

  o.user_id = fo.user_id 

GROUP BY year 

ORDER BY year; 




 

 
