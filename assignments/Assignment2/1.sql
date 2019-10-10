.print Question 1 - awoosare
SELECT persons.fname, persons.lname, persons.phone
FROM persons
JOIN registrations ON persons.fname=registrations.fname AND persons.lname=registrations.lname
JOIN vehicles ON registrations.vin=vehicles.vin
AND vehicles.make='Chevrolet'
AND vehicles.model='Camaro'
AND vehicles.year=1969
;
