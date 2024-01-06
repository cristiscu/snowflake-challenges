from snowflake.snowpark.context import get_active_session
session = get_active_session()

import streamlit as st
tableName = "customers"
df = session.table(tableName).to_pandas()

df2 = st.experimental_data_editor(df, num_rows="dynamic")
if st.button("Update"):
    session.write_pandas(df2, tableName, overwrite=True)
