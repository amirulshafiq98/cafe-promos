![Logo](https://upload.wikimedia.org/wikipedia/commons/thumb/a/a3/R%C3%B6e_g%C3%A5rd_caf%C3%A9_2.jpg/1200px-R%C3%B6e_g%C3%A5rd_caf%C3%A9_2.jpg)

# Project Background
In this example a cafe is running a promotion in the form of Buy-One-Get-One (BOGO) and discount to increase customer traffic into the cafe. The sales data shows all transactions conducted during the month. All customers only receive one type of promotion every 7 days with the exception being Day 24. 

A total of 8 promotions were ran concurrently with two separate campaigns being pushed to customers via email, phone and mail. The 8 promotions are all different with a breakdown of them [here](https://www.google.com). This project aims to understand how users interact with the promotion(s) at the cafe to determine if traffic increased over the course of the month. 

Insights and recommendations are provided in the following areas:
- **Sales Trends:** Analyse total sales over the month to determine highest and lowest sales

- **Total Participations:** Evaluate how much BOGO and discount promotions were redeemed over the month

- **Profile of Customers:** Determine what type of customer shops at the cafe to better target them with promotional campaigns

Tableau Dashboard [Link](https://www.google.com)

SQL query for inspecting and checking values [Link](https://www.google.com)

SQL query for importing and creating tables  [Link](https://www.google.com)

SQL query for checking and dashboard preparation [Link](https://www.google.com)



# Data Structure
The cafe promotions table structure are as follows: customers, events and offers. 

![Cafe Schema](https://github.com/user-attachments/assets/f7311a88-089c-4c44-b47b-9b74cc5b564d)

As the events file had a column in JSON format, the column was trimmed to remove the excess strings for easier quering. SQL query for cleaning can be downloaded [here](https://www.google.com)


# Executive Summary
#### Overview:
As the dataset does not provide previous month/year data, only daily interactions can be measured. The total sales generated over the month was $1.7M with 30,000 customer participations which accounted for a 93% redemption rate. The lowest sales over the month was Day 0, which was launch day of the promotions generating only $7,000. After Day 0, the next lowest was Day 30 where total sales reached $35,000 accounting for a 39% decrease from the previous day. The highest sales recorded was on Day 26 with $77,000 with a 7-day moving average of $71,000. 

65% of customers were 51 or older with an average annual income of $74,000. Majority of customers at the cafe became members in 2017 (34,000) and 2016 (32,000) with the next biggest group being 2014 (11,000). The promotion with the most amount of redemptions (85%) was the promotion where a $10 spend rewarded the customer with a $10 discount with only one of the $10 BOGO promos having less than a 50% redempion rate. However, the only two promotions with over $30,000 redeemed were the two $10 BOGO promotions ($37,000 & $33,000). The following sections will cover in greater detail other contributing factors and highlight key areas for improvement. 

Below is an overview of the dashboard in Tableau that can be downloaded [here](https://www.google.com)

![Overview](https://via.placeholder.com/468x300?text=App+Screenshot+Here)

#### Sales Trend:
- Total sales generated over the month of the promotion was $1.7M with an average daily revenue of $55,000
- The highest sales generated was on Day 26 with $77,000 while the lowest excluding Day 0 was $36,000 on Day 30
- The highest 7-day moving average (MA7) was on Day 28 with $72,000
- MoM
- Despite Day 18 having the most amount of redemptions, it was not even top 3 for revenue generation
- Higher redemptions generally did not equate to higher sales however, lower redemptions  did correlate with low sales
- Despite BOGO having lower redemption rates than dicounts, the total dollars redeemed were much higher (>$20,000)

![Sales Trend](https://via.placeholder.com/468x300?text=App+Screenshot+Here)


#### Total Participations:
- A total of 30,000 customers participated in the promotions over the month with the total BOGO and discount redemptions being 17,922 and 21,141 respectively accounting for a 93% total redemption rate. 
- The maximum number of redemptions was on Day 18 with 2,689 redemptions
- Majority of customers redeemed their promotion codes with the exception of customers who got BOGO_3 codes (49%)
- The average customer took 1 day to redeem their promo code after receiving it
- Longer duration promotions did result in higher redemption rates (85%) however, the discount promotion which featured $20 spend for $10 discount had the second lowest redemption rate (53%) despite both promotions being 10 days long

![Total Participations](https://via.placeholder.com/468x300?text=App+Screenshot+Here)

#### Customer Profile:
- 65% of customers were 51 or older with an average annual income of $74,000 
- Majority of customers at the cafe became members in 2017 (34,000) and 2016 (32,000) with the next biggest group being 2014 (11,000)
- Newer members (2017 onwards) are not as keen to participate in the promotions compared to older members who have above above a 90% participation rate
- Higher income customers were more likely to be patrons of the cafe

![Customer Profile](https://via.placeholder.com/468x300?text=App+Screenshot+Here)


# Recommendations
- Increase marketing towards 50 and younger customers as the gap between them and 51+ is 50%
- As 10-day promotions led to high redemption rates, promotions given out to customers in the next cycle should at least be this long to increase customer engagement
- As BOGO had lower redemption rates (highest is 66%) and higher dollars redeemed (>$20,000)than discounts, BOGO should not be used in promotions moving forward
- More frequent updates via email, messages and mail should be given to newer members as their participation rate for this month was lower than the older members
- Since higher earning individuals represented the majority of customers, the cafe can consider creating more premium products to cater to this demographic




