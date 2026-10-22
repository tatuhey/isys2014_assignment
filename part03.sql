/*
ISYS2014 - DATABASE SYSTEM
RAIHAN KHALIL ABDILLAH
17900375
FRIDAY 10AM
*/

#PART3
-- Show all tourist place that is free to enter everywhere
SELECT  t.place_id, 
        t.place_name AS name, 
        c.category_name AS category,
        l.province AS province
FROM tourism AS t
JOIN tour_category AS c
    ON t.fk_category_id = c.category_id
JOIN location AS l
    ON t.fk_city_id = l.city_id
    WHERE price = 0
ORDER BY t.place_id;

-- show all tourist attraction with rating aggregate
SELECT  r.place_id,
        t.place_name AS name,
        AVG(r.rating) AS rating,
        l.city_name AS city_regency,
        l.province AS province
        -- COUNT(r.rating) AS rating_count
FROM tour_rating AS r
JOIN tourism AS t
    ON r.place_id = t.place_id
JOIN location AS l
    ON t.fk_city_id = l.city_id
GROUP BY r.place_id
ORDER BY rating DESC;

-- show which province has best rated tourist attraction
SELECT  l.province AS provice,
        AVG(r.rating) AS avg_rating
FROM location AS l
JOIN tourism AS t
    ON l.city_id = t.fk_city_id
JOIN tour_rating AS r
    ON r.place_id = t.place_id
GROUP BY province;

-- aggregate the total cost for each tour package and its average rating
/*
SELECT  p.package_id ,
        SUM(t.price) AS total_price
FROM tour_package AS p
JOIN tourism AS t
    ON p.fk_place_id = t.place_id
GROUP BY p.package_id;

SELECT  pp.package_id,
        AVG(rr.rating) AS avg_rating
FROM tour_package AS pp
JOIN tour_rating AS rr
    on pp.fk_place_id = rr.place_id
GROUP BY pp.package_id;
*/

SELECT  pp.package_id,
        pp.total_price,
        rr.avg_rating
FROM (
    SELECT  p.package_id ,
        SUM(t.price) AS total_price
    FROM tour_package AS p
    JOIN tourism AS t
        ON p.fk_place_id = t.place_id
    GROUP BY p.package_id
    ) AS pp
JOIN (
    SELECT  pp.package_id,
        AVG(rr.rating) AS avg_rating
    FROM tour_package AS pp
    JOIN tour_rating AS rr
        on pp.fk_place_id = rr.place_id
    GROUP BY pp.package_id
    ) AS rr
    ON pp.package_id = rr.package_id;