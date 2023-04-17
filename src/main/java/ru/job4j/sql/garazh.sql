create table bodies (
id serial primary key,
name TEXT);

create table engines (
id serial primary key,
name TEXT);

create table transmissions (
id serial primary key,
name TEXT);

create table cars (
id serial primary key,
name TEXT,
body_id INT references bodies(id),
engine_id INT references engines(id),
transmission_id INT references transmissions(id));

insert into bodies(name) values ('Sedan');
insert into bodies(name) values ('SUV');
insert into bodies(name) values ('Universal');
insert into bodies(name) values ('Liftback');
insert into bodies(name) values ('Roadster');
insert into bodies(name) values ('Monobody');

insert into engines(name) values ('V8');
insert into engines(name) values ('V12');
insert into engines(name) values ('V6');
insert into engines(name) values ('V10');
insert into engines(name) values ('R4');
insert into engines(name) values ('NeverUsedEngine');

insert into transmissions(name) values ('MT8');
insert into transmissions(name) values ('MT12');
insert into transmissions(name) values ('AT6');
insert into transmissions(name) values ('MT10');
insert into transmissions(name) values ('RB4');

insert into cars (name, body_id, transmission_id, engine_id) values ('Logan', 1, 5, 5);
insert into cars (name, body_id, transmission_id, engine_id) values ('Caterhem', 5, 2, 2);
insert into cars (name, body_id, transmission_id, engine_id) values ('Shniva', 2, 3, 3);
insert into cars (name, body_id, transmission_id, engine_id) values ('Prototype', 4, null, 2);
insert into cars (name, body_id, transmission_id, engine_id) values ('Project', null, 2, 2);
insert into cars (name, body_id, transmission_id, engine_id) values ('GAZ', null, null, 5);

--1. Вывести список всех машин и все привязанные детали
select c.id as car_id, c.name as car, c.body_id, b.name as body_name,
transmission_id, t.name as transmission,  engine_id, e.name as engine from cars as c
left join bodies as b on c.body_id = b.id
left join engines as e on c.engine_id = e.id
left join transmissions as t on c.transmission_id = t.id
;

--2. Вывести кузова, которые не используются НИ в одной машине
select b.id, b.name from bodies as b left join cars as c on c.body_id = b.id
where c.body_id is null;

--3. Вывести двигатели, которые не используются НИ в одной машине
select e.id, e.name from engines as e left join cars as c on c.engine_id = e.id
where c.engine_id is null;

--4. Вывести коробки, которые не используются НИ в одной машине
select t.id, t.name from cars as c right join transmissions as t on c.transmission_id = t.id
where c.transmission_id is null;
