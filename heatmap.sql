select * from buys
limit 100

select distinct country 
from buys
limit 100

select count(1)
from buys
where time_stamp >= '2015-08-01' and time_stamp < '2015-09-01'
and (country is null or country = '')
-- 469,920,418 535399740 670218940
-- 344,810,268 535399740 670218940

select min(time_stamp)
from buys
where time_stamp >= '2015-01-01'
and length(country) =2
-- 2015-10-15 07:52:47.0

-- How many rows without country data?
select count(1) 
from buys
where time_stamp >= '2015-10-16'
and (country is null or country = '')
-- 90,806,559

-- How many rows with country data?
select count(1) 
from buys
where time_stamp >= '2015-10-16'
and (country is not null and country != '')
-- 264,743,838

select *
from buys
where time_stamp >= '2015-10-16'
and (country is null or country = '')
limit 1000


rollback


