from snowflake.snowpark.context import get_active_session
session = get_active_session()

import streamlit as st
tableName = "customers"
df = session.table(tableName).to_pandas()

# see https://docs.streamlit.io/library/api-reference/data/st.data_editor
df2 = st.experimental_data_editor(df, num_rows="dynamic")
if st.button("Update"):
    # see https://docs.snowflake.com/en/developer-guide/snowpark/reference/python/latest/api/snowflake.snowpark.Session.write_pandas
    session.write_pandas(df2, tableName, overwrite=True)
