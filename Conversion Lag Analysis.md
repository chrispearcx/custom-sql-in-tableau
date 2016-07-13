# Click-through-conversion lags analysis
---
#### Calculate how long a Click-through-conversion occurred after the corresponding impression.
```sql
SELECT
    buys.time_stamp::DATE AS date_stamp,
        analytics.pg_advertisers.advertiser_id AS advertiser_id,
        analytics.pg_advertisers.advertiser_name AS advertiser_name,
        analytics.pg_advertisers.account_id AS account_id,
        analytics.pg_advertisers.account_name AS account_name,
    pg_campaigns.id AS campaign_id,
    pg_campaigns.description AS campaign_name,
    pg_targeting_groups.id AS targeting_group_id,
    pg_targeting_groups.description AS targeting_group_name,
    DATEDIFF(hour, buys.time_stamp, clkconvs.time_stamp) AS convlags
FROM buys
    JOIN clkconvs
        ON (buys.user_id = clkconvs.user_id AND buys.auction_id = clkconvs.auction_id)
    LEFT JOIN pg_targeting_groups
        ON pg_targeting_groups.id = buys.targeting_group_id
    LEFT JOIN pg_campaigns
        ON pg_campaigns.id = pg_targeting_groups.campaign_id
    LEFT JOIN analytics.pg_advertisers
        ON analytics.pg_advertisers.account_id = pg_campaigns.user_id;
```

