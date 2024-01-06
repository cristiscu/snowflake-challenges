import streamlit as st

from snowflake.snowpark.context import get_active_session
session = get_active_session()

query = """
select referencing_object_domain as viewType,
  referencing_database
  || '.' || referencing_schema
  || '.' || referencing_object_name as viewName,
  referenced_database
  || '.' || referenced_schema
  || '.' || referenced_object_name as tableName
from snowflake.account_usage.object_dependencies
where referencing_object_domain like '%VIEW'
and referenced_object_domain = 'TABLE'
"""
rows = session.sql(query).collect()

edges = ""
for row in rows:
    edges += f'\t"{str(row[1])}" -> "{str(row[2])}";\n'
d = ('digraph {\n'
    + '\tgraph [rankdir="LR"]\n'
    + '\tnode [shape="rect"]\n'
    + f'{edges}'
    + '}')

# paste at http://magjac.com/graphviz-visual-editor/
st.code(d)
st.graphviz_chart(d)
