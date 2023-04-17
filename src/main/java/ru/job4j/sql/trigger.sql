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

--PROCEDURE AND INTERNAL FUNCTIONS
--PROCEDURE
create or replace procedure insert_data(i_name varchar, prod varchar, i_count integer, i_price integer)
language 'plpgsql'
as $$
    BEGIN
    insert into products (name, producer, count, price)
    values (i_name, prod, i_count, i_price);
    END
$$;

call insert_data('product_2', 'producer_2', 15, 32);
call insert_data('product_3', 'producer_3', 30, 100);
call insert_data('product_0', 'producer_0', 0, 0);

create or replace procedure update_data(u_count integer, tax float, u_id integer)
language 'plpgsql'
as $$
    BEGIN
        if u_count > 0 THEN
            update products set count = count - u_count where id = u_id;
        end if;
        if tax > 0 THEN
            update products set price = price + price * tax;
        end if;
    END;
$$;
call insert_data('product_1', 'producer_1', 3, 50);
call insert_data('product_3', 'producer_3', 8, 115);
call update(1, 0.2, 41);

alter procedure update_data(u_count integer, tax float, u_id integer) rename to update;

delete from products;
ALTER SEQUENCE products_id_seq RESTART WITH 1;


---FUNCTIONS---
create or replace function f_insert_data(i_name varchar, prod varchar, i_count integer, i_price integer)
returns void
language 'plpgsql'
as
$$
    begin
        insert into products (name, producer, count, price)
        values (i_name, prod, i_count, i_price);
    end;
$$;

select f_insert_data('product_1', 'producer_1', 25, 50);

select * from products
order by id DESC;

create or replace function f_update_data(u_count integer, tax float, u_id integer)
returns integer
language 'plpgsql'
as
$$
    declare
        result integer;
    begin
        if u_count > 0 THEN
            update products set count = count - u_count where id = u_id;
            select into result count from products where id = u_id;
        end if;
        if tax > 0 THEN
            update products set price = price + price * tax;
            select into result sum(price) from products;
        end if;
        return result;
    end;
$$;

select f_update_data(10, 0, 1);
select f_insert_data('product_2', 'producer_2', 15, 32);
select f_insert_data('product_3', 'producer_3', 8, 115);
select f_update_data(0, 0.2, 0);

----------------------------------------------------------
-------------------HOMEWORK-------------------------------
--1) DELETION PROCEDURE with ID

create or replace procedure delete_data(d_id integer)
language 'plpgsql'
as $$
    BEGIN
    delete from products where id = d_id;
    END;
$$;

call delete_data(8);

--2) DELETION PROCEDURE based on zero quantity

create or replace procedure delete_data_zero()
language 'plpgsql'
as $$
    BEGIN
    delete from products where count = 0;
    END;
$$;

call delete_data_zero();

--3) FUNCTION for deletion based on id

create or replace function delete_with_id(id_del integer)
returns void
language 'plpgsql'
as
$$
    begin
       delete from products where id = id_del;
    end;
$$;

select delete_with_id(1);

--4) FUNCTION for deletion based on qty

create or replace function delete_with_zero()
returns void
language 'plpgsql'
as
$$
    begin
       delete from products where count = 0;
    end;
$$;

select delete_with_zero();