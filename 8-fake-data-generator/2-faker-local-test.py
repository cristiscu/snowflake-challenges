from faker import Faker
import pandas as pd
import datetime

print(datetime.datetime.now())
f = Faker()
output = [[f.name(), f.address(), f.city(), f.state(), f.email()]
  for _ in range(1000000)]
df = pd.DataFrame(output)

df.to_csv("customers_fake.csv")
print(df)
print(datetime.datetime.now())
