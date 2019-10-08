SELECT persons.fname, persons.lname, persons.phone
FROM persons, registrations, vehicles
WHERE persons.fname=registrations.fname
AND persons.lname=registrations.lname
AND registrations.vin=vehicles.vin
AND vehicles.make='Chevrolet'
AND vehicles.model='Camaro'
AND vehicles.year=1969;
