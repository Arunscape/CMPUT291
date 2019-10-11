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

