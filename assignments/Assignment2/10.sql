.print Question 10 - awoosare
-- Using the view created in Q9, for every person who has received at least 3 different tickets within the past year and one of those tickets involves a 'red light' violation 
-- (i.e. 'red light' appears in the violation text, e.g. 'red light crossing', 'crossing red light at 114 St and 87 Ave'), list the name of the person and the make and the model of the car for which the red violation ticket is given.
SELECT fname, lname, make, model
FROM
personDetails

HAVING COUNT(*) =  (SELECT DISTINCT COUNT(*) as num_of_tickets
                    FROM tickets
                    WHERE num_of_tickets >=3
                    AND violation LIKE '%red light%'
                    GROUP BY tno 
        
GROUP BY person
;