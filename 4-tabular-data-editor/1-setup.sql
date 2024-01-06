create or replace database challenge_editor;

create table customers (
  id int primary key,
  name string,
  country string,
  status string,
  gender string,
  orders int,
  spent int);

insert into customers values
  (1, 'John', 'USA', 'married', 'male', 3, 100),
  (2, 'Mary', 'Canada', 'married', 'female', 9, 72),
  (3, 'Mark', 'USA', 'single', 'male', 4, 44),
  (4, 'Lee', 'USA', 'married', 'female', 4, 23),
  (5, 'Hanna', 'Norway', 'married', 'female', 8, 120),
  (6, 'George', 'USA', 'single', 'male', 2, 88),
  (7, 'James', 'Canada', 'married', 'male', 7, 65),
  (8, 'Odette', 'Canada', 'single', 'female', 7, 88);

select * from customers;
