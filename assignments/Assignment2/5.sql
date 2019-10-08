SELECT DISTINCT d.fname, d.lname
FROM demeritNotices as d
WHERE d.ddate BETWEEN DATE('now', '-2 year') AND DATE('now')
AND (SELECT SUM(dd.points)
	FROM demeritNotices as dd
	GROUP BY dd.fname, dd.lname)
>=15
