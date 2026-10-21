/*
ISYS2014 - DATABASE SYSTEM
RAIHAN KHALIL ABDILLAH
17900375
FRIDAY 10AM
*/

#a. IMPLEMENTATION
#writes SQL scrips to implement the database, including all required tables and constraints, with appropriate referential integrity constraints.
#first, create a database named <lastname>_<studentid> and then implement all required tables within this database.

DROP DATABASE IF EXISTS abdillah_17900375;
CREATE DATABASE	abdillah_17900375;
USE abdillah_17900375;

-- create user table;
DROP TABLE IF EXISTS Users;
CREATE TABLE Users(
	user_id CHAR(3) NOT NULL,
	location VARCHAR(20),
	age INT(2) NOT NULL,
	PRIMARY KEY(user_id)
);

show columns from Users;

-- create tourism_with_id table;
DROP TABLE IF EXISTS Tourism_with_id;
CREATE TABLE Tourism_with_id(
	place_id CHAR(3) NOT NULL,
	place_name VARCHAR(20),
	description VARCHAR(500),
	city VARCHAR(12),
	price INT(9) NOT NULL,
	rating DECIMAL(1,1),
	time_minutes INT(4),
	lat DECIMAL(3,3),
	longi DECIMAL(3,3),
	PRIMARY KEY(place_id)
);
-- rating should be aggregated, might be changed later
-- latitude and longitude must be truncated because of m>=d in decimal

show columns from Tourism_with_id;

-- create package_tourism table;

DROP TABLE IF EXISTS Package_tourism;
CREATE TABLE Package_tourism(
	package CHAR(3) NOT NULL,
	city VARCHAR(12) NOT NULL,
	place_tourism1 VARCHAR(20),
	place_tourism2 VARCHAR(20),
	place_tourism3 VARCHAR(20),
	place_tourism4 VARCHAR(20),
	place_tourism5 VARCHAR(20),
	PRIMARY KEY(package),
	FOREIGN KEY(place_tourism1, place_tourism2, place_tourism3, place_tourism4, place_tourism5) REFERENCES Tourism_with_id(place_name, place_name, place_name, place_name, place_name)
);

/*
DROP TABLE IF EXISTS Package_tourism;
CREATE TABLE Package_tourism(
	package CHAR(3) NOT NULL,
	city VARCHAR(12) NOT NULL,
	place_tourism1 char(3),
	place_tourism2 char(3),
	place_tourism3 char(3),
	place_tourism4 char(3),
	place_tourism5 char(3),
	PRIMARY KEY(package),
	FOREIGN KEY(place_tourism1, place_tourism2, place_tourism3, place_tourism4, place_tourism5) REFERENCES Tourism_with_id(place_id, place_id, place_id, place_id, place_id)
);

*/

-- got error here, needs to fix. MIGHT HAVE TO REVAMP THE ER DIAGRAM
show columns from Package_tourism;

-- create tourism_rating table;
DROP TABLE IF EXISTS Tourism_rating;
CREATE TABLE Tourism_rating(
	user_id CHAR(3) NOT NULL,
	place_id CHAR(3) NOT NULL,
	place_ratings TINYINT,
	PRIMARY KEY(user_id, place_id),
	FOREIGN KEY(user_id) REFERENCES Users(user_id) ON DELETE CASCADE,
	FOREIGN KEY(place_id) REFERENCES Tourism_with_id(place_id) ON DELETE CASCADE
);

show columns from Tourism_rating;

	
	
	

