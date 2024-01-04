select ltrim(sys_connect_by_path(${child_index}, '.'), '.') as path
from {tableName}
start with ${parent_index} is null
connect by prior ${child_index} = ${parent_index}
order by path;
