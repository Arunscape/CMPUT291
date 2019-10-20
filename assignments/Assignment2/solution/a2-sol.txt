.print Question 1 - drafiei
select distinct p.fname, p.lname, p.phone
from persons p, registrations r, vehicles v
where p.fname=r.fname and p.lname=r.lname and 
      r.vin=v.vin and v.make='Chevrolet' and v.model='Camaro' and v.year=1969;

-- Question 1
.print Question 2 - drafiei
select b2.fname, b2.lname
from births b1, births b2    
where b1.fname="Michael" and b1.lname="Fox" and
  ((b1.f_fname=b2.f_fname and b1.f_lname=b2.f_lname) or (b1.m_fname=b2.m_fname and b1.m_lname=b2.m_lname))
except select  "Michael", "Fox";

.print Question 3 - drafiei
select b4.fname, b4.lname
from births b1, births b2, births b3, births b4
where b1.fname="Michael" and b1.lname="Fox" and
      ((b1.f_fname=b2.fname and b1.f_lname=b2.lname) or (b1.m_fname=b2.fname and b1.m_lname=b2.lname)) and
      b2.f_fname=b3.f_fname and b2.f_lname=b3.f_lname and
      ((b3.fname=b4.f_fname and b3.lname=b4.f_lname) or (b3.fname=b4.m_fname and b3.lname=b4.m_lname)) 
except select "Michael", "Fox";

.print Question 4 - drafiei  
-- This won't return all ties.
select b.fname, b.lname
from births b, persons p
where b.fname=p.fname and b.lname=p.lname and f_fname="Michael" and f_lname="Fox"
order by bdate asc
limit 1;

-- This one will return all ties
select b.fname, b.lname
from births b, persons p
where b.fname=p.fname and b.lname=p.lname and f_fname="Michael" and f_lname="Fox" and
      bdate <= (select min(bdate)
                from births b2, persons p2
 	        where b2.fname=p2.fname and b2.lname=p2.lname and b2.f_fname="Michael" and b2.f_lname="Fox");

.print Question 5 - drafiei
select fname, lname
from demeritNotices
where ddate > date('now', '-2 years')
group by fname, lname
having sum(points) > 15;

.print Question 6 - drafiei
select fname, lname
from (
  select p1_fname as fname, p1_lname as lname, regdate
  from marriages
  where p2_fname="Michael" and p2_lname="Fox"
  union
  select p2_fname as fname, p2_lname as lname, regdate
  from marriages
  where p1_fname="Michael" and p1_lname="Fox" ) t
order by regdate desc
limit 1;

.print Question 7 - drafiei
-- we convert the first count to float before the division
select color, count(distinct t.tno)*1.0/count(distinct r.regno), avg(fine), max(fine)
from  registrations r left outer join vehicles v on v.vin=r.vin 
     left outer join tickets t on r.regno=t.regno
where expiry > date('now','+1 month')
group by color; 

-- The following quey will return the counts as integer 
select color, count(distinct t.tno)/count(distinct r.regno), avg(fine), max(fine)
from  registrations r left outer join vehicles v on v.vin=r.vin
     left outer join tickets t on r.regno=t.regno
where expiry > date('now','+1 month')
group by color;

.print Question 8 - drafiei
-- The following uses "all" and will not work in Sqlite
select m.year, m.make, c.color
from (select year, make
      from vehicles v1
      group by year, make
      having count(*) >= all (select count(*) from vehicles v2 where v2.year=v1.year group by make)) m,
     (select year, color
      from vehicles v1
      group by year, color
      having count(*) >= all (select count(*) from vehicles v2 where v2.year=v1.year group by color)) c
where m.year=c.year;

-- The same query written without "all" (this will work in sqlite)
select m.year, m.make, c.color
from (select year, make
      from vehicles v1
      group by year, make
      having count(*) >= (select max(cnt) from (select count(*) as cnt
                                                from vehicles v2 where v2.year=v1.year group by make))) m,
     (select year, color
      from vehicles v1
      group by year, color
      having count(*) >= (select max(cnt) from (select count(*) as cnt 
                                                from vehicles v2 where v2.year=v1.year group by color))) c
where m.year=c.year;

.print Question 9 - drafiei
drop view if exists personDetails;
create view personDetails (fname, lname, bdate, bplace, carsowned, ticketsRcvd) as
 select p.fname, p.lname, p.bdate, p.bplace, count(distinct r.regno) as carsowned, count( distinct tno) as ticketsRcvd
 from persons p left outer join registrations r on r.fname=p.fname and r.lname=p.lname  left outer join  tickets t on r.regno=t.regno
 where (regdate is null or regdate > date('now','-1 years')) and (vdate is null or vdate > date('now','-1 years'))
 group by p.fname, p.lname, p.bdate, p.bplace;


.print Question 10 - drafiei
select distinct p.fname, p.lname, v.make, v.model
from personDetails p, registrations r, tickets t, vehicles v
where r.regno=t.regno and r.fname=p.fname and r.lname=p.lname and t.violation like '%red light%'
      and vdate > date('now','-1 year') and ticketsRcvd>=3 and r.vin=v.vin;
