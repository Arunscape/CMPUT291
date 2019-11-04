SELECT AVG(price) 
FROM Suits
JOIN Apartments USING(aID)
WHERE type='2 bedrooms'
AND address='Whyte Ave';


SELECT aID, COUNT(sID) as vacant FROM 
Apartments LEFT OUTER JOIN (
    SELECT sID, aID FROM Suits
    EXCEPT 
    SELECT sID, aID FROM Suits
    JOIN Tenants USING(sID)
    ) USING(aID)
GROUP BY aID;


SELECT aid FROM Apartments
JOIN Suits USING(aID)
JOIN Tenants USING(sID)
WHERE unitNumber LIKE '2__'
AND yearOfOccup >= 2000
GROUP BY aID
HAVING COUNT(*) >=1 ;

