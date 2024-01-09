# as Streamlit App
# ================

import streamlit as st
from faker import Faker
import pandas as pd

f = Faker()
output = [[f.name(), f.address(),
  f.city(), f.state(), f.email()]
  for _ in range(10000)]
df = pd.DataFrame(output)
st.dataframe(df)