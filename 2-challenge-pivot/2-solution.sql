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
select country,
  sum(case when status='married' and gender='male' then orders end) as "'married male'",
  sum(case when status='married' and gender='female' then orders end) as "'married female'",
  sum(case when status='single' and gender='male' then orders end) as "'single male'",
  sum(case when status='single' and gender='female' then orders end) as "'single female'"
from Customers
group by country
order by country;

-- emulated query with multiple aggregate values
select country,
  sum(case when status='married' then orders end) as "'married orders'",
  sum(case when status='married' then spent end) as "'married spent'",
  sum(case when status='single' then orders end) as "'single orders'",
  sum(case when status='single' then spent end) as "'single spent'"
from Customers
group by country
order by country;
