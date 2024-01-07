-- with CONNECT BY (only for self-joins)
-- see https://docs.snowflake.com/en/sql-reference/constructs/connect-by

use schema challenge_hier.public;

select repeat('  ', level - 1) || employee as name, 
  ltrim(sys_connect_by_path(employee, '.'), '.') as path
from employees
start with manager is null
connect by prior employee = manager
order by path;
