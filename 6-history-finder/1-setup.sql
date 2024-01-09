-- copy, paste & run this from a new SQL worksheet in your Snowflake account
create or replace database challenge_history;

create table customers(name string, country string);

-- copy/paste/run randomly several of the INSERTs below for about 10 minutes
insert into customers values ('John', 'Canada');
insert into customers values ('Mark', 'USA'), ('Jane', 'Scotland');
insert into customers values ('Emma', 'USA'), ('Cristi', 'Romania'), ('Jack', 'USA');
insert into customers values ('Vasile', 'Romania');
insert into customers values ('Magda', 'Poland');
insert into customers values ('Mark', 'USA');
insert into customers values ('Mark', 'USA'), ('Jane', 'Scotland');
insert into customers values ('Emma', 'USA'), ('Cristi', 'Romania'), ('Jack', 'USA');
insert into customers values ('Vasile', 'Romania');

-- keep it at around 100 total
select count(*) from customers;
