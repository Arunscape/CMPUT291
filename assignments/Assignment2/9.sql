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
