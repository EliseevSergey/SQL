create table cars(
	pts CHAR(50) primary key,
	vin CHAR(50),
	model CHAR(50),
	color CHAR(50)
);
create table owners(
	passport CHAR(50) primary key,
	name CHAR(50),
	adress CHAR(100),
	pts CHAR(50),
	cars_pts CHAR(50) references cars(pts)
);

select * from cars;
select * from owners;

create table dna(
	code CHAR(50) primary key,
	src CHAR(50),
	date DATE
);
create table person(
	passport CHAR(50) primary key,
	name CHAR(50),
	adress CHAR(100),
	dna_code CHAR(50) references dna(code) unique
);

create table countries(
	id CHAR(50) primary key,
	name CHAR(50),
	alliance BOOL
);
create table sanctions(
	package_id CHAR(50) primary key,
	issued DATE,
	reason CHAR(100)
);
create table sanctioned_countries(
	id CHAR(50) primary key,
	country_id CHAR(50) references countries(id),
	package_id CHAR(50) references sanctions(package_id)
);

select * from sanctioned_countries;