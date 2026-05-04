-- Query 1: Define sales funnel stages
With funnel_stages AS (
  SELECT
    count(distinct case when event_type = 'page_view' then user_id END) as stage_1_views,
    count(distinct case when event_type = 'add_to_cart' then user_id END) as stage_2_cart,
    count(distinct case when event_type = 'checkout_start' then user_id END) as stage_3_checkout,
    count(distinct case when event_type = 'payment_info' then user_id END) as stage_4_payment,
    count(distinct case when event_type = 'purchase' then user_id END) as stage_5_purchase

  FROM `stellar-cipher-476303-v7.sql_practice.users_events`
  WHERE event_date >= TIMESTAMP('2026-01-11') 
  AND event_date <= TIMESTAMP('2026-02-10')
)

SELECT * FROM funnel_stages;


-- Query 2: Conversion rates through funnel
With funnel_stages AS (
  SELECT
    count(distinct case when event_type = 'page_view' then user_id END) as stage_1_views,
    count(distinct case when event_type = 'add_to_cart' then user_id END) as stage_2_cart,
    count(distinct case when event_type = 'checkout_start' then user_id END) as stage_3_checkout,
    count(distinct case when event_type = 'payment_info' then user_id END) as stage_4_payment,
    count(distinct case when event_type = 'purchase' then user_id END) as stage_5_purchase

  FROM `stellar-cipher-476303-v7.sql_practice.users_events`
  WHERE event_date >= TIMESTAMP('2026-01-11') 
  AND event_date <= TIMESTAMP('2026-02-10')
)

SELECT 
  stage_1_views,
  stage_2_cart,
  Round(stage_2_cart * 100 / stage_1_views) as views_to_cart_rate,
  stage_3_checkout,
  Round(stage_3_checkout * 100 / stage_2_cart) as cart_to_checkout_rate,
  stage_4_payment,
  Round(stage_4_payment * 100 / stage_3_checkout) as checkout_to_payment_rate,
  stage_5_purchase,
  Round(stage_5_purchase * 100 / stage_4_payment) as payment_to_purchase_rate,
  Round(stage_5_purchase * 100 / stage_1_views) as overall_conversion_rate

FROM funnel_stages;


-- Query 3: Funnel by traffic source
with source_funnel as (
  SELECT
    traffic_source,
    count(distinct case when event_type = 'page_view' then user_id END) as views,
    count(distinct case when event_type = 'add_to_cart' then user_id END) as carts,
    count(distinct case when event_type = 'purchase' then user_id END) as purchases

  FROM `stellar-cipher-476303-v7.sql_practice.users_events`
  WHERE event_date >= TIMESTAMP('2026-01-11') 
  AND event_date <= TIMESTAMP('2026-02-10')
  group by traffic_source 
)
select
  traffic_source,
  views,
  carts,
  purchases,
  Round(carts * 100 / views) as cart_conversion_rate,
  Round(purchases * 100 / views) as purchase_conversion_rate,
  Round(purchases * 100 / carts) as cart_to_purchase_conversion_rate

from source_funnel
order by purchases desc;


-- Query 4: Time to conversion analysis
with user_journey as (
  SELECT
    user_id,
    Min(case when event_type = 'page_view' then event_date END) as view_time,
    Min(case when event_type = 'add_to_cart' then event_date END) as cart_time,
    Min(case when event_type = 'purchase' then event_date END) as purchase_time

  FROM `stellar-cipher-476303-v7.sql_practice.users_events`
  WHERE event_date >= TIMESTAMP('2026-01-11') 
  AND event_date <= TIMESTAMP('2026-02-10')
  group by user_id
  having min(case when event_type = 'purchase' then event_date END) is not null
)
select
  count(*) as converted_users,
  round(avg(timestamp_diff(cart_time, view_time, minute)),2) as avg_view_to_cart_minutes,
  round(avg(timestamp_diff(purchase_time, cart_time, minute)),2) as avg_cart_to_purchase_minutes,
  round(avg(timestamp_diff(purchase_time, view_time, minute)),2) as avg_total_journey_minutes

FROM user_journey;


-- Query 5: Revenue funnel analysis
with funnel_revenue as (
  SELECT
    count(distinct case when event_type = 'page_view' then user_id END) as total_visitors,
    count(distinct case when event_type = 'purchase' then user_id END) as total_buyers,
    sum(case when event_type = 'purchase' then amount END) as total_revenue,
    count(case when event_type = 'purchase' then 1 END) as total_orders

  FROM `stellar-cipher-476303-v7.sql_practice.users_events`
  WHERE event_date >= TIMESTAMP('2026-01-11') 
  AND event_date <= TIMESTAMP('2026-02-10')
)

SELECT
  total_visitors,
  total_buyers,
  total_orders,
  total_revenue,
  total_revenue / total_orders as avg_order_value,
  total_revenue / total_buyers as revenue_per_buyer,
  total_revenue / total_visitors as revenue_per_visitor

From funnel_revenue;
