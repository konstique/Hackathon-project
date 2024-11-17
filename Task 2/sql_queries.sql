#ПЕРШИЙ
#Колонка date_stolen має тип text, тому перед тим як виконувати завдання це варто виправити
ALTER TABLE stolen_vehicles ADD COLUMN date_stolen_temp DATE;
UPDATE stolen_vehicles
SET date_stolen_temp = STR_TO_DATE(date_stolen, '%m/%d/%y');
ALTER TABLE stolen_vehicles DROP COLUMN date_stolen;
ALTER TABLE stolen_vehicles CHANGE COLUMN date_stolen_temp date_stolen DATE;

SELECT ROUND(AVG(total_count),0) as average_cars_stolen_per_week
FROM (SELECT WEEK(date_stolen), COUNT(vehicle_id) as total_count
	FROM stolen_vehicles
    WHERE vehicle_id IS NOT NULL
    GROUP BY 1) as t;
    
#ДРУГИЙ

WITH cte AS (SELECT vehicle_type, ROUND(AVG(total_count),0) as average_cars_stolen_in_spring,
RANK() OVER (ORDER BY ROUND(AVG(total_count),0) DESC) as rank_average_stolen_cars
FROM (SELECT vehicle_type, COUNT(vehicle_id) as total_count
	FROM stolen_vehicles
    WHERE vehicle_id IS NOT NULL and MONTH(date_stolen) BETWEEN 3 and 5
    GROUP BY 1) as t
GROUP BY 1
WITH ROLLUP)
SELECT vehicle_type, average_cars_stolen_in_spring
FROM cte
WHERE rank_average_stolen_cars = 1 OR vehicle_type IS NULL;
#Наведений запит витягає одразу найпопулянішій тип машин у водіїв (Stationwagon) та середнє значення за весну (останній ряд)

#ТРЕТІЙ

WITH top_3 AS (SELECT make_name, make_id, COUNT(vehicle_id) as amount_stolen
FROM stolen_vehicles as v LEFT JOIN make_details as d
USING(make_id)
GROUP BY 1,2
ORDER BY 3 DESC
LIMIT 3)
SELECT MONTH(date_stolen) AS mnth, make_name, COUNT(vehicle_id) AS total_count
FROM stolen_vehicles LEFT JOIN top_3
USING(make_id)
WHERE make_name IS NOT NULL
GROUP BY 1,2
HAVING MOD(mnth, 2) = 0
ORDER BY 1 ASC;

#ЧЕТВЕРТИЙ

WITH distinct_colours AS(SELECT DISTINCT color
FROM stolen_vehicles),
distinct_regions AS (SELECT DISTINCT region
FROM locations),
cart_product AS(SELECT *
FROM distinct_regions CROSS JOIN distinct_colours)

SELECT cp.region, cp. color, SUM(CASE WHEN sv.vehicle_id IS NULL THEN 0 ELSE 1 END) AS amount_stolen
FROM (SELECT * 
FROM stolen_vehicles 
LEFT JOIN locations
USING(location_id)) AS sv RIGHT JOIN cart_product AS cp
ON sv.color = cp.color AND sv.region = cp.region
GROUP BY 1,2
ORDER BY 1,2;
#Наведений вище запит враховує абсолютно всі кольори та регіони, що були представлені в датасеті