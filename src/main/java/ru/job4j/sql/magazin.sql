create table type (
id INT primary key,
name TEXT
);

create table product (
id INT primary key,
name TEXT,
type_id INT references type(id),
expired_date DATE,
price INT);
select * from product;

insert into type (id, name) values (1, 'СЫР');
insert into type (id, name) values (2, 'КОЛБАСА');
insert into type (id, name) values (3, 'ЧАЙ');
insert into type (id, name) values (4, 'ХЛЕБ');
insert into type (id, name) values (5, 'ОВОЩИ');
insert into type (id, name) values (6, 'Мороженное');

select * from type;

insert into product (id, name, type_id, expired_date, price) values (1, 'Копчёный', 1, '2023-02-21', 500);
insert into product (id, name, type_id, expired_date, price) values (2, 'Адыгейский', 1, '2023-02-25', 600);
insert into product (id, name, type_id, expired_date, price) values (3, 'Фета', 1, '2023-03-01', 800);
insert into product (id, name, type_id, expired_date, price) values (4, 'ДарБлю', 1, '2022-03-01', 2000);
insert into product (id, name, type_id, expired_date, price) values (5, 'ДарБлю', 1, '2022-03-01', 2000);
insert into product (id, name, type_id, expired_date, price) values (6, 'Мацарелло', 1, '2023-03-01', 900);
insert into product (id, name, type_id, expired_date, price) values (7, 'Брынза', 1, '2023-03-01', 300);
insert into product (id, name, type_id, expired_date, price) values (8, 'Дружба', 1, '2023-04-01', 400);
insert into product (id, name, type_id, expired_date, price) values (9, 'Океан', 1, '2023-04-01', 400);
insert into product (id, name, type_id, expired_date, price) values (10, 'Щлачина', 1, '2025-04-01', 4000);
insert into product (id, name, type_id, expired_date, price) values (11, 'Чедер', 1, '2022-04-01', 2000);

insert into product (id, name, type_id, expired_date, price) values (12, 'Докторская', 2, '2023-02-21', 500);
insert into product (id, name, type_id, expired_date, price) values (13, 'Браунгшвейская', 2, '2023-02-25', 600);
insert into product (id, name, type_id, expired_date, price) values (14, 'Краковская', 2, '2023-03-01', 800);
insert into product (id, name, type_id, expired_date, price) values (15, 'Австралийская', 2, '2022-03-01', 2000);
insert into product (id, name, type_id, expired_date, price) values (16, 'Из Кабана', 2, '2022-03-01', 2000);
insert into product (id, name, type_id, expired_date, price) values (17, 'Охотничья', 2, '2023-03-01', 900);
insert into product (id, name, type_id, expired_date, price) values (18, 'С кенгуру', 2, '2023-03-01', 300);
insert into product (id, name, type_id, expired_date, price) values (19, 'Шикарная', 2, '2023-04-01', 400);
insert into product (id, name, type_id, expired_date, price) values (20, 'Кремлёвская', 2, '2023-04-01', 400);
insert into product (id, name, type_id, expired_date, price) values (21, 'Рыбная', 2, '2025-04-01', 4000);
insert into product (id, name, type_id, expired_date, price) values (22, 'Английская', 2, '2022-04-01', 2000);

insert into product (id, name, type_id, expired_date, price) values (23, 'Пуэр', 3, '2025-04-01', 6000);
insert into product (id, name, type_id, expired_date, price) values (24, 'МиланЦянДанЦун', 3, '2025-04-01', 1000);
insert into product (id, name, type_id, expired_date, price) values (25, 'Хейча', 3, '2022-04-01', 2000);
insert into product (id, name, type_id, expired_date, price) values (35, 'Мороженное Солнце', 3, '2024-04-01', 2000);

insert into product (id, name, type_id, expired_date, price) values (26, 'Черный', 4, '2023-04-01', 100);

insert into product (id, name, type_id, expired_date, price) values (27, 'Картошка', 5, '2023-03-01', 100);
insert into product (id, name, type_id, expired_date, price) values (28, 'Помидоры', 5, '2023-03-01', 500);
insert into product (id, name, type_id, expired_date, price) values (29, 'Огурцы', 5, '2023-03-01', 500);
insert into product (id, name, type_id, expired_date, price) values (30, 'Тыква', 5, '2023-04-01', 700);
insert into product (id, name, type_id, expired_date, price) values (31, 'Свекла', 5, '2023-02-01', 50);

insert into product (id, name, type_id, expired_date, price) values (32, 'Торт мороженное', 6, '2023-03-01', 1500);
insert into product (id, name, type_id, expired_date, price) values (33, 'Мороженное Коровка', 6, '2023-05-01', 100);
insert into product (id, name, type_id, expired_date, price) values (34, 'Мороженное Вологодское', 6, '2023-05-01', 200);
insert into product (id, name, type_id, expired_date, price) values (36, 'Мороженное Лёд', 6, '2023-05-01', 200);
insert into product (id, name, type_id, expired_date, price) values (38, 'Мороженное 6000Rub', 6, '2023-4-01', 6000);
--1 запрос получение всех продуктов с типом "СЫР" --

select t.name, p.type_id, p.name, p.price, p.expired_date
from product as p
join type as t
on p.type_id = t.id
where t.name = 'СЫР'
order by p.price DESC;

--2 запрос получения всех продуктов, у кого в имени есть слово "мороженое"--

select t.name, p.type_id, p.name, p.price, p.expired_date
from product as p
join type as t
on p.type_id = t.id
where p.name like '%Мороженное%'
order by p.price ASC;

--3 запрос, который выводит все продукты, срок годности которых уже истек--

select t.name, p.type_id, p.name, p.price, p.expired_date
from product as p
join type as t
on p.type_id = t.id
where p.expired_date < 'TODAY'
order by p.expired_date ASC;

--4 запрос, который выводит самый дорогой продукт--
select MAX(price) from product;

select p.name, p.price, p.expired_date from product as p
 where price = (select MAX(price) from product);

--5 запрос, выводит для каждого типа количество продуктов--
--к нему принадлежащих. В виде имя_типа, количество--

select t.name, count(p.id)
from product as p
join type as t
on p.type_id = t.id
group by t.name
order by count(p.id) DESC;

--6 запрос получение всех продуктов с типом "СЫР" и "ЧАЙ"--

select t.name, p.name
from product as p
join type as t
on p.type_id = t.id
where t.name IN ('СЫР', 'ЧАЙ')
group by t.name, p.name;

--7 запрос выводит тип продуктов, которых осталось меньше 10 штук.
--Под количеством подразумевается количество продуктов определенного типа--

select t.name, COUNT(p.id)  from product as p
join type as t
on p.type_id = t.id
group by t.name
having COUNT(p.id) < 10
order by COUNT(p.id) DESC;

--8 запрос, все типы и продукты--
select t.name, p.name from product as p
join type as t
on p.type_id = t.id;