/*
ISYS2014 - DATABASE SYSTEM
RAIHAN KHALIL ABDILLAH
17900375
FRIDAY 10AM
*/

#b. LOADING SAMPLE DATABASE
#insert sample data into the implemented database;
#may use SQL script;

USE abdillah_17900375;

-- load new_location.csv to location table;
LOAD DATA LOCAL
    INFILE 'new_location.csv'
    INTO TABLE location
    FIELDS TERMINATED BY ',' ENCLOSED BY '"'
    LINES TERMINATED BY '\n'
    IGNORE 1 ROWS;

-- load new_tour_category.csv to tour_category table
LOAD DATA LOCAL
    INFILE 'new_tour_category.csv'
    INTO TABLE tour_category 
    FIELDS TERMINATED BY ',' ENCLOSED BY '"'
    LINES TERMINATED BY '\n'
    IGNORE 1 ROWS;

-- load new_user.csv to table users
LOAD DATA LOCAL
    INFILE 'new_user.csv'
    INTO TABLE users
    FIELDS TERMINATED BY ',' ENCLOSED BY '"'
    LINES TERMINATED BY '\n'
    IGNORE 1 ROWS;

-- load new_tourism.csv to toursim table;
LOAD DATA LOCAL
   INFILE 'new_tourism.csv'
   INTO TABLE tourism
   FIELDS TERMINATED BY ',' ENCLOSED BY '"'
   LINES TERMINATED BY '\n'
   IGNORE 1 ROWS;

-- load new_tour_package.csv to tour_package table;
LOAD DATA LOCAL
    INFILE 'new_tour_package.csv'
    INTO TABLE tour_package
    FIELDS TERMINATED BY ',' ENCLOSED BY '"'
    LINES TERMINATED BY '\n'
    IGNORE 1 ROWS;

-- truncate table tour_package;
-- select count(*) from tour_package;

-- load new_tourism_rating.csv to tour_rating table;
LOAD DATA LOCAL
    INFILE 'new_tourism_rating.csv'
    INTO TABLE tour_rating
    FIELDS TERMINATED BY ',' ENCLOSED BY '"'
    LINES TERMINATED BY '\n'
    IGNORE 1 ROWS;


-- show warnings limit 20;
-- truncate table tour_rating;
-- select count(*) from tour_package;