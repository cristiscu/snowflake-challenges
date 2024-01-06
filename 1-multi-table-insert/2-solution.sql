-- Multi-Table INSERT
-- see https://docs.snowflake.com/en/sql-reference/sql/insert-multi-table

-- using different queries (do not run!)
insert into Apples
   select name from Fruits
   where name = 'apple';
insert into Oranges
   select name from Fruits
   where name = 'orange';

-- with INSERT FIRST (SOLUTION!)
INSERT FIRST
   WHEN name = 'apple' THEN INTO Apples
   WHEN name = 'orange' THEN INTO Oranges
SELECT name from Fruits;

select * from Apples;
select * from Oranges;

-- with INSERT ALL (and OVERWRITE)
create table Fruits5 (name string);
create table FruitsElse (name string);

INSERT OVERWRITE ALL
   WHEN name = 'apple' THEN INTO Apples
   WHEN name = 'orange' THEN INTO Oranges
   WHEN len(name) = 5 THEN INTO Fruits5
   ELSE INTO FruitsElse
SELECT name from Fruits;

select * from Apples;
select * from Oranges;
select * from Fruits5;
select * from FruitsElse;
