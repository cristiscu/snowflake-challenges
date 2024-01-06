use role mary;
insert into vault_mary values ('I like cookies');

-- this should fail
select * from vault_jack;

-- try this before and after the row access policy!
select j.secrets = m.secrets from vault_jack j, vault_mary m;
