SELECT DISTINCT b2.fname, b2.lname
FROM births b1, births b2
WHERE (b1.fname='Michael' AND b1.lname='Fox')
AND NOT (b2.fname='Michael' AND b2.lname='Fox')
AND (
	(b1.f_fname = b2.f_fname AND b1.f_lname = b2.f_lname) 
	OR
	(b1.m_fname = b2.m_fname AND b1.m_lname = b2.m_lname)
);
