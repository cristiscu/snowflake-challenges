use role accountadmin;
create or replace database challenge_secret;

-- for Jack
create or replace role jack;
grant role jack to role sysadmin;

create table vault_jack (secrets string);
grant ownership on table vault_jack to role jack;
grant usage on database challenge_secret to role jack;
grant usage on schema challenge_secret.public to role jack;
grant usage on warehouse compute_wh to role jack;

-- must also do this (I'll explain later ;))
grant create row access policy on schema challenge_secret.public to role jack;

-- for Mary
create or replace role mary;
grant role mary to role sysadmin;

create table vault_mary (secrets string);
grant ownership on table vault_mary to role mary;
grant usage on database challenge_secret to role mary;
grant usage on schema challenge_secret.public to role mary;
grant usage on warehouse compute_wh to role mary;
