.print Question 5 - awoosare
SELECT DISTINCT fname, lname
FROM demeritNotices
WHERE ddate BETWEEN DATE('now', '-2 year') AND DATE('now')
AND (SELECT SUM(demeritNotices.points)
	FROM demeritNotices
	GROUP BY fname, lname)
>=15
;
