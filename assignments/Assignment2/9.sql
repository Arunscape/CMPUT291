.print Question 9 - awoosare
-- Create a view called personDetails with columns fname, lname, bdate, bplace, carsowned, and ticketsRcvd. 
-- The view includes for each person, fname, lname, bdate, bplace, the number of different cars registered under the person name in the past year, and the number of different tickets given to those registered cars within the past year. 
-- Include people who have no cars registered under their names or no tickets with zero values.

-- DROP VIEW IF EXISTS personDetails; -- comment this out before handing in


CREATE VIEW personDetails (fname, lname, bdate, bplace, carsOwned, ticketsRcvd) AS
SELECT p.fname, p.lname, p.bdate, p.bplace, COUNT(DISTINCT r.regno) AS carsowned, COUNT(DISTINCT t.tno) AS ticketsRcvd
FROM persons p
LEFT OUTER JOIN registrations r 
    ON 
    r.fname=p.fname AND
    r.lname=p.lname AND
    r.regdate >= DATE('now', '-1 year')
LEFT OUTER JOIN tickets t
USING(regno)
GROUP BY p.fname, p.lname
;

-- SELECT * FROM personDetails; -- comment this out before handing in

-- I don't need subqueries, this was a previous try that works but I realized it could be done way easier...

-- CREATE VIEW personDetails AS
-- SELECT DISTINCT fname, lname, bdate, bplace, IFNULL(carsowned, 0) AS carsowned, IFNULL(ticketsRcvd, 0) AS ticketsRcvd --, carsowned, ticketsRcvd
-- FROM persons
-- -- LEFT OUTER JOIN births USING(fname, lname)
-- LEFT OUTER JOIN (SELECT fname, lname, IFNULL(COUNT(*), 0) AS carsowned
--                     FROM registrations
--                     WHERE regdate >= DATE('now', '-1 year')
--                     GROUP BY fname, lname) regs 
-- USING(fname, lname)
-- LEFT OUTER JOIN (SELECT fname, lname, IFNULL(COUNT(DISTINCT tno), 0) AS ticketsRcvd
--                     FROM registrations
--                     LEFT OUTER JOIN tickets USING(regno)
--                     WHERE regdate >= DATE('now', '-1 year')
--                     AND vdate >= DATE('now', '-1 year')
--                     GROUP BY fname, lname
--                     ) ticks
-- USING(fname, lname);