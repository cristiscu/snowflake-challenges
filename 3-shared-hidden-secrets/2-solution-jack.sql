use schema challenge_secret.public;
use role jack;
insert into vault_jack values ('I like grapes');

-- this should fail
select * from vault_mary;

-- allows Mary to run one single possible query!
create row access policy vault_jack_access
  as (secrets string) returns boolean ->
  current_role() in ('ACCOUNTADMIN', 'JACK')
    or current_statement() = 'select j.secrets = m.secrets from vault_jack j, vault_mary m;';

alter table vault_jack
  add row access policy vault_jack_access on (secrets);

grant select on table vault_jack to role mary;
