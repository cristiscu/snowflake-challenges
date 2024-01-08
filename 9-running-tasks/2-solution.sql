use schema challenge_tasks.public;

-- suspend all tasks after 1h or so
alter task t1 suspend;
alter task t2 suspend;
alter task t3 suspend;
alter task t4 suspend;

-- show all task from current database
-- see https://docs.snowflake.com/en/user-guide/tasks-intro
show tasks in database challenge_tasks;

-- show duration of all task runs from current database
select name, round(sum(timestampdiff('millisecond',
    query_start_time, completed_time)) / 1000) as seconds
from table(information_schema.task_history())
where database_name = current_database()
group by 1
order by 1;

-- show user-managed task WH consumption --> from info schema
-- see https://docs.snowflake.com/en/sql-reference/functions/warehouse_metering_history
select warehouse_name, sum(credits_used) * 3 as cost
from table(information_schema.warehouse_metering_history(
    dateadd('days', -1, current_date())))
where warehouse_name like 'WHT_'
group by 1
order by 1;

-- show as stacked bar chart
select hour(start_time) as hour,
    credits_used * 3 as cost, 3 - cost as idle
from table(information_schema.warehouse_metering_history(
    dateadd('days', -1, current_date())))
where warehouse_name = 'WHT2';

-- show serverless task consumption --> from info schema
-- see https://docs.snowflake.com/en/sql-reference/functions/serverless_task_history
select task_name, sum(credits_used) * 4.5 as cost
from table(information_schema.serverless_task_history(
    dateadd('days', -1, current_date())))
where task_name like 'T_'
group by 1
order by 1;

-- show as stacked bar chart
select hour(start_time) as hour,
    credits_used * 4.5 as cost, 4.5 - cost as idle
from table(information_schema.serverless_task_history(
    dateadd('days', -1, current_date())))
where task_name = 'T3';
