.print Question 8 - awoosare
-- For each year of a car, find the most frequent make and the most frequent car color. In case of ties, list all those ties.
SELECT v.year, v.make, v.color
FROM vehicles v

-- ORDER BY num_make DESC
GROUP BY v.year
HAVING 
COUNT(v.make) = (SELECT COUNT(vehicles.make) AS vc
                    from vehicles
                    GROUP BY vehicles.make
                    ORDER BY vc DESC
                    LIMIT 1) -- number of the most frequent make
AND
COUNT(v.model) = (SELECT COUNT(vehicles.model) AS vm
                    from vehicles
                    GROUP BY vehicles.model
                    ORDER BY vm DESC
                    LIMIT 1) -- number of the most frequent model
;


-- (SELECT COUNT(vehicles.make) AS vc
--                     from vehicles
--                     GROUP BY vehicles.make
--                     ORDER BY vc DESC
--                     LIMIT 1) -- most frequent make

-- (SELECT vehicles.model, COUNT(vehicles.model) AS vm
--                     from vehicles
--                     GROUP BY vehicles.make
--                     ORDER BY vm DESC
--                     LIMIT 1) -- most frequent model                    