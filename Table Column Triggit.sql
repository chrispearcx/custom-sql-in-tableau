auction_aggregates(import_time_stamp,account_email,account_id,targeting_group_id,page_type,max_cpm,freq_cap_daily,fixed_cpm,max_cpm_off_peak,product_fatigue_cap,auctions_seen,unique_users_seen,auctions_bid_on,unique_users_bid,impressions_bought,unique_users_bought,cost,number_of_clicks,recency_days_since_fv,news_feed_max_cpm,enable_recommender,enable_optimizer)

auction_disquals_aggregates(date_stamp,targeting_group_id,reason,cnt)

buys(time_stamp,import_time_stamp,site,offer_id,cpm,user_id,ip,exchange_code,auction_id,above_the_fold,tag_id,campaign_id,time_stamp_unix,bid,targeting_group_id,ad_width,ad_height,user_agent,fb_page_type,user_id_on_impdata,user_id_on_webreq,campaign_recency,fb_page_position,fb_creative_ad_group_id,is_recommendation,ppk_dosage,ppk_rvls,recommender_version,is_match_extended_user,is_nf_rdac,cpi_micros,ppk,is_recommendation_front_of_curve,is_recommendation_back_of_curve,beta,version,click_url,hostname,model_version,total_campaign_dosage,total_tg_dosage,total_ppk_dosage,daily_campaign_dosage,daily_tg_dosage,daily_ppk_dosage,hourly_campaign_dosage,hourly_tg_dosage,hourly_ppk_dosage,tg_impression_recency,ppk_impression_recency,cart_recency,total_clicks,total_campaign_clicks,total_tg_clicks,total_click_conversions,total_campaign_click_conversions,dma,city,state,country,zip)

clks(time_stamp, import_time_stamp, site, offer_id, user_id, auction_id, above_the_fold, tag_id, ip, page_url, impression_time_stamp, campaign_id, exchange_code, fb_page_type, ad_width, ad_height, campaign_recency, targeting_group_id, time_stamp_unix, is_recommendation, ppk_dosage, ppk_rvls, recommender_version, user_agent, is_nf_rdac, ppk, is_recommendation_front_of_curve, is_recommendation_back_of_curve, beta, version, hostname, model_version, total_campaign_dosage, total_tg_dosage, total_ppk_dosage, daily_campaign_dosage, daily_tg_dosage, daily_ppk_dosage, hourly_campaign_dosage, hourly_tg_dosage, hourly_ppk_dosage, tg_impression_recency, ppk_impression_recency, cart_recency, total_clicks, total_campaign_clicks, total_tg_clicks, total_click_conversions, total_campaign_click_conversions, dma, city, state, country, zip)

clkconvs (time_stamp, import_time_stamp, tag_id, user_id, conversion_values, site, clicked_at, offer_id, above_the_fold, ad_width, ad_height, campaign_recency, campaign_id, ctval1, ctval2, ctval3, ctval4, targeting_group_id, impression_time_stamp, time_stamp_unix, auction_id, is_recommendation, ppk_dosage, ppk_rvls, recommender_version, is_nf_rdac, ppk, is_recommendation_front_of_curve, is_recommendation_back_of_curve, exchange_code, version, hostname, model_version, total_campaign_dosage, total_tg_dosage, total_ppk_dosage, daily_campaign_dosage, daily_tg_dosage, daily_ppk_dosage, hourly_campaign_dosage, hourly_tg_dosage, hourly_ppk_dosage, tg_impression_recency, ppk_impression_recency, cart_recency, total_clicks, total_campaign_clicks, total_tg_clicks, total_click_conversions, total_campaign_click_conversions, dma, city, state, country, zip)

convs (time_stamp, import_time_stamp, tag_id, user_id, conversion_values, ctval1, ctval2, ctval3, ctval4, time_stamp_unix, is_click, referrer, version, hostname, ppks, dma, city, state, country, zip)

exchange_syncs(time_stamp,import_time_stamp,user_id,ip,exchange_code,exchange_user_id,user_match_status,version,hostname,google_error_code)

padded_traffic_reports(time_stamp,import_time_stamp,account_id,campaign_id,targeting_group_id,impressions,clicks,media_cost,click_through_conversions,week_of_year,media_cost_micros)

pg_advertisers(advertiser_id,advertiser_name,account_id,account_name,campaign_id,campaign_name,targeting_group_id,targeting_group_name,provider_id)

pg_billing_reports(id,account_id,campaign_id,impressions,clicks,click_through_conversions,media_cost,date_stamp,payout_type,payout_value,payout_time,billing_usd,currency,exchange_rate,billings_localcurrency,client_clicks,client_conversions,client_revenue_share,billing_data_source,billing_relationship)

pg_campaigns(id,description,user_id,start_date,end_date)

pg_data_providers(id,updated_at,column_family)

pg_data_providers_targeting_groups(id,data_provider_id,targeting_group_id)

pg_targeting_groups(id,description,max_cpm,freq_cap_daily,freq_cap_total,user_id,campaign_id,triggit_fee,fixed_cpm,freq_cap_hourly,max_cpm_off_peak,product_fatigue_cap,recency_days_since_fv,news_feed_max_cpm,enable_recommender,enable_optimizer,user_query,exchange_filter,tnx_ecpc,otto_obey_full_user_query,target_cpa,otto_disabled,target_cpc)

pg_users(id, email)

pixel_ag(date,provider_id[column_family in other tables],pixel_volume)

sotto(time_stamp,targeting_group_id,model_version_raw,bids,imps,clks,clkconvs,cost,fb_page_type,otto_obey_full_user_query,payout_type,currency,account_email,payout_value,revenue,margin,otto_disabled,exchange_code)

rt_pixels_aggregate(date_stamp,provider_id[column_family in other tables],uu_pixeled)

rt_pixels(time_stamp,import_time_stamp,time_stamp_unix,user_id,provider_id[column_family in other tables],segment,pixel_key,value,user_agent,ip,version,hostname,ppk_type)
