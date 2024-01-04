select repeat('  ', level - 1) || employee_name as name,
    ltrim(sys_connect_by_path(employee_name, '.'), '.') as path
  from Employees
  start with manager_name is null
  connect by prior employee_name = manager_name
  order by path
  
-- this is not working
select repeat('  ', level - 1) || employee_name
from Employees
start with manager_name is null
connect by prior employee_name = manager_name
order by sys_connect_by_path(employee_name, '.');

-- final query
with q as (select repeat('  ', level - 1) || employee_name as name,
    ltrim(sys_connect_by_path(employee_name, '.'), '.') as path
  from Employees
  start with manager_name is null
  connect by prior employee_name = manager_name
  order by path)
select name from q;
