.print Question 8 - awoosare
-- For each year of a car, find the most frequent make and the most frequent car color. In case of ties, list all those ties.
-- SELECT v.year, v.make, v.color, COUNT(v.make) AS num_make
-- FROM vehicles v

SELECT * from vehicles
-- GROUP BY v.year
;