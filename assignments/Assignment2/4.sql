.print Question 4 - awoosare
SELECT births.fname, births.lname
FROM births
JOIN persons ON persons.fname = births.fname AND persons.lname = births.lname
WHERE births.f_fname = "Michael" AND births.f_lname = "Fox"
AND persons.bdate = (
	SELECT p.bdate
	FROM persons as p
	JOIN births as b 
	ON p.fname = b.fname AND p.lname = b.lname
	WHERE b.f_fname = "Michael" AND b.f_lname = "Fox"
	ORDER BY p.bdate ASC
	LIMIT 1
);
	

