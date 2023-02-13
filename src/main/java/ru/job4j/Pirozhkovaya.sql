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
--no alliance--
select * from pirozhki inner join bakers on pirozhki.baker_id = bakers.id;

--alliances--
select p.title as Пирог, b.surname as Пекарь from pirozhki as
p join bakers as b on p.baker_id = b.id;

select p.title as Пирог, b.surname as Пекарь, p.price as Цена from pirozhki as
p join bakers as b on p.baker_id = b.id;

select b.surname Пекарь, b.country Страна, p.sop as "Старт Продаж" from pirozhki as
p join bakers as b on p.baker_id = b.id;
