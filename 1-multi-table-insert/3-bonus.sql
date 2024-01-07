use schema challenge_insert.public;

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
