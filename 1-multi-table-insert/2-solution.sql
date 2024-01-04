-- using different queries (do not run!)
insert into Apples
   select name from Fruits
   where name = 'apple';
insert into Oranges
   select name from Fruits
   where name = 'orange';

-- with multi-table insert
-- see https://docs.snowflake.com/en/sql-reference/sql/insert-multi-table
INSERT FIRST
   WHEN name = 'apple' THEN INTO Apples
   WHEN name = 'orange' THEN INTO Oranges
SELECT name from Fruits;

select * from Apples;
select * from Oranges;
