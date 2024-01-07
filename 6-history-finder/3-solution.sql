-- with Query History (when Time Travel not available)
-- see https://docs.snowflake.com/en/sql-reference/functions/query_history

use schema challenge_history.public;

-- for the CUSTOMER table --> check retention_time=1 (one day!)
-- copy also created_on LTZ timestamp (ex: '2024-01-06 07:27:41.874 -0800')
show tables;

select count(*) from customers;

-- could get all INSERT entries w/ QUERY_HISTORY function from inf schema!
select *
from table(information_schema.query_history(
  '2024-01-06 07:27:41.874 -0800'::TIMESTAMP_LTZ,
  current_timestamp(),
  10000))
where database_name = 'CHALLENGE_HISTORY'
  and schema_name = 'PUBLIC'
  and query_type = 'INSERT'
  and execution_status = 'SUCCESS'
order by start_time;

-- refining the projection --> get diff w/ LAG
select start_time,
  datediff('minute', '2024-01-06 07:27:41.874 -0800'::TIMESTAMP_LTZ, start_time) as step,
  query_text,
  rows_produced as tot,
  tot - LAG(tot) over (order by start_time) as diff
from table(information_schema.query_history(
  '2024-01-06 07:27:41.874 -0800'::TIMESTAMP_LTZ,
  current_timestamp(),
  10000))
where database_name = 'CHALLENGE_HISTORY'
  and schema_name = 'PUBLIC'
  and query_type = 'INSERT'
  and execution_status = 'SUCCESS'
order by start_time;

-- group by query (must group by minute!) w/ CTE
-- show bar chart w/ step and diff
with q as (
  select datediff('minute', '2024-01-06 07:27:41.874 -0800'::TIMESTAMP_LTZ, start_time) as step,
    rows_produced - LAG(rows_produced) over (order by start_time) as diff
  from table(information_schema.query_history(
    '2024-01-06 07:27:41.874 -0800'::TIMESTAMP_LTZ,
    current_timestamp(),
    10000))
  where database_name = 'CHALLENGE_HISTORY'
    and schema_name = 'PUBLIC'
    and query_type = 'INSERT'
    and execution_status = 'SUCCESS'
  order by start_time
)
select step, sum(diff) as diff
from q
group by step
order by step;
