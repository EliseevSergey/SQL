create table products (
    id serial primary key,
    name varchar(50),
    producer varchar(50),
    count integer default 0,
    price integer
);

create or replace function discount()
    returns trigger as
$$
    BEGIN
        update products set price = price - price * 0.2
        where count <= 5 AND id = new.id;
        return NEW;
    END;
$$
LANGUAGE 'plpgsql';

create trigger discount_trigger
    after insert on products
    for each row
    execute procedure discount();

insert into products (name, producer, count, price)
VALUES ('product_3', 'producer_3', 8, 115);

insert into products (name, producer, count, price)
VALUES ('product_1', 'producer_1', 3, 100);

insert into products (name, producer, count, price)
VALUES ('product_3', 'producer_3', 666, 1000);

insert into products (name, producer, count, price)
VALUES ('product_4', 'producer_4', 777, 1000);

insert into products (name, producer, count, price)
VALUES ('product_5', 'producer_5', 888, 1000);

select * from products
order by id DESC;

create trigger tax_trigger
    after insert on products
    referencing new table as inserted
    for each statement
    execute procedure tax();

create or replace function tax()
    returns trigger as
$$
    BEGIN
        update products
        set price = price - price * 0.2
        where id = (select id from inserted) and count <= 5;
        return new;
    END;
$$
LANGUAGE 'plpgsql';


--1)  Триггер должен срабатывать после вставки данных, для любого товара и просто насчитывать
--налог на товар (нужно прибавить налог к цене товара). Действовать он должен не на каждый ряд,
--а на запрос (statement уровень)

create or replace function tax_add_statement()
    returns trigger as
$$
    BEGIN
        update products
        set price = price + 0.2 * price
        where id = (select id from inserted);
        return new;
    END;
$$
LANGUAGE 'plpgsql';

create trigger tax_adder_trigger
    after insert on products
    referencing new table as inserted
    for each statement
    execute procedure tax_add_statement();

--2) Триггер должен срабатывать до вставки данных и насчитывать налог на товар
--(нужно прибавить налог к цене товара). Здесь используем row уровень.

create or replace function tax_add_row()
    returns trigger as
$$
    BEGIN
        new.price = new.price + new.price * 0.3;
        return new;
    END;
$$
LANGUAGE 'plpgsql';

create trigger tax_adder_trigger_row
    before insert on products
    for each row
    execute procedure tax_add_row();

--3) Нужно написать триггер на row уровне, который при вставке продукта в таблицу products,
--будет заносить имя, цену и текущую дату в таблицу history_of_price.

create table history_of_price (
    id serial primary key,
    name varchar(50),
    price integer,
    date timestamp
);

create or replace function history_row()
    returns trigger as
$$
    BEGIN
        insert into history_of_price (name, price, date) values (new.name, new.price, now());
		return new;
    END;
$$
LANGUAGE 'plpgsql';

create trigger history_trigger_row
    after insert on products
    for each row
    execute procedure history_row();

select * from history_of_price;