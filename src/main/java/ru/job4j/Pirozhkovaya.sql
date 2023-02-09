create table pirozhki(
id serial primary key,
	title CHAR(100),
	weight SMALLINT,
	vegan BOOL,
	price SMALLINT,
	prod_date DATE
);
insert into pirozhki(title, weight, vegan, price, prod_date) 
values('Energon', 300, false, 100, '2023-02-08');
insert into pirozhki(title, weight, vegan, price, prod_date) 
values('GreenPiace', 200, true, 50, '2023-02-07');
insert into pirozhki(title, weight, vegan, price, prod_date) 
values('Kanibal', 400, false, 200, '2023-01-01');
update pirozhki set price = 666;
select * from pirozhki;
delete from pirozhki;
select * from pirozhki;
