use schema challenge_pivot.public;

-- initial pivot query
select country, "'married'", "'single'"
from (select country, status, orders from Customers)
pivot(sum(orders) for status in ('married', 'single'))
order by country;

-- emulated query with single pivot column
select country,
  sum(case when status='married' then orders end) as "'married'",
  sum(case when status='single' then orders end) as "'single'"
from Customers
group by country
order by country;

-- emulated query with multiple pivot columns (SOLUTION!)
-- see also https://medium.com/snowflake/how-to-properly-generate-a-dynamic-pivot-query-in-snowflake-921bde88b300 
select country,
  sum(case when status='married' and gender='male' then orders end) as "'married male'",
  sum(case when status='married' and gender='female' then orders end) as "'married female'",
  sum(case when status='single' and gender='male' then orders end) as "'single male'",
  sum(case when status='single' and gender='female' then orders end) as "'single female'"
from Customers
group by country
order by country;
