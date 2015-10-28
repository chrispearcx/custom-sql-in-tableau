-- targeting_group_id 
select distinct id
from pg_targeting_groups
where campaign_id in (10653, 11226)

-- provider_id 
select distinct data_provider_id
from pg_data_providers_targeting_groups
where targeting_group_id in (14873,15047,15048,15059,15100,15101,15171,15172,15173,15174,15175,15185,15186,15187,15188,15284,15285,15286,15287,15288)
--provider_id = 2201

select *
from pg_data_providers
where id = 2201
-- column_family = Vistaprint

select *
from rt_pixels
where provider_id = 'Vistaprint'
and time_stamp >= '2015-10-01' and time_stamp < '2015-10-02' 
limit 10
-- provider_id in rt_pixels = column_family in pg_data_providers

select *
from pixel_volume
where provider_id = 'Vistaprint'
limit 10

select *
from rt_pixels_aggregate
where provider_id = 'Vistaprint'
and date_stamp >= '2015-10-01'
order by date_stamp

select import_time_stamp::date, count(distinct user_id) as uu_pixeled
from rt_pixels
where provider_id = 'Vistaprint' 
and import_time_stamp >= '2015-10-01'
group by import_time_stamp::date
order by import_time_stamp::date

select *
from pixel_volume
where provider_id = 'Vistaprint'
and pixel_volume.date >= '2015-10-01'
order by date

rollback

