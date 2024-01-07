-- with Recursive CTEs and Recursive Views
-- see https://docs.snowflake.com/en/sql-reference/constructs/with#recursive-clause
-- see https://docs.snowflake.com/en/sql-reference/sql/create-view#examples

use schema challenge_hier.public;

-- recursive CTE
with recursive cte (level, name, path, employee) as (
  select 1, employee, employee, employee
    from employees
    where manager is null
  union all
  select m.level + 1,
    repeat('  ', level) || e.employee,
    path || '.' || e.employee,
    e.employee
    from employees e join cte m on e.manager = m.employee)
select name, path
from cte
order by path;

-- recursive view
create recursive view employee_hierarchy (level, name, path, employee) as (
  select 1, employee, employee, employee
    from employees
    where manager is null
  union all
  select m.level + 1,
    repeat('  ', level) || e.employee,
    path || '.' || e.employee,
    e.employee
    from employees e join employee_hierarchy m on e.manager = m.employee);

select name, path
from employee_hierarchy
order by path;
