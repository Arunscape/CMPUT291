.echo on
.print Question 1 - awoosare
SELECT persons.fname, persons.lname, persons.phone
FROM persons
JOIN registrations ON persons.fname=registrations.fname AND persons.lname=registrations.lname
JOIN vehicles ON registrations.vin=vehicles.vin
AND vehicles.make='Chevrolet'
AND vehicles.model='Camaro'
AND vehicles.year=1969
;
.print Question 2 - awoosare
SELECT DISTINCT b2.fname, b2.lname
FROM births b1, births b2
WHERE (b1.fname='Michael' AND b1.lname='Fox')
AND NOT (b2.fname='Michael' AND b2.lname='Fox')
AND (
	(b1.f_fname = b2.f_fname AND b1.f_lname = b2.f_lname) 
	OR
	(b1.m_fname = b2.m_fname AND b1.m_lname = b2.m_lname)
);
.print Question 3 - awoosare
SELECT DISTINCT b2.fname, b2.lname
FROM births b1, births b2, births b3, births b4
WHERE (b1.fname = 'Michael' AND b1.lname = 'Fox') -- Michael Fox
AND NOT (b2.fname='Michael' AND b2.lname='Fox') -- has same grandfather
AND (
	(b3.fname = b1.f_fname AND b3.lname = b1.f_lname) 
	OR
	(b3.fname = b1.m_fname AND b3.lname = b1.m_lname)
) -- b3 is either Michael's father or mother
AND (
	(b4.fname = b2.f_fname AND b4.lname = b2.f_lname)
	OR
	(b4.fname = b2.m_fname AND b4.lname = b2.m_lname)
) -- b4 is someone who is not Michael's mother or father but a parent of b2
AND (b3.f_fname = b4.f_fname AND b3.f_lname = b4.f_lname)
;
.print Question 4 - awoosare
SELECT births.fname, births.lname
FROM births
JOIN persons ON persons.fname = births.fname AND persons.lname = births.lname
WHERE (births.f_fname = 'Michael' AND births.f_lname = 'Fox'
OR births.m_fname = 'Michael' AND births.m_lname = 'Fox')
-- It's 2019, the mother might be named Michael Fox
AND persons.bdate = (
	SELECT p.bdate
	FROM persons as p
	JOIN births as b 
	ON p.fname = b.fname AND p.lname = b.lname
	WHERE b.f_fname = 'Michael' AND b.f_lname = 'Fox'
	ORDER BY p.bdate ASC
	LIMIT 1
)
;
	

.print Question 5 - awoosare
SELECT DISTINCT fname, lname
FROM demeritNotices
WHERE ddate BETWEEN DATE('now', '-2 year') AND DATE('now')
AND (SELECT SUM(demeritNotices.points)
	FROM demeritNotices
	GROUP BY fname, lname)
>=15
;
.print Question 6 - awoosare
SELECT persons.fname, persons.lname
FROM persons
JOIN marriages ON 
	(persons.fname=marriages.p1_fname AND persons.lname=marriages.p1_lname
		AND marriages.p2_fname='Michael' AND marriages.p2_lname='Fox')
	OR
	(persons.fname=marriages.p2_fname AND persons.lname=marriages.p2_lname
		AND marriages.p1_fname='Michael' AND marriages.p1_lname='Fox')
ORDER BY marriages.regdate DESC
LIMIT 1
;.print Question 7 - awoosare
-- For each color of a car with a registration that does not expire at least for another month, find the average number of tickets issued per registration, the average amount of fine given, and the maximum amount of fine given. Include colors with no tickets in the output with zero counts (if applicable) or null values. Hint: you may find outer join useful.
SELECT DISTINCT v.color,
--COUNT(t.tno) AS tickets_per_colour,
--COUNT(DISTINCT r.regno) AS registrations_per_colour,
CAST(COUNT(t.tno) AS FLOAT)/COUNT(DISTINCT r.regno) AS tickets_per_registration,
AVG(t.fine) AS average_fine,
MAX(t.fine) AS maximum_fine
FROM vehicles v
LEFT OUTER JOIN registrations r ON r.vin=v.vin
LEFT OUTER JOIN tickets t ON t.regno=r.regno
WHERE r.expiry > DATE('now', '+1 month')
GROUP BY v.color
;
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
.print Question 9 - awoosare
-- Create a view called personDetails with columns fname, lname, bdate, bplace, carsowned, and ticketsRcvd. 
-- The view includes for each person, fname, lname, bdate, bplace, the number of different cars registered under the person name in the past year, and the number of different tickets given to those registered cars within the past year. 
-- Include people who have no cars registered under their names or no tickets with zero values.
-- CREATE VIEW personDetails AS
       -- DISTINCT gets rid of michael fox duplicate
SELECT DISTINCT fname, lname, bdate, bplace, carsowned, ticketsRcvd --, carsowned, ticketsRcvd
FROM persons
LEFT OUTER JOIN births USING(fname, lname)
LEFT OUTER JOIN (SELECT fname, lname, IFNULL(COUNT(*), 0) AS carsowned
                    FROM registrations
                    WHERE regdate >= DATE('now', '-1 year')
                    GROUP BY fname, lname) regs 
USING(fname, lname)
LEFT OUTER JOIN (SELECT fname, lname, IFNULL(COUNT(DISTINCT tno), 0) AS ticketsRcvd
                    FROM registrations
                    LEFT OUTER JOIN tickets USING(regno)
                    WHERE regdate >= DATE('now', '-1 year')
                    GROUP BY fname, lname
                    ) ticks
USING(fname, lname)
;
.print Question 10 - awoosare
-- Using the view created in Q9, for every person who has received at least 3 different tickets within the past year and one of those tickets involves a 'red light' violation 
-- (i.e. 'red light' appears in the violation text, e.g. 'red light crossing', 'crossing red light at 114 St and 87 Ave'), list the name of the person and the make and the model of the car for which the red violation ticket is given.
;