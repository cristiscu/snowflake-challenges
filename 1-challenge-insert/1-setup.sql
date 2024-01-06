create or replace database challenge_insert;

create table Fruits (name string) as
  select * from values ('apple'), ('orange'), ('apple');

create table Apples (name string);
create table Oranges (name string);
