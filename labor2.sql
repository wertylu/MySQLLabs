
-- 1
SELECT model,ram,price FROM laptop
WHERE ram = 64
ORDER BY screen desc;

-- 2
SELECT name FROM ships
WHERE name REGEXP '^W.*n$';

-- 3
SELECT a.model AS model1,
b.model AS model2, b.speed, b.ram
FROM pc a, pc b
WHERE a.model < b.model
AND a.ram = b.ram AND a.speed = b.speed;

-- 4
SELECT ship, battle, date
FROM outcomes JOIN battles ON battle = battles.name
WHERE ship IN (SELECT ship
FROM outcomes outcomes_s JOIN battles battles_s ON outcomes_s.battle = battles_s.name
WHERE result = 'damaged' AND date < battles.date);

-- 5
SELECT maker FROM product
INNER JOIN laptop ON product.model = laptop.model
WHERE laptop.speed>= 750
union
SELECT maker FROM product
INNER JOIN pc ON product.model = pc.model
WHERE pc.speed>= 750;

-- 6
SELECT DATE(date) FROM income;

-- 7
SELECT *
FROM (SELECT maker, COUNT(CASE WHEN type='pc' THEN 1 ELSE NULL END) pcs FROM product GROUP BY maker) count
WHERE count.pcs >= 2;

-- 8
SELECT maker
FROM (SELECT maker, COUNT(CASE WHEN speed>=600 THEN 1 ELSE NULL END) more,
COUNT(CASE WHEN speed < 600 THEN 1 ELSE NULL END) less FROM product INNER JOIN
laptop on product.model = laptop.model GROUP by maker) counts
WHERE counts.more>=1 and counts.less<=0;

-- 10
SELECT name FROM ships
WHERE name REGEXP '.*[:space:].*[:space:].*'
UNION
SELECT ship FROM outcomes
WHERE ship REGEXP '.*[:space:].*[:space:].*';


-- 9
SELECT trip_no, name, plane, town_from, town_to,
CASE
	WHEN TIMEDIFF(time_in, time_out) > 0 
    Then TIMEDIFF(time_in, time_out)
    ELSE TIMEDIFF(date_add(time_in, interval 1 day), time_out)
END AS trip_time
FROM trip inner join company on trip.ID_comp = company.ID_comp;



SELECT  user.name, surname, game.name, genre_name
FROM user INNER JOIN (steam INNER JOIN (steam_has_game INNER JOIN (game INNER JOIN (games_genres INNER JOIN genre on games_genres.Genre_id = genre.id) on game.id = games_genres.Game_id) on steam_has_game.Game_id = game.id) on steam.id = steam_has_game.Steam_id) on user.id = steam.User_id
GROUP by game.name;