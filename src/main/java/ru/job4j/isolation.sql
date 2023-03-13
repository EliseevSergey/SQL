create table cellphones (
id serial primary key,
brand TEXT,
model TEXT,
price INT,
qty INT);

insert into cellphones (brand, model, price, qty) values ('Nokia', '6230', 200, 9);
insert into cellphones (brand, model, price, qty) values ('Siemens', 'A52', 100, 4);
insert into cellphones (brand, model, price, qty) values ('Ericson', 'T100', 400, 13);
select * from cellphones;

set session characteristics as transaction isolation level serializable;
BEGIN;
insert into cellphones (brand, model, price, qty) values ('Added_for_further_Rollback', 'rollbacker', 100, 4);

select * from cellphones;

savepoint first_save;
select * from cellphones;

insert into cellphones (brand, model, price, qty) values ('Added_for_further_Rollback2', 'rollbacker',  400, 13);
insert into cellphones (brand, model, price, qty) values ('Added_for_further_Rollback2', 'rollbacker',  400, 13);
insert into cellphones (brand, model, price, qty) values ('Added_for_further_Rollback2', 'rollbacker',  400, 13);

savepoint second_save;
select * from cellphones;
delete from cellphones where brand = 'rollbacker';
select * from cellphones;

savepoint second_save;
select * from cellphones;

rollback to savepoint second_save;
select * from cellphones;
delete from cellphones;

release first_save;
release second_save;
commit;
