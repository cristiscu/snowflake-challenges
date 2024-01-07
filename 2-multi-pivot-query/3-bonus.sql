use schema challenge_pivot.public;

-- emulated query with single pivot column
select country,
  sum(case when status='married' then orders end) as "'married'",
  sum(case when status='single' then orders end) as "'single'"
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
