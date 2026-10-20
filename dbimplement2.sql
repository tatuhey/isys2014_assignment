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


-- create location table;
DROP TABLE IF EXISTS location;
CREATE TABLE location(
    city_id CHAR(3) NOT NULL,
    city_name VARCHAR(20) NOT NULL,
    province VARCHAR(20) NOT NULL,
    PRIMARY KEY(city_id)
);

-- create tour_category table;
DROP TABLE IF EXISTS tour_category;
CREATE TABLE tour_category(
    category_id CHAR(3) NOT NULL,
    category_name VARCHAR(12) NOT NULL,
    PRIMARY KEY(category_id)
);

-- create user table;
DROP TABLE IF EXISTS users;
CREATE TABLE users(
    user_id CHAR(3) NOT NULL,
    fk_city_id CHAR(3) NOT NULL,
    age int(2),
    PRIMARY KEY(user_id),
    FOREIGN KEY(fk_city_id) REFERENCES location(city_id)
);

-- crate tourism table;
DROP TABLE IF EXISTS tourism;
CREATE TABLE tourism(
    place_id CHAR(3) NOT NULL,
    place_name VARCHAR(20) NOT NULL,
    description VARCHAR(500),
    fk_city_id CHAR(3) NOT NULL,
    fk_category_id CHAR(3) NOT NULL,
    avg_rating DECIMAL(1,1),
    time_minute int(4),
    latitude DECIMAL(3,3),
    longitude DECIMAL(3,3),
    PRIMARY KEY(place_id),
    FOREIGN KEY(fk_city_id) REFERENCES location(city_id),
    FOREIGN KEY(fk_category_id) REFERENCES tour_category(category_id)
);

-- create tour_package table;
DROP TABLE IF EXISTS tour_package;
CREATE TABLE tour_package(
    package_id CHAR(3) NOT NULL,
    fk_place_id CHAR(3) NOT NULL,
    sum_price INT(9),
    avg_rating DECIMAL(1,1),
    PRIMARY KEY(package_id),
    FOREIGN KEY(fk_place_id) REFERENCES tourism(place_id)
);

-- create tour_rating table;
DROP TABLE IF EXISTS tour_rating;
CREATE TABLE tour_rating(
    user_id CHAR(3) NOT NULL,
    place_id CHAR(3) NOT NULL,
    rating TINYINT NOT NULL,
	PRIMARY KEY(user_id, place_id),
	FOREIGN KEY(user_id) REFERENCES users(user_id) ON DELETE CASCADE,
	FOREIGN KEY(place_id) REFERENCES tourism(place_id) ON DELETE CASCADE
);

SHOW TABLES FROM abdillah_17900375;

SHOW COLUMNS FROM users;

SHOW COLUMNS FROM location;

SHOW COLUMNS FROM tour_category;

SHOW COLUMNS FROM tour_package;

SHOW COLUMNS FROM tour_rating;

SHOW COLUMNS FROM tourism;