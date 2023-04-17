CREATE TABLE customers(
    id serial primary key,
    first_name text,
    last_name text,
    age int,
    country text
);

insert into customers(first_name, last_name, age, country) values ('Maxim', 'Galkin', 40 , 'Russia');
insert into customers(first_name, last_name, age, country) values ('MC', 'Noize', 44 , 'Russia');
insert into customers(first_name, last_name, age, country) values ('Alla', 'Pugacheva', 65 , 'Russia');
insert into customers(first_name, last_name, age, country) values ('Mark', 'Edison', 50 , 'Israel');
insert into customers(first_name, last_name, age, country) values ('Toshimitsu', 'Itou', 24 , 'Japan');
insert into customers(first_name, last_name, age, country) values ('Maxim', 'Galkin', 40 , 'China');
insert into customers(first_name, last_name, age, country) values ('Tommy', 'Mayakinen', 70 , 'Finland');
insert into customers(first_name, last_name, age, country) values ('Tenzing', 'Norgei', 24 , 'Nepal');

select * from customers;

CREATE TABLE orders(
    id serial primary key,
    amount int,
    customer_id int references customers(id)
);

insert into orders (amount, customer_id) values (2, 1);
insert into orders (amount, customer_id) values (6, 3);
insert into orders (amount, customer_id) values (13, 5);
insert into orders (amount, customer_id) values (70, 7);

--запрос на клиентов с минимальным возрастом
select id, first_name, last_name, country, age  from customers where (age = (select min(age) from customers));

--запрос на список тех кто еще ничего не заказал
select id, first_name, last_name from customers where id not in (select customer_id from orders);