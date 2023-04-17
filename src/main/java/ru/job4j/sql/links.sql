create table owners(
	passport TEXT primary key,
	name TEXT,
	adress TEXT,
	pts TEXT
);
create table cars(
	pts TEXT primary key,
	owner_passport TEXT references owners(passport),
	vin TEXT,
	model TEXT,
	color TEXT
);
select * from cars;
select * from owners;
create table dna(
	code TEXT primary key,
	src TEXT,
	date DATE
);
create table person(
	passport TEXT primary key,
	name TEXT,
	adress TEXT,
	dna_code TEXT references dna(code) unique
);

create table countries(
	id INT primary key,
	name TEXT,
	alliance BOOL
);
create table sanctions(
	package_id INT primary key,
	issued DATE,
	reason TEXT
);
create table sanctioned_countries(
	id INT primary key,
	country_id INT references countries(id),
	package_id INT references sanctions(package_id)
);
select * from sanctioned_countries;