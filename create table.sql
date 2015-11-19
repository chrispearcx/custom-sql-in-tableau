INSERT INTO unique_user_counts
	select 'trggit', 'desktop', 'campaign', 'impressions', 'monthly',
	date_trunc('month', time_stamp)::date, campaign_id, count(distinct user_id)
	from buys
	where time_stamp >= '2015-08-01'
	group by date_trunc('month', time_stamp)::date, campaign_id
	
INSERT INTO unique_user_counts
	select 'triggit', 'desktop', 'campaign', 'impressions', 'monthly',
		date_trunc('month', time_stamp)::date, campaign_id, count(distinct user_id)
	from buys
	where time_stamp >= '2015-08-01' and time_stamp < '2015-11-01'
	group by date_trunc('month', time_stamp)::date, campaign_id
union all 
	select 'triggit', 'desktop', 'campaign', 'clicks', 'monthly',
		date_trunc('month', time_stamp)::date, campaign_id, count(distinct user_id)
	from clks
	where time_stamp >= '2015-08-01' and time_stamp < '2015-11-01'
	group by date_trunc('month', time_stamp)::date, campaign_id
union all 
	select 'triggit', 'desktop', 'campaign', 'conversions', 'monthly',
		date_trunc('month', time_stamp)::date, campaign_id, count(distinct user_id)
	from clkconvs
	where time_stamp >= '2015-08-01' and time_stamp < '2015-11-01'
	group by date_trunc('month', time_stamp)::date, campaign_id

INSERT INTO unique_user_counts
	select 'triggit', 'desktop', 'campaign', 'impressions', 'monthly',
		date_trunc('month', time_stamp)::date, campaign_id, count(distinct user_id)
	from buys
	where time_stamp >= '2015-08-01' and time_stamp < '2015-11-01'
	group by date_trunc('month', time_stamp)::date, campaign_id
union all 
	select 'triggit', 'desktop', 'campaign', 'clicks', 'monthly',
		date_trunc('month', time_stamp)::date, campaign_id, count(distinct user_id)
	from clks
	where time_stamp >= '2015-08-01' and time_stamp < '2015-11-01'
	group by date_trunc('month', time_stamp)::date, campaign_id
union all 
	select 'triggit', 'desktop', 'campaign', 'conversions', 'monthly',
		date_trunc('month', time_stamp)::date, campaign_id, count(distinct user_id)
	from clkconvs
	where time_stamp >= '2015-08-01' and time_stamp < '2015-11-01'
	group by date_trunc('month', time_stamp)::date, campaign_id

	
rollback

select distinct user_id
from clkconvs
limit 10

-- I should try "cross join"
rollback;
DROP TABLE IF EXISTS temp CASCADE;
CREATE TABLE temp
(

	platform 		varchar(16),
	channel	 		varchar(16),
	level			varchar(16),
	metric			varchar(16)
);

insert into temp
values 	
	('traggit', 'desktop', 'account', 'impressions'),
	('traggit', 'desktop', 'account', 'clicks'),
	('traggit', 'desktop', 'account', 'conversions'),
	('traggit', 'desktop', 'campaign', 'impressions'),
	('traggit', 'desktop', 'campaign', 'clicks'),
	('traggit', 'desktop', 'campaign', 'conversions'),
	('traggit', 'desktop', 'targeting_group', 'impressions'),
	('traggit', 'desktop', 'targeting_group', 'clicks'),
	('traggit', 'desktop', 'targeting_group', 'conversions');

-- ********************************************
-- ********************************************
DROP TABLE IF EXISTS unique_user_counts CASCADE;
 
CREATE TABLE unique_user_counts
(

	platform 		varchar(16),
	channel	 		varchar(16),
	level			varchar(16),
	metric			varchar(16),
	period			varchar(16),
	date_stamp		date,
--	name			varchar(256),
	id				integer,
	uu_count		bigint 
);

-- account**********************************
-- Insert *account* *impressions* by *daily*
INSERT INTO unique_user_counts
select 'triggit', 'desktop', 'account', 'impressions', 'daily',
	buys.time_stamp::date, pg_campaigns.user_id, count(distinct buys.user_id)
from buys left join pg_campaigns
on buys.campaign_id = pg_campaigns.id
where buys.time_stamp >= '2015-08-01' and buys.time_stamp < '2015-11-01'
group by buys.time_stamp::date, pg_campaigns.user_id;

-- Insert *account* *impressions* by *weekly*
INSERT INTO unique_user_counts
select 'triggit', 'desktop', 'account', 'impressions', 'weekly',
	date_trunc('week', buys.time_stamp)::date, pg_campaigns.user_id, count(distinct buys.user_id)
from buys left join pg_campaigns
on buys.campaign_id = pg_campaigns.id
where buys.time_stamp >= '2015-08-01' and buys.time_stamp < '2015-11-01'
group by date_trunc('week', buys.time_stamp)::date, pg_campaigns.user_id;

-- Insert *account* *impressions* by *monthly*
INSERT INTO unique_user_counts
select 'triggit', 'desktop', 'account', 'impressions', 'monthly',
	date_trunc('month', buys.time_stamp)::date, pg_campaigns.user_id, count(distinct buys.user_id)
from buys left join pg_campaigns
on buys.campaign_id = pg_campaigns.id
where buys.time_stamp >= '2015-08-01' and buys.time_stamp < '2015-11-01'
group by date_trunc('month', buys.time_stamp)::date, pg_campaigns.user_id;

-- Insert *account* *clicks* by *daily*
INSERT INTO unique_user_counts
select 'triggit', 'desktop', 'account', 'clicks', 'daily',
	clks.time_stamp::date, pg_campaigns.user_id, count(distinct clks.user_id)
from clks left join pg_campaigns
on clks.campaign_id = pg_campaigns.id
where clks.time_stamp >= '2015-08-01' and clks.time_stamp < '2015-11-01'
group by clks.time_stamp::date, pg_campaigns.user_id;

-- Insert *account* *clicks* by *weekly*
INSERT INTO unique_user_counts
select 'triggit', 'desktop', 'account', 'clicks', 'weekly',
	date_trunc('week', clks.time_stamp)::date, pg_campaigns.user_id, count(distinct clks.user_id)
from clks left join pg_campaigns
on clks.campaign_id = pg_campaigns.id
where clks.time_stamp >= '2015-08-01' and clks.time_stamp < '2015-11-01'
group by date_trunc('week', clks.time_stamp)::date, pg_campaigns.user_id;

-- Insert *account* *clicks* by *monthly*
INSERT INTO unique_user_counts
select 'triggit', 'desktop', 'account', 'clicks', 'monthly',
	date_trunc('month', clks.time_stamp)::date, pg_campaigns.user_id, count(distinct clks.user_id)
from clks left join pg_campaigns
on clks.campaign_id = pg_campaigns.id
where clks.time_stamp >= '2015-08-01' and clks.time_stamp < '2015-11-01'
group by date_trunc('month', clks.time_stamp)::date, pg_campaigns.user_id;

-- Insert *account* *conversions* by *daily*
INSERT INTO unique_user_counts
select 'triggit', 'desktop', 'account', 'conversions', 'daily',
	clkconvs.time_stamp::date, pg_campaigns.user_id, count(distinct clkconvs.user_id)
from clkconvs left join pg_campaigns
on clkconvs.campaign_id = pg_campaigns.id
where clkconvs.time_stamp >= '2015-08-01' and clkconvs.time_stamp < '2015-11-01'
group by clkconvs.time_stamp::date, pg_campaigns.user_id;

-- Insert *account* *conversions* by *weekly*
INSERT INTO unique_user_counts
select 'triggit', 'desktop', 'account', 'conversions', 'weekly',
	date_trunc('week', clkconvs.time_stamp)::date, pg_campaigns.user_id, count(distinct clkconvs.user_id)
from clkconvs left join pg_campaigns
on clkconvs.campaign_id = pg_campaigns.id
where clkconvs.time_stamp >= '2015-08-01' and clkconvs.time_stamp < '2015-11-01'
group by date_trunc('week', clkconvs.time_stamp)::date, pg_campaigns.user_id;

-- Insert *account* *conversions* by *monthly*
INSERT INTO unique_user_counts
select 'triggit', 'desktop', 'account', 'conversions', 'monthly',
	date_trunc('month', clkconvs.time_stamp)::date, pg_campaigns.user_id, count(distinct clkconvs.user_id)
from clkconvs left join pg_campaigns
on clkconvs.campaign_id = pg_campaigns.id
where clkconvs.time_stamp >= '2015-08-01' and clkconvs.time_stamp < '2015-11-01'
group by date_trunc('month', clkconvs.time_stamp)::date, pg_campaigns.user_id;

-- campaign**********************************
-- Insert *campaign* *impressions* by *daily*
INSERT INTO unique_user_counts
select 'triggit', 'desktop', 'campaign', 'impressions', 'daily',
	buys.time_stamp::date, campaign_id, count(distinct buys.user_id)
from buys
where buys.time_stamp >= '2015-08-01' and buys.time_stamp < '2015-11-01'
group by buys.time_stamp::date, campaign_id;

-- Insert *campaign* *impressions* by *weekly*
INSERT INTO unique_user_counts
select 'triggit', 'desktop', 'campaign', 'impressions', 'weekly',
	date_trunc('week', buys.time_stamp)::date, campaign_id, count(distinct buys.user_id)
from buys
where buys.time_stamp >= '2015-08-01' and buys.time_stamp < '2015-11-01'
group by date_trunc('week', buys.time_stamp)::date, campaign_id;

-- Insert *campaign* *impressions* by *monthly*
INSERT INTO unique_user_counts
select 'triggit', 'desktop', 'campaign', 'impressions', 'monthly',
	date_trunc('month', buys.time_stamp)::date, campaign_id, count(distinct buys.user_id)
from buys
where buys.time_stamp >= '2015-08-01' and buys.time_stamp < '2015-11-01'
group by date_trunc('month', buys.time_stamp)::date, campaign_id;

-- Insert *campaign* *clicks* by *daily*
INSERT INTO unique_user_counts
select 'triggit', 'desktop', 'campaign', 'clicks', 'daily',
	clks.time_stamp::date, campaign_id, count(distinct clks.user_id)
from clks
where clks.time_stamp >= '2015-08-01' and clks.time_stamp < '2015-11-01'
group by clks.time_stamp::date, campaign_id;

-- Insert *campaign* *clicks* by *weekly*
INSERT INTO unique_user_counts
select 'triggit', 'desktop', 'campaign', 'clicks', 'weekly',
	date_trunc('week', clks.time_stamp)::date, campaign_id, count(distinct clks.user_id)
from clks
where clks.time_stamp >= '2015-08-01' and clks.time_stamp < '2015-11-01'
group by date_trunc('week', clks.time_stamp)::date, campaign_id;

-- Insert *campaign* *clicks* by *monthly*
INSERT INTO unique_user_counts
select 'triggit', 'desktop', 'campaign', 'clicks', 'monthly',
	date_trunc('month', clks.time_stamp)::date, campaign_id, count(distinct clks.user_id)
from clks
where clks.time_stamp >= '2015-08-01' and clks.time_stamp < '2015-11-01'
group by date_trunc('month', clks.time_stamp)::date, campaign_id;

-- Insert *campaign* *conversions* by *daily*
INSERT INTO unique_user_counts
select 'triggit', 'desktop', 'campaign', 'conversions', 'daily',
	clkconvs.time_stamp::date, campaign_id, count(distinct clkconvs.user_id)
from clkconvs
where clkconvs.time_stamp >= '2015-08-01' and clkconvs.time_stamp < '2015-11-01'
group by clkconvs.time_stamp::date, campaign_id;

-- Insert *campaign* *conversions* by *weekly*
INSERT INTO unique_user_counts
select 'triggit', 'desktop', 'campaign', 'conversions', 'weekly',
	date_trunc('week', clkconvs.time_stamp)::date, campaign_id, count(distinct clkconvs.user_id)
from clkconvs
where clkconvs.time_stamp >= '2015-08-01' and clkconvs.time_stamp < '2015-11-01'
group by date_trunc('week', clkconvs.time_stamp)::date, campaign_id;

-- Insert *campaign* *conversions* by *monthly*
INSERT INTO unique_user_counts
select 'triggit', 'desktop', 'campaign', 'conversions', 'monthly',
	date_trunc('month', clkconvs.time_stamp)::date, campaign_id, count(distinct clkconvs.user_id)
from clkconvs
where clkconvs.time_stamp >= '2015-08-01' and clkconvs.time_stamp < '2015-11-01'
group by date_trunc('month', clkconvs.time_stamp)::date, campaign_id;

-- targeting group**********************************
-- Insert *targeting group* *impressions* by *daily*
INSERT INTO unique_user_counts
select 'triggit', 'desktop', 'targeting group', 'impressions', 'daily',
	buys.time_stamp::date, targeting_group_id, count(distinct buys.user_id)
from buys
where buys.time_stamp >= '2015-08-01' and buys.time_stamp < '2015-11-01'
group by buys.time_stamp::date, targeting_group_id;

-- Insert *targeting group* *impressions* by *weekly*
INSERT INTO unique_user_counts
select 'triggit', 'desktop', 'targeting group', 'impressions', 'weekly',
	date_trunc('week', buys.time_stamp)::date, targeting_group_id, count(distinct buys.user_id)
from buys
where buys.time_stamp >= '2015-08-01' and buys.time_stamp < '2015-11-01'
group by date_trunc('week', buys.time_stamp)::date, targeting_group_id;

-- Insert *targeting group* *impressions* by *monthly*
INSERT INTO unique_user_counts
select 'triggit', 'desktop', 'targeting group', 'impressions', 'monthly',
	date_trunc('month', buys.time_stamp)::date, targeting_group_id, count(distinct buys.user_id)
from buys
where buys.time_stamp >= '2015-08-01' and buys.time_stamp < '2015-11-01'
group by date_trunc('month', buys.time_stamp)::date, targeting_group_id;

-- Insert *targeting group* *clicks* by *daily*
INSERT INTO unique_user_counts
select 'triggit', 'desktop', 'targeting group', 'clicks', 'daily',
	clks.time_stamp::date, targeting_group_id, count(distinct clks.user_id)
from clks
where clks.time_stamp >= '2015-08-01' and clks.time_stamp < '2015-11-01'
group by clks.time_stamp::date, targeting_group_id;

-- Insert *targeting group* *clicks* by *weekly*
INSERT INTO unique_user_counts
select 'triggit', 'desktop', 'targeting group', 'clicks', 'weekly',
	date_trunc('week', clks.time_stamp)::date, targeting_group_id, count(distinct clks.user_id)
from clks
where clks.time_stamp >= '2015-08-01' and clks.time_stamp < '2015-11-01'
group by date_trunc('week', clks.time_stamp)::date, targeting_group_id;

-- Insert *targeting group* *clicks* by *monthly*
INSERT INTO unique_user_counts
select 'triggit', 'desktop', 'targeting group', 'clicks', 'monthly',
	date_trunc('month', clks.time_stamp)::date, targeting_group_id, count(distinct clks.user_id)
from clks
where clks.time_stamp >= '2015-08-01' and clks.time_stamp < '2015-11-01'
group by date_trunc('month', clks.time_stamp)::date, targeting_group_id;

-- Insert *targeting group* *conversions* by *daily*
INSERT INTO unique_user_counts
select 'triggit', 'desktop', 'targeting group', 'conversions', 'daily',
	clkconvs.time_stamp::date, targeting_group_id, count(distinct clkconvs.user_id)
from clkconvs
where clkconvs.time_stamp >= '2015-08-01' and clkconvs.time_stamp < '2015-11-01'
group by clkconvs.time_stamp::date, targeting_group_id;

-- Insert *targeting group* *conversions* by *weekly*
INSERT INTO unique_user_counts
select 'triggit', 'desktop', 'targeting group', 'conversions', 'weekly',
	date_trunc('week', clkconvs.time_stamp)::date, targeting_group_id, count(distinct clkconvs.user_id)
from clkconvs
where clkconvs.time_stamp >= '2015-08-01' and clkconvs.time_stamp < '2015-11-01'
group by date_trunc('week', clkconvs.time_stamp)::date, targeting_group_id;

-- Insert *targeting group* *conversions* by *monthly*
INSERT INTO unique_user_counts
select 'triggit', 'desktop', 'targeting group', 'conversions', 'monthly',
	date_trunc('month', clkconvs.time_stamp)::date, targeting_group_id, count(distinct clkconvs.user_id)
from clkconvs
where clkconvs.time_stamp >= '2015-08-01' and clkconvs.time_stamp < '2015-11-01'
group by date_trunc('month', clkconvs.time_stamp)::date, targeting_group_id;

--************************************************************************************************
--************************************************************************************************
DROP TABLE IF EXISTS unique_user_counts CASCADE;

rollback
CREATE TABLE unique_user_counts
(
    date_stamp      date,
    platform        varchar(16),
    channel         varchar(16),
    level           varchar(16),
    metric          varchar(16),
    period          varchar(16),
    id              integer,
	name            varchar(256),
    uu_count        bigint
);

-- advertiser**********************************
-- Insert *advertiser* *impressions* by *daily*
INSERT INTO unique_user_counts
select	buys.time_stamp::date, 
		'triggit', 'desktop', 'advertiser', 'impressions', 'daily',
		advertiser_id, advertiser_name, count(distinct buys.user_id)
from buys 
	left join pg_campaigns on pg_campaigns.id = buys.campaign_id
	left join pg_advertisers on account_id = pg_campaigns.user_id
where buys.time_stamp >= '2015-08-01' and buys.time_stamp < '2015-11-01'
group by buys.time_stamp::date, advertiser_id, advertiser_name;

-- Insert *advertiser* *impressions* by *weekly*
INSERT INTO unique_user_counts
select	date_trunc('week', buys.time_stamp)::date,
		'triggit', 'desktop', 'advertiser', 'impressions', 'weekly',
		advertiser_id, advertiser_name, count(distinct buys.user_id)
from buys 
	left join pg_campaigns on pg_campaigns.id = buys.campaign_id
	left join pg_advertisers on account_id = pg_campaigns.user_id
where buys.time_stamp >= '2015-08-01' and buys.time_stamp < '2015-11-01'
group by date_trunc('week', buys.time_stamp)::date, advertiser_id, advertiser_name;

-- Insert *advertiser* *impressions* by *monthly*
INSERT INTO unique_user_counts
select	date_trunc('month', buys.time_stamp)::date,
		'triggit', 'desktop', 'advertiser', 'impressions', 'monthly',
		advertiser_id, advertiser_name, count(distinct buys.user_id)
from buys 
	left join pg_campaigns on pg_campaigns.id = buys.campaign_id
	left join pg_advertisers on account_id = pg_campaigns.user_id
where buys.time_stamp >= '2015-08-01' and buys.time_stamp < '2015-11-01'
group by date_trunc('month', buys.time_stamp)::date, advertiser_id, advertiser_name;

-- Insert *advertiser* *clicks* by *daily*
INSERT INTO unique_user_counts
select	clks.time_stamp::date, 
		'triggit', 'desktop', 'advertiser', 'clicks', 'daily',
		advertiser_id, advertiser_name, count(distinct clks.user_id)
from clks 
	left join pg_campaigns on pg_campaigns.id = clks.campaign_id
	left join pg_advertisers on account_id = pg_campaigns.user_id
where clks.time_stamp >= '2015-08-01' and clks.time_stamp < '2015-11-01'
group by clks.time_stamp::date, advertiser_id, advertiser_name;

-- Insert *advertiser* *clicks* by *weekly*
INSERT INTO unique_user_counts
select	date_trunc('week', clks.time_stamp)::date,
		'triggit', 'desktop', 'advertiser', 'clicks', 'weekly',
		advertiser_id, advertiser_name, count(distinct clks.user_id)
from clks 
	left join pg_campaigns on pg_campaigns.id = clks.campaign_id
	left join pg_advertisers on account_id = pg_campaigns.user_id
where clks.time_stamp >= '2015-08-01' and clks.time_stamp < '2015-11-01'
group by date_trunc('week', clks.time_stamp)::date, advertiser_id, advertiser_name;

-- Insert *advertiser* *clicks* by *monthly*
INSERT INTO unique_user_counts
select	date_trunc('month', clks.time_stamp)::date,
		'triggit', 'desktop', 'advertiser', 'clicks', 'monthly',
		advertiser_id, advertiser_name, count(distinct clks.user_id)
from clks 
	left join pg_campaigns on pg_campaigns.id = clks.campaign_id
	left join pg_advertisers on account_id = pg_campaigns.user_id
where clks.time_stamp >= '2015-08-01' and clks.time_stamp < '2015-11-01'
group by date_trunc('month', clks.time_stamp)::date, advertiser_id, advertiser_name;

-- Insert *advertiser* *conversions* by *daily*
INSERT INTO unique_user_counts
select	clkconvs.time_stamp::date, 
		'triggit', 'desktop', 'advertiser', 'conversions', 'daily',
		advertiser_id, advertiser_name, count(distinct clkconvs.user_id)
from clkconvs 
	left join pg_campaigns on pg_campaigns.id = clkconvs.campaign_id
	left join pg_advertisers on account_id = pg_campaigns.user_id
where clkconvs.time_stamp >= '2015-08-01' and clkconvs.time_stamp < '2015-11-01'
group by clkconvs.time_stamp::date, advertiser_id, advertiser_name;

-- Insert *advertiser* *conversions* by *weekly*
INSERT INTO unique_user_counts
select	date_trunc('week', clkconvs.time_stamp)::date,
		'triggit', 'desktop', 'advertiser', 'conversions', 'weekly',
		advertiser_id, advertiser_name, count(distinct clkconvs.user_id)
from clkconvs 
	left join pg_campaigns on pg_campaigns.id = clkconvs.campaign_id
	left join pg_advertisers on account_id = pg_campaigns.user_id
where clkconvs.time_stamp >= '2015-08-01' and clkconvs.time_stamp < '2015-11-01'
group by date_trunc('week', clkconvs.time_stamp)::date, advertiser_id, advertiser_name;

-- Insert *advertiser* *conversions* by *monthly*
INSERT INTO unique_user_counts
select	date_trunc('month', clkconvs.time_stamp)::date,
		'triggit', 'desktop', 'advertiser', 'conversions', 'monthly',
		advertiser_id, advertiser_name, count(distinct clkconvs.user_id)
from clkconvs 
	left join pg_campaigns on pg_campaigns.id = clkconvs.campaign_id
	left join pg_advertisers on account_id = pg_campaigns.user_id
where clkconvs.time_stamp >= '2015-08-01' and clkconvs.time_stamp < '2015-11-01'
group by date_trunc('month', clkconvs.time_stamp)::date, advertiser_id, advertiser_name;

-- account**********************************
-- Insert *account* *impressions* by *daily*
INSERT INTO unique_user_counts
select	buys.time_stamp::date, 
		'triggit', 'desktop', 'account', 'impressions', 'daily',
		pg_advertisers.account_id, pg_advertisers.account_name, count(distinct buys.user_id)
from buys 
	left join pg_campaigns on pg_campaigns.id = buys.campaign_id
	left join pg_advertisers on pg_advertisers.account_id = pg_campaigns.user_id
where buys.time_stamp >= '2015-08-01' and buys.time_stamp < '2015-11-01'
group by buys.time_stamp::date, pg_advertisers.account_id, pg_advertisers.account_name;

-- Insert *account* *impressions* by *weekly*
INSERT INTO unique_user_counts
select	date_trunc('week', buys.time_stamp)::date,
		'triggit', 'desktop', 'account', 'impressions', 'weekly',
		pg_advertisers.account_id, pg_advertisers.account_name, count(distinct buys.user_id)
from buys 
	left join pg_campaigns on pg_campaigns.id = buys.campaign_id
	left join pg_advertisers on pg_advertisers.account_id = pg_campaigns.user_id
where buys.time_stamp >= '2015-08-01' and buys.time_stamp < '2015-11-01'
group by date_trunc('week', buys.time_stamp)::date, pg_advertisers.account_id, pg_advertisers.account_name;

-- Insert *account* *impressions* by *monthly*
INSERT INTO unique_user_counts
select	date_trunc('month', buys.time_stamp)::date,
		'triggit', 'desktop', 'account', 'impressions', 'monthly',
		pg_advertisers.account_id, pg_advertisers.account_name, count(distinct buys.user_id)
from buys 
	left join pg_campaigns on pg_campaigns.id = buys.campaign_id
	left join pg_advertisers on pg_advertisers.account_id = pg_campaigns.user_id
where buys.time_stamp >= '2015-08-01' and buys.time_stamp < '2015-11-01'
group by date_trunc('month', buys.time_stamp)::date, pg_advertisers.account_id, pg_advertisers.account_name;

-- Insert *account* *clicks* by *daily*
INSERT INTO unique_user_counts
select	clks.time_stamp::date, 
		'triggit', 'desktop', 'account', 'clicks', 'daily',
		pg_advertisers.account_id, pg_advertisers.account_name, count(distinct clks.user_id)
from clks 
	left join pg_campaigns on pg_campaigns.id = clks.campaign_id
	left join pg_advertisers on pg_advertisers.account_id = pg_campaigns.user_id
where clks.time_stamp >= '2015-08-01' and clks.time_stamp < '2015-11-01'
group by clks.time_stamp::date, pg_advertisers.account_id, pg_advertisers.account_name;

-- Insert *account* *clicks* by *weekly*
INSERT INTO unique_user_counts
select	date_trunc('week', clks.time_stamp)::date,
		'triggit', 'desktop', 'account', 'clicks', 'weekly',
		pg_advertisers.account_id, pg_advertisers.account_name, count(distinct clks.user_id)
from clks 
	left join pg_campaigns on pg_campaigns.id = clks.campaign_id
	left join pg_advertisers on pg_advertisers.account_id = pg_campaigns.user_id
where clks.time_stamp >= '2015-08-01' and clks.time_stamp < '2015-11-01'
group by date_trunc('week', clks.time_stamp)::date, pg_advertisers.account_id, pg_advertisers.account_name;

-- Insert *account* *clicks* by *monthly*
INSERT INTO unique_user_counts
select	date_trunc('month', clks.time_stamp)::date,
		'triggit', 'desktop', 'account', 'clicks', 'monthly',
		pg_advertisers.account_id, pg_advertisers.account_name, count(distinct clks.user_id)
from clks 
	left join pg_campaigns on pg_campaigns.id = clks.campaign_id
	left join pg_advertisers on pg_advertisers.account_id = pg_campaigns.user_id
where clks.time_stamp >= '2015-08-01' and clks.time_stamp < '2015-11-01'
group by date_trunc('month', clks.time_stamp)::date, pg_advertisers.account_id, pg_advertisers.account_name;

-- Insert *account* *conversions* by *daily*
INSERT INTO unique_user_counts
select	clkconvs.time_stamp::date, 
		'triggit', 'desktop', 'account', 'conversions', 'daily',
		pg_advertisers.account_id, pg_advertisers.account_name, count(distinct clkconvs.user_id)
from clkconvs 
	left join pg_campaigns on pg_campaigns.id = clkconvs.campaign_id
	left join pg_advertisers on pg_advertisers.account_id = pg_campaigns.user_id
where clkconvs.time_stamp >= '2015-08-01' and clkconvs.time_stamp < '2015-11-01'
group by clkconvs.time_stamp::date, pg_advertisers.account_id, pg_advertisers.account_name;

-- Insert *account* *conversions* by *weekly*
INSERT INTO unique_user_counts
select	date_trunc('week', clkconvs.time_stamp)::date,
		'triggit', 'desktop', 'account', 'conversions', 'weekly',
		pg_advertisers.account_id, pg_advertisers.account_name, count(distinct clkconvs.user_id)
from clkconvs 
	left join pg_campaigns on pg_campaigns.id = clkconvs.campaign_id
	left join pg_advertisers on pg_advertisers.account_id = pg_campaigns.user_id
where clkconvs.time_stamp >= '2015-08-01' and clkconvs.time_stamp < '2015-11-01'
group by date_trunc('week', clkconvs.time_stamp)::date, pg_advertisers.account_id, pg_advertisers.account_name;

-- Insert *account* *conversions* by *monthly*
INSERT INTO unique_user_counts
select	date_trunc('month', clkconvs.time_stamp)::date,
		'triggit', 'desktop', 'account', 'conversions', 'monthly',
		pg_advertisers.account_id, pg_advertisers.account_name, count(distinct clkconvs.user_id)
from clkconvs 
	left join pg_campaigns on pg_campaigns.id = clkconvs.campaign_id
	left join pg_advertisers on pg_advertisers.account_id = pg_campaigns.user_id
where clkconvs.time_stamp >= '2015-08-01' and clkconvs.time_stamp < '2015-11-01'
group by date_trunc('month', clkconvs.time_stamp)::date, pg_advertisers.account_id, pg_advertisers.account_name;

-- campaign**********************************
-- Insert *campaign* *impressions* by *daily*
INSERT INTO unique_user_counts
select	buys.time_stamp::date, 
		'triggit', 'desktop', 'campaign', 'impressions', 'daily',
		campaign_id, description, count(distinct buys.user_id)
from buys 
	left join pg_campaigns on pg_campaigns.id = buys.campaign_id
where buys.time_stamp >= '2015-08-01' and buys.time_stamp < '2015-11-01'
group by buys.time_stamp::date, campaign_id, description;

-- Insert *campaign* *impressions* by *weekly*
INSERT INTO unique_user_counts
select	date_trunc('week', buys.time_stamp)::date,
		'triggit', 'desktop', 'campaign', 'impressions', 'weekly',
		campaign_id, description, count(distinct buys.user_id)
from buys 
	left join pg_campaigns on pg_campaigns.id = buys.campaign_id
where buys.time_stamp >= '2015-08-01' and buys.time_stamp < '2015-11-01'
group by date_trunc('week', buys.time_stamp)::date, campaign_id, description;

-- Insert *campaign* *impressions* by *monthly*
INSERT INTO unique_user_counts
select	date_trunc('month', buys.time_stamp)::date,
		'triggit', 'desktop', 'campaign', 'impressions', 'monthly',
		campaign_id, description, count(distinct buys.user_id)
from buys 
	left join pg_campaigns on pg_campaigns.id = buys.campaign_id
where buys.time_stamp >= '2015-08-01' and buys.time_stamp < '2015-11-01'
group by date_trunc('month', buys.time_stamp)::date, campaign_id, description;

-- Insert *campaign* *clicks* by *daily*
INSERT INTO unique_user_counts
select	clks.time_stamp::date, 
		'triggit', 'desktop', 'campaign', 'clicks', 'daily',
		campaign_id, description, count(distinct clks.user_id)
from clks 
	left join pg_campaigns on pg_campaigns.id = clks.campaign_id	 
where clks.time_stamp >= '2015-08-01' and clks.time_stamp < '2015-11-01'
group by clks.time_stamp::date, campaign_id, description;

-- Insert *campaign* *clicks* by *weekly*
INSERT INTO unique_user_counts
select	date_trunc('week', clks.time_stamp)::date,
		'triggit', 'desktop', 'campaign', 'clicks', 'weekly',
		campaign_id, description, count(distinct clks.user_id)
from clks 
	left join pg_campaigns on pg_campaigns.id = clks.campaign_id
where clks.time_stamp >= '2015-08-01' and clks.time_stamp < '2015-11-01'
group by date_trunc('week', clks.time_stamp)::date, campaign_id, description;

-- Insert *campaign* *clicks* by *monthly*
INSERT INTO unique_user_counts
select	date_trunc('month', clks.time_stamp)::date,
		'triggit', 'desktop', 'campaign', 'clicks', 'monthly',
		campaign_id, description, count(distinct clks.user_id)
from clks 
	left join pg_campaigns on pg_campaigns.id = clks.campaign_id 
where clks.time_stamp >= '2015-08-01' and clks.time_stamp < '2015-11-01'
group by date_trunc('month', clks.time_stamp)::date, campaign_id, description;

-- Insert *campaign* *conversions* by *daily*
INSERT INTO unique_user_counts
select	clkconvs.time_stamp::date, 
		'triggit', 'desktop', 'campaign', 'conversions', 'daily',
		campaign_id, description, count(distinct clkconvs.user_id)
from clkconvs 
	left join pg_campaigns on pg_campaigns.id = clkconvs.campaign_id
where clkconvs.time_stamp >= '2015-08-01' and clkconvs.time_stamp < '2015-11-01'
group by clkconvs.time_stamp::date, campaign_id, description;

-- Insert *campaign* *conversions* by *weekly*
INSERT INTO unique_user_counts
select	date_trunc('week', clkconvs.time_stamp)::date,
		'triggit', 'desktop', 'campaign', 'conversions', 'weekly',
		campaign_id, description, count(distinct clkconvs.user_id)
from clkconvs 
	left join pg_campaigns on pg_campaigns.id = clkconvs.campaign_id	 
where clkconvs.time_stamp >= '2015-08-01' and clkconvs.time_stamp < '2015-11-01'
group by date_trunc('week', clkconvs.time_stamp)::date, campaign_id, description;

-- Insert *campaign* *conversions* by *monthly*
INSERT INTO unique_user_counts
select	date_trunc('month', clkconvs.time_stamp)::date,
		'triggit', 'desktop', 'campaign', 'conversions', 'monthly',
		campaign_id, description, count(distinct clkconvs.user_id)
from clkconvs 
	left join pg_campaigns on pg_campaigns.id = clkconvs.campaign_id
where clkconvs.time_stamp >= '2015-08-01' and clkconvs.time_stamp < '2015-11-01'
group by date_trunc('month', clkconvs.time_stamp)::date, campaign_id, description;

-- targeting group**********************************
-- Insert *targeting group* *impressions* by *daily*
INSERT INTO unique_user_counts
select	buys.time_stamp::date, 
		'triggit', 'desktop', 'targeting group', 'impressions', 'daily',
		targeting_group_id, description, count(distinct buys.user_id)
from buys 
	left join pg_targeting_groups on pg_targeting_groups.id = buys.targeting_group_id
where buys.time_stamp >= '2015-08-01' and buys.time_stamp < '2015-11-01'
group by buys.time_stamp::date, targeting_group_id, description;

-- Insert *targeting group* *impressions* by *weekly*
INSERT INTO unique_user_counts
select	date_trunc('week', buys.time_stamp)::date,
		'triggit', 'desktop', 'targeting group', 'impressions', 'weekly',
		targeting_group_id, description, count(distinct buys.user_id)
from buys 
	left join pg_targeting_groups on pg_targeting_groups.id = buys.targeting_group_id
where buys.time_stamp >= '2015-08-01' and buys.time_stamp < '2015-11-01'
group by date_trunc('week', buys.time_stamp)::date, targeting_group_id, description;

-- Insert *targeting group* *impressions* by *monthly*
INSERT INTO unique_user_counts
select	date_trunc('month', buys.time_stamp)::date,
		'triggit', 'desktop', 'targeting group', 'impressions', 'monthly',
		targeting_group_id, description, count(distinct buys.user_id)
from buys 
	left join pg_targeting_groups on pg_targeting_groups.id = buys.targeting_group_id
where buys.time_stamp >= '2015-08-01' and buys.time_stamp < '2015-11-01'
group by date_trunc('month', buys.time_stamp)::date, targeting_group_id, description;

-- Insert *targeting group* *clicks* by *daily*
INSERT INTO unique_user_counts
select	clks.time_stamp::date, 
		'triggit', 'desktop', 'targeting group', 'clicks', 'daily',
		targeting_group_id, description, count(distinct clks.user_id)
from clks 
	left join pg_targeting_groups on pg_targeting_groups.id = clks.targeting_group_id	 
where clks.time_stamp >= '2015-08-01' and clks.time_stamp < '2015-11-01'
group by clks.time_stamp::date, targeting_group_id, description;

-- Insert *targeting group* *clicks* by *weekly*
INSERT INTO unique_user_counts
select	date_trunc('week', clks.time_stamp)::date,
		'triggit', 'desktop', 'targeting group', 'clicks', 'weekly',
		targeting_group_id, description, count(distinct clks.user_id)
from clks 
	left join pg_targeting_groups on pg_targeting_groups.id = clks.targeting_group_id
where clks.time_stamp >= '2015-08-01' and clks.time_stamp < '2015-11-01'
group by date_trunc('week', clks.time_stamp)::date, targeting_group_id, description;

-- Insert *targeting group* *clicks* by *monthly*
INSERT INTO unique_user_counts
select	date_trunc('month', clks.time_stamp)::date,
		'triggit', 'desktop', 'targeting group', 'clicks', 'monthly',
		targeting_group_id, description, count(distinct clks.user_id)
from clks 
	left join pg_targeting_groups on pg_targeting_groups.id = clks.targeting_group_id 
where clks.time_stamp >= '2015-08-01' and clks.time_stamp < '2015-11-01'
group by date_trunc('month', clks.time_stamp)::date, targeting_group_id, description;

-- Insert *targeting group* *conversions* by *daily*
INSERT INTO unique_user_counts
select	clkconvs.time_stamp::date, 
		'triggit', 'desktop', 'targeting group', 'conversions', 'daily',
		targeting_group_id, description, count(distinct clkconvs.user_id)
from clkconvs 
	left join pg_targeting_groups on pg_targeting_groups.id = clkconvs.targeting_group_id
where clkconvs.time_stamp >= '2015-08-01' and clkconvs.time_stamp < '2015-11-01'
group by clkconvs.time_stamp::date, targeting_group_id, description;

-- Insert *targeting group* *conversions* by *weekly*
INSERT INTO unique_user_counts
select	date_trunc('week', clkconvs.time_stamp)::date,
		'triggit', 'desktop', 'targeting group', 'conversions', 'weekly',
		targeting_group_id, description, count(distinct clkconvs.user_id)
from clkconvs 
	left join pg_targeting_groups on pg_targeting_groups.id = clkconvs.targeting_group_id	 
where clkconvs.time_stamp >= '2015-08-01' and clkconvs.time_stamp < '2015-11-01'
group by date_trunc('week', clkconvs.time_stamp)::date, targeting_group_id, description;

-- Insert *targeting group* *conversions* by *monthly*
INSERT INTO unique_user_counts
select	date_trunc('month', clkconvs.time_stamp)::date,
		'triggit', 'desktop', 'targeting group', 'conversions', 'monthly',
		targeting_group_id, description, count(distinct clkconvs.user_id)
from clkconvs 
	left join pg_targeting_groups on pg_targeting_groups.id = clkconvs.targeting_group_id
where clkconvs.time_stamp >= '2015-08-01' and clkconvs.time_stamp < '2015-11-01'
group by date_trunc('month', clkconvs.time_stamp)::date, targeting_group_id, description;
