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

BEGIN transaction isolation level serializable;
select * from cellphones;
select sum(qty) from cellphones;
update cellphones set qty = 5000 where brand = 'Siemens';
COMMIT;