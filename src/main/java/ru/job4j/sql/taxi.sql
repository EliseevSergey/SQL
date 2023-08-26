create table driver(
    id INT primary key,
    first_name TEXT,
    last_name TEXT,
    birth_date DATE
);
insert into driver (id, first_name, last_name, birth_date) values (1, 'Petya', 'Petrov', '1988-01-01'),
(2, 'Sidr', 'Sidorov', '1988-02-02'), (3, 'Ivan', 'Ivanov', '1988-03-03'), (4, 'Alex', 'Alexeev', '1988-04-04'),
(5, 'Nik', 'Nikolaev', '1988-05-05');

select * from car;
select * from driver;

create table car(
    id INT primary key,
    brand TEXT,
    manufacturing_year INT,
    mileage INT
);

insert into car (id, brand, manufacturing_year, mileage) values (1, 'Vaz', '2000', '1000'),
(2, 'Vaz', '2000', '1100'), (3, 'Uaz', '2002', '2002'), (4, 'Toyota', '2005', '3000'),
(5, 'Toyota', '2006', '4000'), (6, 'Toyota', '2007', '6000'), (7, 'Toyota', '2008', '7000'),
(8, 'Toyota', '2023', '100'), (9, 'Bmw', '2008', '55000'), (10, 'Nissa', '2008', '111');

create table car_driver(
    id INT primary key,
    car_id INT references car(id),
    driver_id INT references driver(id)
);

select * from car_driver;

insert into car_driver (id, car_id, driver_id) values (1, 1, 1), (2, 4, 1), (3, 3, 1),
(4, 2, 2), (5, 1, 2), (6, 4, 2), (7, 5, 3), (8, 6, 3), (9, 7, 3), (10, 8, 3), (11, 9, 3),
(12, 10, 4), (13, 7, 4), (14, 10, 5), (15, 10, 1);

insert into car_driver (id, car_id, driver_id) values (16, 5, 4);


select * from car_driver;

select * from car_driver as cd join driver as d on cd.driver_id = d.id
join car as c on cd.car_id = c.id;

-- выбирает всех водителей у кого два и более авто
select d.last_name from driver as d
join car_driver as cd on cd.driver_id = d.id
join car as c on c.id = cd.car_id
group by d.last_name having count(cd.car_id) > 2;

-- выбирает  три столбика (все фамилии водителей, бренд, количество) у кого два и более авто Toyota

SELECT d.last_name, c.brand, count(cd.car_id) FROM driver AS d
JOIN car_driver AS cd ON d.id = cd.driver_id
JOIN car AS c ON c.id = cd.car_id
GROUP BY d.last_name, c.brand HAVING count(cd.car_id) >= 2 AND c.brand = 'Toyota';

-- выбирает  один столбик фамилии у  кого два и более авто Toyota
SELECT d.last_name FROM driver AS d
JOIN car_driver AS cd ON d.id = cd.driver_id
JOIN car AS c ON c.id = cd.car_id
GROUP BY d.last_name, c.brand HAVING count(cd.car_id) >= 2 AND c.brand = 'Toyota';

