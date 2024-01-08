# Multi-Pivot Query

## Question

Add the *gender* column - with the *male/female* values - to the pivot query below. The new column headers should be the *country*, *"'married male'"*, *"'married female'"*, *"'single male'"*, and *"'single female'"*.

```
select country, "'married'", "'single'"
from (select country, status, orders
      from Customers)
pivot(sum(orders)
      for status in ('married', 'single'))
order by country;
```
