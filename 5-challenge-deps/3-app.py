import streamlit as st

from snowflake.snowpark.context import get_active_session
session = get_active_session()

query = """
select referencing_object_name, referenced_object_name
from snowflake.account_usage.object_dependencies
where referencing_object_domain = 'VIEW'
and referenced_object_domain = 'TABLE'
"""
rows = session.sql(query).collect()

edges = ""
for row in rows:
    edges += f'\t"{str(row[0])}" -> "{str(row[1])}";\n'
d = f'digraph {{\n\tgraph [rankdir="LR"]\n{edges}}}'

st.code(d)
st.graphviz_chart(d)
