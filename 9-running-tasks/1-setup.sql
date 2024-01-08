create or replace database challenge_tasks;

create table task_history(ts timestamp, tname string);

-- t1 every minute
create or replace warehouse wht1 auto_suspend=60;
create task t1 warehouse=wht1 schedule='1 minute'
  as insert into task_history values (current_timestamp(), 't1');
alter task t1 resume;

-- t2 every 2 minutes
create or replace warehouse wht2 auto_suspend=60;
create task t2 warehouse=wht2 schedule='2 minute'
  as insert into task_history values (current_timestamp(), 't2');
alter task t2 resume;

-- t3 serverless, every minute
create task t3 schedule='1 minute'
  as insert into task_history values (current_timestamp(), 't3');
alter task t3 resume;

-- t4 serverless, every 2 minutes
create task t4 schedule='2 minute'
  as insert into task_history values (current_timestamp(), 't4');
alter task t4 resume;
