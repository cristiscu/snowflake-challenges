-- copy, paste & run this from a new SQL worksheet in your Snowflake account
create or replace database challenge_deps;

create table T1(id int, json variant);
create table T2(id int, id_t1 int, name string);

create view V1 as (
  select json, name from T1 join T2 on T1.id = T2.id_t1);

-- only for Enterprise edition!
create materialized view V2 as select id, id_t1 from T2;

create function F1() returns variant
as 'select top 1 json from V1';
