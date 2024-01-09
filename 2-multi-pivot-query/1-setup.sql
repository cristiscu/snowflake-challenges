-- copy, paste & run this from a new SQL worksheet in your Snowflake account
create or replace database challenge_pivot;

-- create and populate test table
create table Customers (
  name string,
  country string,
  status string,
  gender string,
  orders int,
  spent int);
insert into Customers values
  ('John', 'USA', 'married', 'male', 3, 100),
  ('Mary', 'Canada', 'married', 'female', 9, 72),
  ('Mark', 'USA', 'single', 'male', 4, 44),
  ('Lee', 'USA', 'married', 'female', 4, 23),
  ('Hanna', 'Norway', 'married', 'female', 8, 120),
  ('George', 'USA', 'single', 'male', 2, 88),
  ('James', 'Canada', 'married', 'male', 7, 65),
  ('Odette', 'Canada', 'single', 'female', 7, 88);

-- initial pivot query
select country, "'married'", "'single'"
from (select country, status, orders from Customers)
pivot(sum(orders) for status in ('married', 'single'))
order by country;
