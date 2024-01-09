# in Python Worksheet
# ===================

# (1) copy&paste into a new Python Worksheet in Snowsight
# (2) select challenge_fake.PUBLIC schema, and COMPUTE_WH warehouse
# (3) add Faker from the Packages popup (already included in Anaconda)
# (4) Run --> new CUSTOMERS_FAKE table created, w/ 1M rows
# (5) check time taken in Query History + look at the generated stored proc

import snowflake.snowpark as snowpark
from snowflake.snowpark.types import StructType, StructField, StringType
from faker import Faker

# generate fake rows but with realistic test synthetic data
def main(session: snowpark.Session):
  f = Faker()
  output = [[f.name(), f.address(), f.city(), f.state(), f.email()]
    for _ in range(1000000)]

  schema = StructType([ 
    StructField("NAME", StringType(), False),  
    StructField("ADDRESS", StringType(), False), 
    StructField("CITY", StringType(), False),  
    StructField("STATE", StringType(), False),  
    StructField("EMAIL", StringType(), False)
  ])
  df = session.create_dataframe(output, schema)
  df.write.mode("overwrite").save_as_table("CUSTOMERS_FAKE")
  # df.show()
  return df
