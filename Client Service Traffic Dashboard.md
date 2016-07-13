# Client Service Traffic Dashboard
---
#### Traffic data of Product 1 in Redshift
```sql
SELECT
	padded_traffic_reports.import_time_stamp::DATE AS date_stamp,
		analytics.pg_advertisers.advertiser_id AS advertiser_id,
		analytics.pg_advertisers.advertiser_name AS advertiser_name,
		analytics.pg_advertisers.account_id AS account_id,
		analytics.pg_advertisers.account_name AS account_name,
	pg_campaigns.id AS campaign_id,
	pg_campaigns.description AS campaign_name,
	pg_targeting_groups.id AS targeting_group_id,
	pg_targeting_groups.description AS targeting_group_name,
	CASE pg_targeting_groups.otto_disabled
		WHEN TRUE THEN 'No'
		WHEN FALSE THEN 'Yes'
	END AS otto_obey,
	padded_traffic_reports.impressions AS impressions,
	padded_traffic_reports.clicks AS clicks,
	padded_traffic_reports.click_through_conversions AS conversions,
	padded_traffic_reports.media_cost AS media_cost,
	-- Calculate revenue
	CASE upper(pg_billing_reports.payout_type)
		WHEN 'FEE' THEN padded_traffic_reports.media_cost*(1+pg_billing_reports.payout_value)/pg_billing_reports.exchange_rate
		WHEN 'CPC' THEN padded_traffic_reports.clicks*pg_billing_reports.payout_value/pg_billing_reports.exchange_rate
		WHEN 'CPA - PER CONVERSION' THEN padded_traffic_reports.click_through_conversions*pg_billing_reports.payout_value/pg_billing_reports.exchange_rate
	END AS revenue
FROM padded_traffic_reports
	LEFT JOIN analytics.pg_advertisers
		ON (padded_traffic_reports.account_id = analytics.pg_advertisers.account_id)
	LEFT JOIN pg_campaigns
		ON (padded_traffic_reports.campaign_id = pg_campaigns.id)
	LEFT JOIN pg_targeting_groups
		ON (padded_traffic_reports.targeting_group_id = pg_targeting_groups.id)
	LEFT JOIN pg_billing_reports
		ON (padded_traffic_reports.campaign_id = pg_billing_reports.campaign_id
		AND padded_traffic_reports.import_time_stamp::DATE = pg_billing_reports.DATE_stamp);
```
#### Traffic data of Product 2 in MS SQL Server
```sql
SELECT
	fb_campaigns_statistics_consolidated.DATE AS date_stamp,
	users.id AS advertiser_id,
	CASE users.id
        WHEN 1188 THEN 'MRV'
        ELSE users.company
    END AS advertiser_name,
    fb_accounts.id AS account_id,
    fb_accounts.name AS account_name,
    fb_campaign_group.id AS campaign_id,
    fb_campaign_group.name AS campaign_name,
    fb_campaigns.id AS targeting_group_id,
    fb_campaigns.name AS targeting_group_name,
    impressions,
    clicks,
    actions AS conversions,
 	spent*0.01*ex_rate AS media_cost,
	-- Calculate revenue
	CASE payout_type
        WHEN 'CPC' THEN clicks*payout_value
        WHEN 'CPA' THEN actions*payout_value
        WHEN 'Fee' THEN spent*0.01*ex_rate*(1+payout_value)
        WHEN 'Flat' THEN spent*0.01*ex_rate+(payout_value*100000/DATEPART(day, EOMONTH(fb_campaigns_statistics_consolidated.DATE)))/temp.nrow*0.00001
    END AS revenue
FROM fb_campaigns_statistics_consolidated
	LEFT JOIN fb_campaigns
		ON fb_campaigns.id = fb_campaigns_statistics_consolidated.campaignId
	LEFT JOIN fb_campaign_group
		ON fb_campaign_group.id = fb_campaigns.campaignGroupId
    LEFT JOIN fb_accounts
		ON fb_accounts.id = fb_campaign_group.accountId
    LEFT JOIN users
		ON users.id = fb_accounts.userId
    LEFT JOIN fb_payouts
		ON fb_payouts.account_id = fb_accounts.id
	LEFT JOIN ex_rates
		ON ex_rates.currencyCode = fb_accounts.currencyCode
	-- Join the sub-query to count number for rows for each active advertisers
    LEFT JOIN (
        SELECT
            fb_campaigns_statistics_consolidated.DATE AS date_stamp,
            fb_campaigns.accountId,
            count(*) AS nrow
        FROM fb_campaigns_statistics_consolidated
            LEFT JOIN fb_campaigns
				ON fb_campaigns.id = fb_campaigns_statistics_consolidated.campaignId
        WHERE (impressions + clicks + spent + actions > 0 and campaignId > 0)
		GROUP BY fb_campaigns_statistics_consolidated.DATE, fb_campaigns.accountId
		) temp;
```
#### Traffic data of Product 3 in MySQL
```sql
-- Clicks
SELECT 
	DATE(created) AS date_stamp, 
	campaign_id, 
	COUNT(*) AS clicks
FROM leadgm_campaignevent
WHERE campaign_id > 0
GROUP BY DATE(created), campaign_id;
-- Conversions
SELECT 
	DATE(created) AS date_stamp, 
	campaign_id, 
	COUNT(*) AS conversions
FROM leadgm_lead
WHERE campaign_id > 0
GROUP BY DATE(created), campaign_id;
-- Campaign id name
SELECT 
	leadgm_campaign.user_id AS account_id, 
	company AS account_name, 
	id AS campaign_id, 
	name AS campaign_name
FROM leadgm_campaign 
	LEFT JOIN leadgm_userprofile USING (user_id);
```
#### Snapshot of Tableau dashboard
![](https://github.com/alichenxiang/custom-sql-in-tableau/blob/master/image/Client%20Service%20Traffic%20Dashboard.png)
