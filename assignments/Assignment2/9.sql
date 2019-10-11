.print Question 9 - awoosare
-- Create a view called personDetails with columns fname, lname, bdate, bplace, carsowned, and ticketsRcvd. 
-- The view includes for each person, fname, lname, bdate, bplace, the number of different cars registered under the person name in the past year, and the number of different tickets given to those registered cars within the past year. 
-- Include people who have no cars registered under their names or no tickets with zero values.

DROP VIEW IF EXISTS personDetails;

CREATE VIEW personDetails (fname, lname, bdate, bplace, carsowned, ticketsRcvd) AS
SELECT p.fname, p.lname, p.bdate, p.bplace, COUNT(DISTINCT r.regno) AS carsowned, COUNT(DISTINCT t.tno) AS ticketsRcvd
FROM persons p
LEFT OUTER JOIN registrations r 
    ON 
    r.fname=p.fname AND
    r.lname=p.lname AND
    r.regdate >= DATE('now', '-1 year')
LEFT OUTER JOIN tickets t
USING(regno)
LEFT OUTER JOIN vehicles v
USING(vin)
GROUP BY p.fname, p.lname
;

SELECT * FROM personDetails;
