--1)Total spending per customer
select "CustomerID",
	ROUND(SUM("Quantity" * "UnitPrice")::numeric, 2) AS total_spending
from kaggle
where  "Quantity" > 0
  and  "UnitPrice" > 0
  and  "InvoiceNo"::text not like 'C%'
  and  "CustomerID" is not null
  and  "Description" not in ('POSTAGE', 'Manual','DOTCOM POSTAGE','AMAZON FEE')
  group by "CustomerID" 
  order by total_spending desc; 

--2)Top 10 products by revenue
select  
    "Description",
    round(sum("Quantity" * "UnitPrice")::numeric, 2) as revenue
from kaggle
where  "Quantity" > 0
  and  "UnitPrice" > 0
  and  "InvoiceNo"::text not like 'C%'
  and  "Description" is not null
  and  "Description" not in ('POSTAGE', 'Manual','DOTCOM POSTAGE', 'AMAZON FEE')
group by  "Description"
order by revenue DESC
LIMIT 10;

--3)Group sales by country & date
select
	"Country",
    date_trunc('month', "InvoiceDate"::timestamp)::date AS sale_month,
    round(sum("Quantity" * "UnitPrice")::numeric, 2) AS total_sales
from kaggle
where "Quantity" > 0
  and "UnitPrice" > 0
  and "Description" not in ('POSTAGE', 'Manual','DOTCOM POSTAGE', 'AMAZON FEE')
  and "InvoiceNo"::text not like 'C%'
  and "InvoiceDate" is not null
  and "Country" is not null
  and "Country" not in ('Unspecified', 'Unknown')
group by "Country" , sale_month
order by "Country" , total_sales;


