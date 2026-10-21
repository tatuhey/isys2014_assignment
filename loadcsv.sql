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