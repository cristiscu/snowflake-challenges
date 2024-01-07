# local test (after pip install faker)
# ====================================

from faker import Faker
import pandas as pd

f = Faker()
output = [[f.name(), f.address(), f.city(), f.state(), f.email()]
  for _ in range(10000000)]
df = pd.DataFrame(output)
print(df)