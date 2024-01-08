# Multi-Table Insert

## Question

Using one single SQL statement, copy all *'apple'* entries from the **Fruits** table into the **Apples** table, and all *'orange'* entries into the **Oranges** table:

```
create table Fruits (name string) as
  select * from values
    ('apple'), ('orange'), ('apple');

create table Apples (name string);
create table Oranges (name string);
```