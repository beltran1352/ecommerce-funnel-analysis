# E-Commerce Sales Funnel Analysis: Identifying Revenue Bottlenecks Using SQL

## Overview

An online retailer wanted to understand why only a small percentage of visitors became customers. The goal of this analysis was to identify where users dropped off in the purchasing funnel, evaluate marketing channel performance, and recommend actions that could increase revenue.

## What I Found

The biggest issue is that only 32% of visitors add anything to their cart. Once they do add something, almost everyone finishes the purchase. So the problem isn't the checkout process—it's getting people to add items in the first place.

When I looked at the full funnel, I saw:
- 3,282 people viewed the page
- 1,043 added to cart (32%)
- 741 started checkout (71% of carts)
- 585 entered payment info (79% of checkouts)
- 541 completed purchase (92% of payments)

The numbers get better as you move right, which means the checkout experience is solid. The drop-off happens early.

## Traffic Sources

I broke down the conversion by where people came from. Email had the best conversion at 34%, which surprised me because it had the lowest volume. Organic search was 17%. Paid ads were 21%. Social media was only 6%.

Email: 360 visitors, 123 purchases (34%)
Organic: 1,326 visitors, 226 purchases (17%)
Paid ads: 630 visitors, 132 purchases (21%)
Social: 966 visitors, 60 purchases (6%)

Even though social brought the most traffic, it converts the worst. Email brings fewer people but they actually buy.

## How Long It Takes

For people who actually bought, it took them about 11 minutes on average to add something to cart, then another 13 minutes to complete the purchase. Total journey was about 24 minutes. These aren't impulse buys.

## Revenue

The site made $58,322 total. That's $108 per order. Since 541 people bought and 3,282 visited, each visitor generated about $18 in revenue on average.

## What I'd Do Next

The cart abandonment is the biggest opportunity. If I could get more people to add items to cart, the revenue would jump. The checkout process is working fine—92% of people who start payment finish it.

I'd also shift marketing spend away from social media since it converts so poorly compared to email. Email might be worth investing more in.

The data suggests people take time to decide. They're not coming in and buying immediately. This could mean the products are expensive or people are comparing options.

## Data

Source: Google Cloud BigQuery
Time: January 11 - February 10, 2026
Visitors: 3,282
Purchases: 541
