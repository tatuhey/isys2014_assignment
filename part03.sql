/*
ISYS2014 - DATABASE SYSTEM
RAIHAN KHALIL ABDILLAH
17900375
FRIDAY 10AM
*/

#PART3

-- show count of users not from jakarta
SELECT  l.province AS province,
        COUNT(u.user_id) AS user_count_not_from_JKT
FROM location AS l
INNER JOIN users AS u
    ON u.fk_city_id = l.city_id
WHERE province != 'DKI Jakarta'
GROUP BY province
ORDER BY user_count_not_from_JKT DESC;

-- show which city/regency as the most tourist attraction
SELECT  l.city_name AS city_or_regency,
        COUNT(t.place_id) no_of_attraction
FROM location AS l
INNER JOIN tourism AS t
    ON l.city_id = t.fk_city_id
GROUP BY city_or_regency
ORDER BY no_of_attraction DESC;

-- show which city/regency provides most free to enter tourist attraction
SELECT  l.city_name AS city_or_regency,
        COUNT(t.place_id) AS no_of_free_attraction
FROM location AS l
INNER JOIN tourism AS t
    ON l.city_id = t.fk_city_id
WHERE t.price = 0
GROUP BY city_or_regency
ORDER BY no_of_free_attraction DESC;

-- Show all tourist attraction that is free to enter everywhere
SELECT  t.place_id, 
        t.place_name AS name, 
        c.category_name AS category,
        l.province AS province
FROM tourism AS t
INNER JOIN tour_category AS c
    ON t.fk_category_id = c.category_id
INNER JOIN location AS l
    ON t.fk_city_id = l.city_id
    WHERE price = 0
ORDER BY t.place_id;

-- show which province provides most free to enter tourist attraction
SELECT  l.province AS province,
        COUNT(t.place_id) AS no_of_free_places
FROM location AS l
INNER JOIN tourism AS t
    ON l.city_id = t.fk_city_id
WHERE t.price = 0
GROUP BY province
ORDER BY no_of_free_places DESC;

-- show all tourist attraction with rating aggregate
SELECT  r.place_id,
        t.place_name AS name,
        AVG(r.rating) AS rating,
        l.city_name AS city_regency,
        l.province AS province
        -- COUNT(r.rating) AS rating_count
FROM tour_rating AS r
INNER JOIN tourism AS t
    ON r.place_id = t.place_id
INNER JOIN location AS l
    ON t.fk_city_id = l.city_id
GROUP BY r.place_id
ORDER BY rating DESC;

-- show which province has best rated tourist attraction
SELECT  l.province AS province,
        AVG(r.rating) AS avg_rating
FROM location AS l
INNER JOIN tourism AS t
    ON l.city_id = t.fk_city_id
INNER JOIN tour_rating AS r
    ON r.place_id = t.place_id
GROUP BY province;
ORDER BY avg_rating DESC;



-- aggregate the total cost for each tour package, its average rating and time to be spent
SELECT  pp.package_id,
        pp.total_price,
        rr.avg_rating,
        mm.total_hour
FROM (
    SELECT  p.package_id ,
        SUM(t.price) AS total_price
    FROM tour_package AS p
    INNER JOIN tourism AS t
        ON p.fk_place_id = t.place_id
    GROUP BY p.package_id
    ) AS pp
INNER JOIN (
    SELECT  pp.package_id,
        AVG(rr.rating) AS avg_rating
    FROM tour_package AS pp
    INNER JOIN tour_rating AS rr
        on pp.fk_place_id = rr.place_id
    GROUP BY pp.package_id
    ) AS rr
    ON pp.package_id = rr.package_id
INNER JOIN (
    SELECT p.package_id,
        SUM(t.time_minute) / 60 AS total_hour           -- need to be casted as time
    FROM tour_package AS p
    INNER JOIN tourism AS t
        ON p.fk_place_id = t.place_id
    GROUP BY p.package_id
    ) AS mm
    ON pp.package_id = mm.package_id
GROUP BY pp.package_id;

-- show all tourist attraction, that west javan visited
SELECT  a.user_id AS user_id,
        a.age AS age,
        a.domicile AS domicile,
        b.place_id AS place_id,
        b.name AS attraction_name,
        b.province AS province
FROM
    (SELECT u.user_id AS user_id,
            u.age AS age,
            CONCAT(l.city_name, ', ', l.province) AS domicile,
            r.place_id
    FROM users AS u
    INNER JOIN location AS l
        ON u.fk_city_id = l.city_id
    INNER JOIN tour_rating AS r
        ON u.user_id = r.user_id
    WHERE l.province = 'West Java') AS a
INNER JOIN                               -- right outer join will sort this by place_id 
    (SELECT t.place_id AS place_id,
            t.place_name AS name,
            l.province AS province
    FROM tourism AS t
    INNER JOIN location AS l
        ON t.fk_city_id = l.city_id) AS b
    ON a.place_id = b.place_id
ORDER BY b.place_id;