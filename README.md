# E-Commerce Sales Funnel Analysis | SQL & BigQuery

## Business question

Where do customers drop off in an e-commerce purchasing funnel, and which marketing channels bring visitors who are most likely to purchase?

I analyzed event-level e-commerce activity using Google BigQuery SQL to compare funnel-stage participation, traffic-source conversion, time to purchase, and revenue per visitor.

## Key results

| Funnel event | Distinct users | Rate from previous stage |
|---|---:|---:|
| Page view | 3,282 | — |
| Add to cart | 1,043 | 31.8% of page viewers |
| Checkout start | 741 | 71.0% of add-to-cart users |
| Payment information | 585 | 78.9% of checkout users |
| Purchase | 541 | 92.5% of payment-info users |

**Overall purchase-to-page-view ratio: 16.5%.**

The largest *difference in distinct-user counts* is between page views and add-to-cart events (2,239 users). That makes product discovery and add-to-cart behavior an important area for follow-up investigation. These counts alone do not show that every user moved through the stages sequentially.

## Conversion by traffic source

| Traffic source | Page-view users | Purchase users | Purchase / page-view ratio |
|---|---:|---:|---:|
| Organic | 1,326 | 226 | 17.0% |
| Social | 966 | 60 | 6.2% |
| Paid ads | 630 | 132 | 21.0% |
| Email | 360 | 123 | 34.2% |

- **Organic** brought the most page-view users (1,326) and the most purchase users (226).
- **Email** had the highest purchase-to-page-view ratio (34.2%), but the smallest traffic volume (360 page-view users).
- **Social** had a lower purchase-to-page-view ratio (6.2%) than the other sources.

These are descriptive comparisons, **not proof** that any channel caused more purchases or delivered a better advertising ROI. The dataset shown here does not include marketing spend.

## Purchase timing and revenue

Among purchasing users, the SQL analysis estimated an average of approximately **11 minutes** from first page view to first cart event, and **13 additional minutes** from first cart event to first purchase — approximately **24 minutes** overall.

The original revenue summary reports **$58,322** in revenue and **541** purchases/orders, or about **$108 per order** and **$17.77 per page-view user**.

**Calculation caveat:** The time-to-conversion query takes each user's earliest event timestamp in the analysis window. It does not confirm event sequence or separate repeat sessions, so durations should be treated as exploratory estimates. Revenue and buyer counts also should be reconciled against the raw source before drawing conclusions about individual orders or repeat buyers.

## Business recommendations

1. **Investigate the add-to-cart stage.** Segment page-view users by product, device, and traffic source; review product detail pages and add-to-cart events before proposing a redesign.
2. **Test improvements to product pages.** Examples include clearer shipping information, product descriptions, and calls to action. Measure change with a controlled test.
3. **Review social traffic quality.** Its purchase-to-page-view ratio is comparatively low, but assess campaign goals, spend, attribution, and customer value before reducing budget.
4. **Explore email growth carefully.** Email's conversion ratio is promising, but check audience selection and campaign costs before expanding investment.

## SQL work

All five analyses are in [queries.sql](queries.sql):

1. Count distinct users by funnel event.
2. Calculate ratios between funnel-stage user counts.
3. Compare stage counts and purchase ratios by traffic source.
4. Estimate time between first observed funnel events for purchasing users.
5. Summarize purchase revenue, orders, and revenue per visitor.

**Tech:** Google BigQuery, SQL (CTEs, conditional aggregation, `COUNT(DISTINCT ...)`, timestamp arithmetic).

**Source table:** `stellar-cipher-476303-v7.sql_practice.users_events`

**Analysis window:** January 11–February 10, 2026, as reported in the original analysis.

## Limitations / next steps

- The current funnel is **event-stage participation**, not a verified sequential, session-level funnel. Users may have events out of order or across multiple sessions.
- The original SQL's end-date filter can omit events after midnight on February 10 if `event_date` is a timestamp. Update it to a half-open time window and rerun before treating the date range as fully inclusive.
- Traffic-source comparisons assume events are consistently attributed to the same channel. Attribution rules should be checked in the underlying data.
- A stronger follow-up analysis would construct ordered journeys per user/session, account for repeat purchases, and add marketing cost data.

*This repository documents a portfolio analysis rather than a validated production reporting pipeline.*
