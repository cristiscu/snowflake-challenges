create or replace database inserts_db;

create table Fruits (name string) as
  select * from values ('apple'), ('orange'), ('apple');

create table Apples (name string);
create table Oranges (name string);
