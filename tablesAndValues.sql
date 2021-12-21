-- Q1 - creating tables:


-- team -- 
create table team (
	tid integer primary key,
	nickname varchar(20),
	color varchar(10)
);

-- player -- 
create table player (
	pid integer primary key,
	pname varchar(20),
	adress varchar(30),
	phone numeric(10,0),
	rating integer,
	tid integer,
	foreign key(tid) references team
);

-- coach --
create table coach (
	cid integer primary key,
	cname varchar(20),
	adress varchar(30),
	phone numeric(10,0),
	status integer,
	tid integer,
	foreign key(tid) references team
);

-- game --
create table game (
	gdate date,
	htid integer,
	vtid integer,
	hscore integer,
	vscore integer,
	primary key(gdate, htid),
	foreign key(htid, vtid) references team
);

-- points --
create table points(
	pid integer,
	gdate date,
	htid integer,
	pscore integer,
	primary key(pid, gdate, htid),
	foreign key(pid) references player,
	foreign key(gdate, htid) references game
);


---------------------------------------------------------------------
-- Q3 - inserting values to tables:


-- team --
insert into team values
(1, 'a team', 'red'),
(2, 'dream team', 'blue'),
(3, 'rebels', 'blue'),
(4, 'warriors', 'green');

-- player --
insert into player values
(99, 'omri b', 'road 1', 0504770117, 1, 4),
(88, 'noam w', 'road 2', 234567890, 6, 2),
(77, 'tal w', 'road 3', 345678901, 4, 3),
(66, 'yossi b', 'road 4', 456789012, 5, 1),
(44, 'sarit b', 'road 6', 678901234, 3, 4),
(33, 'ortal b', 'road 7', 890123456, 2, 1);

-- coach --
insert into coach values
(23, 'reuven b', 'road 12', 987654321,0, 4),
(45, 'hani b', 'road 13', 876543219,1, 1),
(67, 'itzik w', 'road 14', 765432198,1, 2),
(89, 'orly w', 'road 15', 543421876,0, 3);

-- game --
insert into game values
('24/10/2021',1,2,3,2),
('25/10/2021',1,3,1,1),
('26/10/2021',2,1,4,4),
('27/10/2021',2,4,3,1),
('28/10/2021',3,2,4,5),
('31/10/2021',3,4,4,1),
('1/11/2021',4,1,4,1),
('2/11/2021',4,2,2,6);

-- points --
insert into points values
(88, '24.10.2021', 1, 16),
(88, '26.10.2021', 2, 20),
(99, '27.10.2021', 2, 13),
(44, '27.10.2021', 2, 20),
(44, '31.10.2021', 3, 25),
(44, '1.11.2021', 4, 12),
(99, '2.11.2021', 4, 7),
(44, '2.11.2021', 4, 34),
(88, '2.11.2021', 4, 11);

