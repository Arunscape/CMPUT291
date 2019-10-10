.print Question 7 - awoosare
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
