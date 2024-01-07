use schema challenge_tasks.public;

-- suspend all tasks after 1h or so
alter task task_1 suspend;
alter task task_2 suspend;
alter task task_3 suspend;
alter task task_4 suspend;

--------------------------------------------------------------------------
-- show all task from current database
show tasks in database challenge_tasks;

-- show all task runs from current database
select *
from table(information_schema.task_history())
where database_name = current_database()
order by query_start_time desc;

--------------------------------------------------------------------------
-- show task WH consumption --> from info schema
-- see https://docs.snowflake.com/en/sql-reference/functions/warehouse_metering_history
select warehouse_name, sum(credits_used) as tot_credits
from table(information_schema.warehouse_metering_history(
    dateadd('days', -1, current_date())))
where warehouse_name like 'WH_TASK_%'
group by 1
order by 1;

-- show task WH consumption --> from info schema
-- see https://docs.snowflake.com/en/sql-reference/functions/serverless_task_history
select task_name, sum(credits_used) as tot_credits
from table(information_schema.serverless_task_history(
    dateadd('days', -1, current_date())))
where task_name like 'TASK_%'
group by 1
order by 1;

--------------------------------------------------------------------------
-- show task WH consumption --> from account usage
-- see https://docs.snowflake.com/en/sql-reference/account-usage/warehouse_metering_history
select warehouse_name, sum(credits_used) as tot_credits
from snowflake.account_usage.warehouse_metering_history
where warehouse_name like 'WH_TASK_%'
group by 1
order by 1;
