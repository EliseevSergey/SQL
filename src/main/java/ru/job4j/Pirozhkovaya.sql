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