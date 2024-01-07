-- show ALL object dependencies (in whole account!)
select *
from snowflake.account_usage.object_dependencies;

-- show VIEW-TABLE deps
select referencing_object_name, referenced_object_name
from snowflake.account_usage.object_dependencies
where referencing_object_domain = 'VIEW'
and referenced_object_domain = 'TABLE';

-- alternative: w/ fully qualified names + materialized views
select referencing_object_domain as viewType,
  referencing_database
  || '.' || referencing_schema
  || '.' || referencing_object_name as viewName,
  referenced_database
  || '.' || referenced_schema
  || '.' || referenced_object_name as tableName
from snowflake.account_usage.object_dependencies
where referencing_object_domain like '%VIEW'
and referenced_object_domain = 'TABLE';
