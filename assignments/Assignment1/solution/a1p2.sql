-- We delete the tables if they exists (optional)
drop table if exists reviews;
drop table if exists enroute;
drop table if exists requests;
drop table if exists bookings;
drop table if exists rides;
drop table if exists cars;
drop table if exists locations;
drop table if exists drivers;
drop table if exists members;

PRAGMA foreign_keys = ON;

-- We will now create the tables
create table members (
  email 	char(15),
  name		char(20),
  phone 	char(12),
  primary key (email) 
);

create table drivers (
  email 	char(15),
  licNo 	char(8),
  primary key (email),
  foreign key (email) references members
    on delete cascade
);

create table locations (
  lcode 	char(6),
  city 		char(15),
  prov 		char(15),
  address 	char(20),
  primary key (lcode)
);

create table cars (
  cno 		char(6),
  make 		char(12),
  model 	char(12),
  year 		int,
  seats 	int,
  gdate 	date,
  owner 	char(15) not null,
  primary key (cno),
  foreign key (owner) references drivers
);

create table rides (
  rno 		char(6),
  price 	real,
  rdate 	date,
  seats 	int,
  lugDesc 	char(12),
  src 		char(6) not null,
  dst 		char(6) not null,
  driver 	char(15) not null,
  cno 		char(6),
  primary key (rno),
  foreign key (src) references locations,
  foreign key (dst) references locations,
  foreign key (driver) references drivers,
  foreign key (cno) references cars
);

create table bookings (
  bno 		char(6),
  seats 	int,
  cost 		real,
  isFor 	char(6) not null,
  dropOff 	char(6),
  pickUp 	char(6),
  reservedby 	char(15) not null,
  primary key (bno),
  foreign key (isFor) references rides,
  foreign key (dropOff) references locations,
  foreign key (pickUp) references locations,
  foreign key (reservedby) references members
);

create table requests (
  member 	char(15),
  pickUp 	char(6),
  dropOff 	char(6),
  qdate 	date,
  amount 	real,
  primary key (member, pickUp, dropOff),
  foreign key (member) references members,
  foreign key (pickUp) references locations,
  foreign key (dropOff) references locations
);

create table enroute (
  rno 		char(6),
  location 	char(6),
  primary key (rno, location),
  foreign key (rno) references rides,
  foreign key (location) references locations
);

create table reviews (
  rid 		char(6),
  rdate 	date,
  rtext 	char(30),
  rscore 	int,
  reviewer 	char(15) not null,
  reviewee 	char(15) not null,
  ride 		char(6),
  primary key (rid),
  foreign key (reviewer) references members,
  foreign key (reviewee) references members,
  foreign key (ride) references rides
);

