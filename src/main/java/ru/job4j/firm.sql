create table departments (
id serial primary key,
title TEXT);

create table employees (
id serial primary key,
name TEXT,
dep_id INT references departments(id)
);
select * from employees;
insert into departments(title) values ('HR');
insert into employees(name, dep_id) values ('Kovtun', 1);
insert into employees(name, dep_id) values ('Tshushko', 1);

insert into departments(title) values ('QA');
insert into employees(name, dep_id) values ('Levkovec', 2);
insert into employees(name, dep_id) values ('Egorova', 2);
insert into employees(name, dep_id) values ('Kudryashov', 2);

insert into departments(title) values ('PD');
insert into employees(name, dep_id) values ('Lesheva', 3);
insert into employees(name, dep_id) values ('Pankina', 3);

insert into departments(title) values ('FIN');
insert into employees(name, dep_id) values ('Enin', 4);


insert into departments(title) values ('SALES');
insert into departments(title) values ('H&S');
insert into departments(title) values ('SCM');

--2. Right, Left, Full--

select d.id as "Dep_Id", d.title, count(e.id)
from departments as d left join employees as e
on d.id = e.dep_id
group by d.id
order by count(e.id) DESC;

select d.id as "Dep_Id", e.name as "Dep_Id", d.title
from departments as d right join employees as e
on d.id = e.dep_id;

select d.id as "Dep_Id", e.name as "Dep_Id", d.title
from departments as d full join employees as e
on d.id = e.dep_id;

--3. Empty departments--
select d.id as "Dep_Id", d.title, e.id as "Employe_Id"
from departments as d left join employees as e
on d.id = e.dep_id
where e.id is null;

-- 4. pairs join left & right with the same results and column order--
select d.id as "Dep_Id", d.title, e.id as "Employe_Id", e.name
from departments as d left join employees as e
on d.id = e.dep_id;
select d.id as "Dep_Id", d.title, e.id as "Employe_Id", e.name
from employees as e right join departments as d
on d.id = e.dep_id;


select d.id as "Dep_Id", d.title, e.id as "Employe_Id", e.name
from departments as d right join employees as e
on d.id = e.dep_id;
select d.id as "Dep_Id", d.title, e.id as "Employe_Id", e.name
from employees as e left join departments as d
on d.id = e.dep_id;

--5. teens pairs full range
create table teens(
	name TEXT,
	gender TEXT
);
insert into teens (name, gender) values ('Ivan', 'Boy');
insert into teens (name, gender) values ('Katya', 'Girl');

select t1.name as n1, t1.gender as g1,
CONCAT_WS('-', t1.name, t2.name) as "Combo"
from teens t1 cross join teens t2;
