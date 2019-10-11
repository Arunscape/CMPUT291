.print Question 8 - awoosare
-- For each year of a car, find the most frequent make and the most frequent car color. In case of ties, list all those ties.
SELECT year, make, color
FROM (
        (SELECT v.year, v.make
            FROM vehicles v
            GROUP BY v.year, v.make
            -- for each year, get the make(s) which have the max count for that year
            HAVING COUNT(*) = (SELECT MAX(make_count)
                                FROM
                                    (SELECT year, make, COUNT(*) as make_count
                                        FROM vehicles vee
                                    GROUP BY year, make)
                                WHERE year = v.year) -- for each year, get the count for each make
        ) make_table -- now we have the most popular make for each year including ties
        -- do the same thing again for colour and JOIN it on year
         LEFT OUTER JOIN
            (SELECT veh.year, veh.color
                FROM vehicles veh
                GROUP BY veh.year, veh.color
                HAVING COUNT(*) = (SELECT MAX(colour_count)
                                    FROM
                                        (SELECT year, color, COUNT(*) as colour_count
                                            FROM vehicles veicicles
                                            GROUP BY year, color) 
                                            WHERE year = veh.year)
            ) colour_table
        USING(year) -- same column name
        -- UNION ALL
        -- SELECT * FROM colour_table
        -- LEFT OUTER JOIN make_table
        -- USING(year)
    )
-- FINALLY, select the year, make, color from this clusterf***
;

