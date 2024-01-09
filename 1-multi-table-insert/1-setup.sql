-- copy, paste & run this from a new SQL worksheet in your Snowflake account
create or replace database challenge_insert;

create table Fruits (name string) as
  select * from values ('apple'), ('orange'), ('apple');

create table Apples (name string);
create table Oranges (name string);
