create or replace database challenge_tasks;

-- task1 every minute
create or replace warehouse wh_task_1
    WAREHOUSE_SIZE=XSMALL
    AUTO_SUSPEND=60
    AUTO_RESUME=TRUE;
create task task_1
    warehouse=wh_task_1
    schedule='1 minute'
as select system$wait(10);
alter task task_1 resume;

-- task2 every 2 minutes
create or replace warehouse wh_task_2
    WAREHOUSE_SIZE=XSMALL
    AUTO_SUSPEND=60
    AUTO_RESUME=TRUE;
create task task_2
    warehouse=wh_task_2
    schedule='2 minute'
as select system$wait(10);
alter task task_2 resume;

-- task3 serverless, every minute
create task task_3
    USER_TASK_MANAGED_INITIAL_WAREHOUSE_SIZE='XSMALL'
    schedule='1 minute'
as select system$wait(10);
alter task task_3 resume;

-- task4 serverless, every 2 minutes
create task task_4
    USER_TASK_MANAGED_INITIAL_WAREHOUSE_SIZE='XSMALL'
    schedule='2 minute'
as select system$wait(10);
alter task task_4 resume;
