/*
ISYS2014 - DATABASE SYSTEM
RAIHAN KHALIL ABDILLAH
17900375
FRIDAY 10AM
*/

#PART4
-- create procedure to do count of users in the table;
DROP PROCEDURE IF EXISTS checkUserCount;
DELIMITER //
CREATE PROCEDURE checkUserCount()

    COMMENT 'Call procedure, output count of user in the table users'
    BEGIN
        SELECT COUNT(user_id) AS no_of_user
        FROM users;
    END
//
DELIMITER ;

CALL checkUserCount();

-- create procedure to check what city does the user live in
DROP PROCEDURE IF EXISTS checkUserDomicile;
DELIMITER //
CREATE PROCEDURE checkUserDomicile(
    IN usrid CHAR(3)
)
    COMMENT 'Call procedure with user_id, receive city and province information,'
    BEGIN

        SELECT  CONCAT(l.city_name, ', ', l.province) AS user_domicile
        FROM users AS u
        INNER JOIN location AS l
            ON u.fk_city_id = l.city_id
        WHERE u.user_id = usrid;
        
    END
//
DELIMITER ;

CALL checkUserDomicile('253');

-- create procedure to check whether city already exists in the location table
DROP PROCEDURE IF EXISTS checkCity;
DELIMITER //
CREATE PROCEDURE checkCity(
    IN cityname VARCHAR(20)
)
    COMMENT 'Call procedure with city_name, receieve output whether city is in the database or not.'
    BEGIN
        DECLARE cityCount INT DEFAULT 0;
        SELECT COUNT(l.city_name) INTO cityCount
        FROM location AS l
        WHERE l.city_name = cityname;

        IF cityCount > 0 then
            SELECT CONCAT('City and/or regency ', cityname, ' exists in the database.') AS result;
        ELSE
            SELECT CONCAT('City and/or regency ', cityname, ' does not exists in the database.') AS result;
        END IF;
    END
//
DELIMITER ;

CALL checkCity('Depok');
CALL checkCity('Sukabumi');

-- create stored procedure to add new users to the database
DROP PROCEDURE IF EXISTS insNewUser;
DELIMITER //
CREATE PROCEDURE insNewUser(
    age int(2),
    ctname VARCHAR(20),
    prv VARCHAR(20)
)
    COMMENT 'Insert new user into the table users AND their locaiton to table location.'
    BEGIN
        DECLARE nxuserid CHAR(3);
        DECLARE nxctid   CHAR(3);

        SELECT LPAD(MAX(user_id)+1, 3, '0') FROM users    INTO nxuserid; -- TO MAKE SURE THAT IDS ARE 3 DIGIT
        SELECT LPAD(MAX(city_id)+1, 3, '0') FROM location INTO nxctid;   -- TO HAVE LEADING 0 IF NECESSARY

        SELECT city_name
        FROM location
        WHERE city_name = ctname;

        INSERT INTO location(city_id, city_name, province)
            VALUES(nxctid, ctname, prv);
        INSERT INTO users(user_id, fk_city_id, age)
            VALUES(nxuserid, nxctid, age);

    END
//
DELIMITER ;

CALL insNewUser(30, 'Denpasar', 'Bali');

-- create trigger to count users after adding new user
DROP TRIGGER IF EXISTS after_users_insert;
DELIMITER //
CREATE TRIGGER after_users_insert
    AFTER INSERT ON users
    FOR EACH ROW
    BEGIN
        SELECT COUNT(user_id) INTO @user_count FROM users;
    END
//
DELIMITER ;

SELECT @user_count;

-- create view to see all tourist attractions in Jakarta
DROP VIEW IF EXISTS JakartaAttractions;
CREATE VIEW JakartaAttractions AS
    SELECT  t.place_id AS place_id, t.place_name AS place_name, l.city_name AS city_or_regency
    FROM    tourism AS t
    INNER JOIN location as l
    ON l.province = 'DKI Jakarta'
    AND t.fk_city_id = l.city_id
    ORDER BY place_id;

SELECT place_id, place_name, city_or_regency
    FROM JakartaAttractions;