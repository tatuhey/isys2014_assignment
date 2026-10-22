/*
ISYS2014 - DATABASE SYSTEM
RAIHAN KHALIL ABDILLAH
17900375
FRIDAY 10AM
*/

#PART4

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

        INSERT INTO location(city_id, city_name, province)
            VALUES(nxctid, ctname, prv);
        INSERT INTO users(user_id, fk_city_id, age)
            VALUES(nxuserid, nxctid, age);


    END
//
DELIMITER ;

CALL insNewUser(30, 'Denpasar', 'Bali');



DROP PROCEDURE IF EXISTS checkUserDomicile;
DELIMITER //
CREATE PROCEDURE checkUserDomicile(
        IN usrid CHAR(3)
)
    COMMENT 'Call procedure with user_id, receive city and province information,'
    BEGIN

        SELECT  l.city_name AS city_name,
                l.province AS province
        FROM users AS u
        JOIN location AS l
            ON u.fk_city_id = l.city_id
        WHERE u.user_id = usrid;
        
    END
//
DELIMITER ;

CALL checkUserDomicile(1);