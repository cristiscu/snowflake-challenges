create or replace database challenge_hier;

create table employees(employee string, manager string) as
  select * from (values
    ('Hermann Baer', 'Neena Kochhar'),
    ('Shelley Higgins', 'Neena Kochhar'),
    ('Steven King', null),
    ('Neena Kochhar', 'Steven King'),
    ('Lex De Haan', 'Steven King'),
    ('Alexander Hunold', 'Lex De Haan'),
    ('Bruce Ernst', 'Alexander Hunold'),
    ('Valli Pataballa', 'Alexander Hunold'),
    ('Nancy Greenberg', 'Neena Kochhar'),
    ('Ismael Sciarra', 'Nancy Greenberg'),
    ('Jose Manuel Urman', 'Nancy Greenberg'),
    ('Luis Popp', 'Nancy Greenberg'),
    ('Den Raphaely', 'Steven King'),
    ('Alexander Khoo', 'Den Raphaely'),
    ('Shelli Baida', 'Den Raphaely'),
    ('Adam Fripp', 'Steven King'),
    ('Laura Bissot', 'Adam Fripp'));

select * from employees;
