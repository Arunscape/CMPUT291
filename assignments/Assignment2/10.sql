.print Question 10 - awoosare
-- Using the view created in Q9, for every person who has received at least 3 different tickets within the past year and one of those tickets involves a 'red light' violation 
-- (i.e. 'red light' appears in the violation text, e.g. 'red light crossing', 'crossing red light at 114 St and 87 Ave'), list the name of the person and the make and the model of the car for which the red violation ticket is given.
SELECT pd.fname, pd.lname, v.make, v.model
FROM
personDetails pd
JOIN registrations r ON r.fname=pd.fname AND r.lname=pd.lname
JOIN vehicles v ON v.vin=r.vin
JOIN tickets t ON t.regno=r.regno 
AND t.vdate >= DATE('now', '-1 year')
WHERE pd.ticketsRcvd >=3 
AND violation LIKE '%red light%'
;

-- SELECT * FROM personDetails;