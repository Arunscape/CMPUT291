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
;
