CREATE TABLE company (
    id integer NOT NULL,
    name character varying,
    CONSTRAINT company_pkey PRIMARY KEY (id)
);

CREATE TABLE person
(
    id integer NOT NULL,
    name character varying,
    company_id integer references company(id),
    CONSTRAINT person_pkey PRIMARY KEY (id)
);
insert into company (id, name) values
(1, 'MacDonalds'),
(2, 'Yandex'),
(3, 'METRO'),
(4, 'Canon'),
(5, 'POLICE'),
(6, 'Bar'),
(7, 'StartUp company');
select  * from company;
insert into person (id, name, company_id) values (1, 'Nakazawa-san', 1),(4, 'Kobyashi-san',1),
(2, 'Yura', 2), (3, 'Misha', 2), (5, 'Baba Nura', 3), (6, 'Oleg', 5), (7, 'Oleg', 5), (11, 'Jony', 5), (8, 'Nikolai Alexandrovich', 6),
(9, 'Pavel Georgevich', 6), (10, 'Alexander Valentinovich', 6),
(12, 'Mr. Free', null);

--0. OUT OF TASK FROM JOB4J. Everybody + all companies
select c.id as company_id , c.name, p.id as person_id, p.name, p.company_id as wokr_place_id
 from company as c full join person as p on c.id = p.company_id order by c.id ASC;

--1. Without employees from company_id = 5, but including unemployed
select p.id as person_id, p.name, p.company_id as work_place_id, c.id as company_id , c.name
 from person as p left join company as c on p.company_id = c.id where p.company_id <> 5 or p.company_id is null order by p.id ASC;

--2. Company list with maximum employees quantity
select c.name, count(p.company_id) from company as c
join person as p on c.id = p.company_id
group by c.name
having count(p.company_id) = (
    select count(company_id) as c from person
    group by company_id
    order by c DESC limit 1
);

/*
BELOW JUST FOR REMINDER. THIS IS NOT HOW IT'S TO BE DONE.
SEE ABOBE FOR CORRECT SHORT WAY
Company list with maximum employees quantity
*/

select max_staff_qty, company
 from (
 select count(p.name) as max_staff_qty, c.name as company
 from company as c join person as p on c.id = p.company_id
 group by c.id
 ) as subMax
 where max_staff_qty = (select max(max_staff_qty) from (select count(p.name) as max_staff_qty
  from company as c join person as p on c.id = p.company_id group by c.id) as subFilter);