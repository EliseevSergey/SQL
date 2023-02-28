create table bakers(
    id INT primary key,
    surname TEXT,
    age INT,
    country TEXT
);

insert into bakers (id, surname, age, country) values (1, 'Kaziev', 44, 'Uzbekistan');
insert into bakers (id, surname, age, country) values (2, 'Smith', 50, 'USA');
insert into bakers (id, surname, age, country) values (3, 'Kobayashi-san', 50, 'Japan');
insert into bakers (id, surname, age, country) values (4, 'Galimov', 33, 'Kazahstan');
insert into bakers (id, surname, age, country) values (5, 'Ivanov', 18, 'Russia');
select * from bakers;

create table pirozhki(
    id INT primary key,
	title TEXT,
	weight SMALLINT,
	vegan BOOL,
	price SMALLINT,
	baker_id INT references bakers(id),
	sop DATE
);
insert into pirozhki(id, title, weight, vegan, price, baker_id, sop)
values(1, 'Energon', 300, false, 100, 2, '2023-02-08');
insert into pirozhki(id, title, weight, vegan, price, baker_id, sop)
values(2, 'GreenPiace', 200, true, 50, 1, '2023-02-07');
insert into pirozhki(id, title, weight, vegan, price, baker_id, sop)
values(3, 'Kanibal', 400, false, 200, 4, '2023-01-01');
insert into pirozhki(id, title, weight, vegan, price, baker_id, sop)
values(4, 'Syogun', 600, false, 200, 3, '2023-01-01');
insert into pirozhki(id, title, weight, vegan, price, baker_id, sop)
values(5,'Shawarma', 600, false, 200, 5, '2022-01-01');
select * from pirozhki;

create table clients(
    id serial primary key,
    name TEXT
);

insert into clients (name) values ('Megan Fox');
insert into clients (name) values ('Greta Thunberg');
insert into clients (name) values ('Ganibal Lector');
insert into clients (name) values ('Toshimitsu-san');
insert into clients (name) values ('Sidorov');

select * from clients;

create table po(
    id serial primary key,
    client_id INT references clients(id),
    date DATE
);

create table order_list (
    order_list_id INT references po(id),
    pirozhok_id INT references pirozhki(id),
    qty INT
);

select * from clients;
drop table clients CASCADE;
drop table po;

insert into po (client_id, date) values (1, '2023-01-01');
insert into po (client_id, date) values (2, '2023-01-01');
insert into po (client_id, date) values (3, '2023-01-02');
insert into po (client_id, date) values (4, '2023-01-02');
insert into po (client_id, date) values (5, '2023-01-02');

select *from order_list;
insert into order_list (order_list_id, pirozhok_id, qty) values (1, 1, 4);
insert into order_list (order_list_id, pirozhok_id, qty) values (1, 5, 2);
insert into order_list (order_list_id, pirozhok_id, qty) values (2, 2, 4);
insert into order_list (order_list_id, pirozhok_id, qty) values (2, 5, 2);
insert into order_list (order_list_id, pirozhok_id, qty) values (3, 3, 2);
insert into order_list (order_list_id, pirozhok_id, qty) values (3, 5, 1);
insert into order_list (order_list_id, pirozhok_id, qty) values (4, 4, 3);
insert into order_list (order_list_id, pirozhok_id, qty) values (4, 5, 4);
insert into order_list (order_list_id, pirozhok_id, qty) values (5, 5, 2);

select p.id as po_id, date, p.client_id as client_id, c.name as customer,  p.pirozhok_id, pi.title as pirozhok
, p.qty as qty_pirozhkov, b.surname as baker from po as p
join clients as c
on c.id = p.client_id
join pirozhki as pi
on pi.id = p.pirozhok_id
join bakers as b
on pi.baker_id = b.id
join order_list as ol
on ol.order_list_id = p.id;

--TOTAL NEW
select po.id as po_id, date, po.client_id as client_id, c.name as customer
, ol.pirozhok_id, p.title, p.price as "price for 1",  ol.qty, p.price * ol.qty as "TOTAL"

from po as po
 join clients as c
on c.id = po.client_id
join order_list as ol
on ol.order_list_id = po.id
join pirozhki as p
on p.id = ol.pirozhok_id;



--no alliance--
select * from pirozhki inner join bakers on pirozhki.baker_id = bakers.id;

--alliances--
select p.title as Пирог, b.surname as Пекарь from pirozhki as
p join bakers as b on p.baker_id = b.id;

select p.title as Пирог, b.surname as Пекарь, p.price as Цена from pirozhki as
p join bakers as b on p.baker_id = b.id;

select b.surname Пекарь, b.country Страна, p.sop as "Старт Продаж" from pirozhki as
p join bakers as b on p.baker_id = b.id;


