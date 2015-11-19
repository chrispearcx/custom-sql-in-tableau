-- Find the correct column_family (provider_id) for Vistaprint US
select column_family from pg_data_providers
where id in (
	select distinct data_provider_id
	from pg_data_providers_targeting_groups
	where targeting_group_id in (
		select id from pg_targeting_groups
		where user_id in (2514, 3758, 3890, 4213, 4350)))
-- exclude user_id 2053. Vistaprint must be the column_familly (provider_id) for Vistaprint US

select *
from rt_pixels
where provider_id = 'Vistaprint'
and time_stamp >= '2015-10-01' and time_stamp < '2015-10-02' 
limit 10
-- rt_pixels.provider_id = pg_data_providers.column_family

select import_time_stamp::date, count(distinct user_id) as uu_pixeled
from rt_pixels
where provider_id = 'Vistaprint' 
and import_time_stamp >= '2015-10-01'
group by import_time_stamp::date
order by import_time_stamp::date

select *
from pixel_ag
where provider_id = 'Vistaprint'
and date >= '2015-10-01'
order by date

select time_stamp::date, count(1)
from rt_pixels
where provider_id = 'Vistaprint' 
and time_stamp >= '2015-10-01'
group by time_stamp::date
order by time_stamp::date

-- Dive into uu_pixeled
select *
from rt_pixels_aggregate
where provider_id = 'Vistaprint' 
and date_stamp >= '2015-10-01'
order by date_stamp
-- rt_pixels_aggregate.uu_pixeled was aggregated by rt_pixels.import_data_stamp

select date_trunc('month', date_stamp), sum(uu_pixeled)
from rt_pixels_aggregate
where provider_id = 'Vistaprint'
	and date_stamp >= '2015-08-01'
group by date_trunc('month', date_stamp)
order by date_trunc('month', date_stamp)
-- 2015-08-01	29800987
-- 2015-09-01	32297318
-- 2015-10-01	28701839
-- uu_pixeled is not additivable

select date_trunc('month', import_time_stamp)::date, count(distinct user_id)
from rt_pixels
where provider_id = 'Vistaprint' 
and import_time_stamp >= '2015-08-01'
group by date_trunc('month', import_time_stamp)::date
order by date_trunc('month', import_time_stamp)::date
-- 2015-08-01	31,221,997
-- 2015-09-01	30,057,818
-- 2015-10-01	27,441,247

select date_trunc('month', import_time_stamp)::date, count(distinct pixel_key)
from rt_pixels
where provider_id = 'Vistaprint' 
and import_time_stamp >= '2015-05-01'
group by date_trunc('month', import_time_stamp)::date
order by date_trunc('month', import_time_stamp)::date
-- 2015-08-01	187
-- 2015-09-01	135
-- 2015-10-01	127

-- monthly uniques calculated from rt_pixels are impressive larger than Quantcast. 30M vs 1.4M
select date_trunc('month', import_time_stamp)::date, count(distinct user_id), count(distinct pixel_key)+count(distinct segment)
from rt_pixels
where provider_id = 'Vistaprint' and import_time_stamp >= '2015-05-01'
group by date_trunc('month', import_time_stamp)::date
order by date_trunc('month', import_time_stamp)::date
-- 2015-05-01	34066416	203
-- 2015-06-01	31602299	129
-- 2015-07-01	32320475	211
-- 2015-08-01	31221997	226
-- 2015-09-01	30057818	176
-- 2015-10-01	27720923	164

-- how many rows has null value in pixel_key column
select *
from rt_pixels
where provider_id = 'Vistaprint' and import_time_stamp >= '2015-10-01'
and pixel_key = ''
limit 10

select distinct pixel_key
from rt_pixels
where provider_id = 'Vistaprint' and import_time_stamp >= '2015-10-01'

select distinct pixel_key
from rt_pixels
where provider_id = 'Vistaprint' and import_time_stamp >= '2015-10-01'
and segment = 'VPconv'
-- returns empty cell

select *
from rt_pixels
where provider_id = 'Vistaprint' and import_time_stamp >= '2015-10-01'
and ((pixel_key = '' and segment = '') or (pixel_key != '' and segment != ''))
-- no record

select *
from rt_pixels
where provider_id = 'Vistaprint' and import_time_stamp >= '2015-10-01'
and (pixel_key = '' or segment = '')
limit 50

---------------------------------------------------------------------------
--Uniques calculated from buys table
select date_trunc('month', time_stamp)::date, count(distinct user_id)
from buys
where campaign_id in (10653, 11226) and time_stamp >= '2015-08-01'
group by date_trunc('month', time_stamp)::date
-- 2015-08-01	955,074
-- 2015-09-01	888,126
-- 2015-10-01	812,012

--How to eliminate dulicates in rt_pixels table?
---Compare ip and user_id:
select r1.user_id as user_id1, r1.ip as ip1, r2.user_id as user_id1, r2.ip as ip1
from rt_pixels r1, rt_pixels r2
where r1.provider_id = 'Vistaprint' and r2.provider_id = 'Vistaprint' 
and r1.user_id != r2.user_id and r1.ip = r2.ip
and r1.import_time_stamp >= '2015-10-01' and r1.import_time_stamp < '2015-10-02'
and r2.import_time_stamp >= '2015-10-01' and r2.import_time_stamp < '2015-10-02'
limit 50

select *
from rt_pixels
where provider_id = 'Vistaprint'
and import_time_stamp >= '2015-10-01' and import_time_stamp < '2015-10-02'
limit 50

-- Count uniques in both table month by month
select count(distinct user_id)
from buys
where campaign_id in (10653, 11226) and time_stamp >= '2015-10-01' and time_stamp < '2015-11-01'
and user_id in (
	select distinct user_id 
	from rt_pixels
	where provider_id = 'Vistaprint' and time_stamp >= '2015-10-01' and time_stamp < '2015-11-01')
-- 2015-08	756,048
-- 2015-09	742,681
-- 2015-10	678,952

-- monthly uniques calculated from rt_pixels are impressive larger than Quantcast. 30M vs 1.4M
select date_trunc('month', time_stamp)::date, count(distinct user_id)
from rt_pixels
where provider_id = 'Vistaprint' and time_stamp >= '2015-05-01'
group by date_trunc('month', time_stamp)::date
-- 2015-05	34,056,435
-- 2015-06	31,605,499
-- 2015-07	32,308,972
-- 2015-08	31,235,978
-- 2015-09	30,044,615
-- 2015-10	28,891,600

-- daily avg uniques
select avg(daily_uu)
from (select time_stamp::date, count(distinct user_id) as daily_uu
from rt_pixels
where provider_id = 'Vistaprint' and time_stamp >= '2015-10-01'
group by time_stamp::date)
--1,046,576

-- Daily avg uniques from buys table
select avg(daily_uu)
from (select time_stamp::date, count(distinct user_id) as daily_uu
from buys
where campaign_id in (10653, 11226) and time_stamp >= '2015-10-01'
group by time_stamp::date)
-- 96,011 about 9% of rt_pixels

-- Daily uniques by day
select time_stamp::date, count(distinct user_id) as daily_uu
from buys
where campaign_id in (10653, 11226) 
and time_stamp >= '2015-08-01' and time_stamp < '2015-11-01'
group by time_stamp::date

-- Daily uniques by day from rt_pixels
select time_stamp::date, count(distinct user_id) as daily_uu
from rt_pixels
where provider_id = 'Vistaprint'
and time_stamp >= '2015-08-01' and time_stamp < '2015-11-01'
group by time_stamp::date

-- Count uniques in both table by day
select b.time_stamp::date, count(distinct b.user_id)
from buys b join rt_pixels r
on b.user_id = r.user_id and b.time_stamp::date = r.time_stamp::date
where b.campaign_id in (10653, 11226) and b.time_stamp >= '2015-08-01' and b.time_stamp < '2015-11-01'
group by b.time_stamp::date

rollback
