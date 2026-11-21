select * from project1.cleaned_retail_sales;


select category,
       sum(total_spent) as highest_total_revenue,
       sum(quantity) as highest_unit_volume,
       avg(price_per_unit) as avg_value
from project1.cleaned_retail_sales
group by category
order by  highest_total_revenue desc;

select category,
       sum(total_spent) as highest_total_revenue,
       sum(quantity) as highest_unit_sales
from project1.cleaned_retail_sales
group by category;


select category,sum(total_spent) as revenue, count(*) as transaction_count
from project1.cleaned_retail_sales
group by category
order by revenue desc
limit 10;

select avg(total_spent) as avg_spent,avg(case when discount_applied='True' then 1 else 0 end )*100 as discount_applied
from project1.cleaned_retail_sales;

SELECT 
    discount_applied,
    COUNT(*) AS transaction_count,
    ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (), 2) AS pct_of_transactions,
    ROUND(AVG(total_spent), 2) AS avg_total_spent
FROM project1.cleaned_retail_sales
GROUP BY discount_applied;

select location,
       sum(total_spent) as total_revenue,
       round(sum(total_spent)*100/sum(sum(total_spent)) over (),2) as total_revenue_pct,
       count(*) as transaction_volume,
      round( count(*)*100/sum(count(*)) over (),2) as transaction_volume_pct
from project1.cleaned_retail_sales
group by location;

select payment_method,
       count(*) as trasaction_count,
       count(payment_method)*100/sum(count(payment_method)) over() as pct_preferred_payment
       from project1.cleaned_retail_sales
group by payment_method;

select customer_id,
       sum(total_spent) as total_spent,
	  round( sum(total_spent)*100.0/sum(sum(total_spent)) over(),2) as spending_share
from project1.cleaned_retail_sales
group by customer_id
order by total_spent desc
limit 5;

select extract(year from transaction_date) as sales_year,
       extract(month from transaction_date) as sales_month,
	   sum(total_spent) as total_revenue,
       count(*) as transaction_count
from project1.cleaned_retail_sales
where extract(year from transaction_date) in (2022,2023,2024)
group by extract(year from transaction_date),extract(month from transaction_date)
order by sales_year;

select customer_id,
       sum(total_spent) as total_spent,
       count(*) as transaction_count,
       round(avg(total_spent),2) as average_order_value
from project1.cleaned_retail_sales
group by customer_id
order by total_spent desc;

select customer_id,
       min(transaction_date) as first_purchase,
       max(transaction_date) as last_purchase,
       datediff(max(transaction_date),min(transaction_date)) as total_lifespan
from project1.cleaned_retail_sales
group by customer_id;

select concat('q',quarter(transaction_date) )as quarter,
      sum(total_spent) as total_revenue ,
      count(*) as transaction_volume
from project1.cleaned_retail_sales
where year(transaction_date)=2024
group by quarter
order by total_revenue desc;

select *
from 
(
select item,
       sum(quantity) as unit_volume,
       sum(total_spent) as total_revenue
from project1.cleaned_retail_sales
group by item
order by unit_volume desc
limit 15
) as top15
where total_revenue<2000;

select * 
from(
select item,
       count(*) as total_transaction
from project1.cleaned_retail_sales
group by item) as tt

where total_transaction<10;

select category,
       count(*) as total_transaction,
       discount_applied
from project1.cleaned_retail_sales
where discount_applied='True'
group by category
order by total_transaction desc;

select sum(total_spent) as total_revenue,
       count(*) as transaction_count,
       case when dayofweek(transaction_date) in (1,7) then 'weekend'
       else 'weekday' end as day_type
from project1.cleaned_retail_sales
group by day_type












 