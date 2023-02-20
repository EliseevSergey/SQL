create table devices(
    id serial primary key,
    name varchar(255),
    price float
);

create table people(
    id serial primary key,
    name varchar(255)
);

create table devices_people(
    id serial primary key,
    device_id int references devices(id),
    people_id int references people(id)
);

insert into devices (name, price) values ('laptop', 6000.5);
insert into devices (name, price) values ('headphones', 8000.5);
insert into devices (name, price) values ('iPhone', 4000.5);
insert into devices (name, price) values ('servachok', 16000.5);
insert into devices (name, price) values ('dryer', 1080.5);
insert into devices (name, price) values ('fen', 6000.5);
select * from devices;

insert into people (name) values ('Kobayashi-san');
insert into people (name) values ('mr.Smith');
insert into people (name) values ('Kolobkov');
insert into people (name) values ('Zarzhavelli');
select * from people;

insert into devices_people (device_id, people_id) values (1,1);
insert into devices_people (device_id, people_id) values (2,1);
insert into devices_people (device_id, people_id) values (3,2);
insert into devices_people (device_id, people_id) values (4,2);
insert into devices_people (device_id, people_id) values (5,3);
insert into devices_people (device_id, people_id) values (6,4);
select * from devices_people;

-average device price-
select avg(price) from devices;

-average device price for staff-
select p.name, avg(price) from devices_people as dp
join devices as d on d.id = dp.device_id
join people as p on p.id = dp.people_id
group by p.name;

-average price above 5000 for staff devices-
select p.name, avg(price) from devices_people as dp
join devices as d on d.id = dp.device_id
join people as p on p.id = dp.people_id
group by p.name having avg(price) > 5000;