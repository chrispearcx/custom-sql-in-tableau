# Custom SQL in Tableau
---
##### Client Service Traffic Dashboard
```sql
SELECT
	padded_traffic_reports.import_time_stamp::date AS date_stamp,
		analytics.pg_advertisers.advertiser_id AS advertiser_id,
		analytics.pg_advertisers.advertiser_name AS advertiser_name,
		analytics.pg_advertisers.account_id AS account_id,
		analytics.pg_advertisers.account_name AS account_name,
	pg_campaigns.id as campaign_id,
	pg_campaigns.description as campaign_name,
	pg_targeting_groups.id as targeting_group_id,
	pg_targeting_groups.description as targeting_group_name,
	case public.pg_targeting_groups.otto_disabled
		when TRUE then 'No'
		when FALSE then 'Yes'
	end as otto_obey,
	padded_traffic_reports.impressions AS impressions,
	padded_traffic_reports.clicks AS clicks,
	padded_traffic_reports.click_through_conversions AS conversions,
	padded_traffic_reports.media_cost AS media_cost,
	case upper(public.pg_billing_reports.payout_type)
		when 'FEE' THEN padded_traffic_reports.media_cost*(1+pg_billing_reports.payout_value)/pg_billing_reports.exchange_rate
		when 'CPC' THEN padded_traffic_reports.clicks*pg_billing_reports.payout_value/pg_billing_reports.exchange_rate
		when 'CPA - PER CONVERSION' THEN padded_traffic_reports.click_through_conversions*pg_billing_reports.payout_value/pg_billing_reports.exchange_rate
	end as revenue
FROM padded_traffic_reports
	left join analytics.pg_advertisers
		on (padded_traffic_reports.account_id = analytics.pg_advertisers.account_id)
	left join pg_campaigns
		on (padded_traffic_reports.campaign_id = pg_campaigns.id)
	LEFT JOIN pg_targeting_groups
		on (padded_traffic_reports.targeting_group_id = pg_targeting_groups.id)
	LEFT JOIN public.pg_billing_reports
		ON (padded_traffic_reports.campaign_id = pg_billing_reports.campaign_id
			and padded_traffic_reports.import_time_stamp::date = pg_billing_reports.date_stamp);
```
