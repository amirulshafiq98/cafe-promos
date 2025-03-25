![Logo](https://upload.wikimedia.org/wikipedia/commons/thumb/a/a3/R%C3%B6e_g%C3%A5rd_caf%C3%A9_2.jpg/1200px-R%C3%B6e_g%C3%A5rd_caf%C3%A9_2.jpg)

# Project Background
In this example a cafe is running a promotion in the form of Buy-One-Get-One (BOGO) and discount to increase customer traffic into the cafe. The sales data shows all transactions conducted during the month. All cafe members only received one type of promotion every 7 days with the exception being Day 24. 

A total of 8 promotions were ran concurrently with two separate campaigns being pushed to customers via email, phone and mail. The 8 promotions are all different with a breakdown of them [here](https://github.com/user-attachments/assets/f94f9fb7-3486-4f83-b562-24b7b6d0146c). This project aims to understand how users interact with the promotion(s) at the cafe to determine if traffic increased over the course of the month. 

Insights and recommendations are provided in the following areas:
- **Sales Trends:** Analyse total sales over the month to determine highest and lowest sales

- **Total Participations:** Evaluate how much BOGO and discount promotions were redeemed over the month

- **Profile of Customers:** Determine what type of customer is a patron of the cafe to better target them with promotional campaigns

Tableau Dashboard [Link](https://public.tableau.com/views/Coffee-Portfolio/CafePromoDashboard?:language=en-GB&publish=yes&:sid=&:redirect=auth&:display_count=n&:origin=viz_share_link)

SQL query for inspecting and checking values [Link](https://github.com/amirulshafiq98/cafe-promos/blob/main/clean-up.sql)

SQL query for importing and creating tables  [Link](https://github.com/amirulshafiq98/cafe-promos/blob/main/manipulation.sql)

SQL query for checking and dashboard preparation [Link](https://github.com/amirulshafiq98/cafe-promos/blob/main/prep.sql)



# Data Structure
The cafe promotions table structure are as follows: customers, events and offers. 

![Cafe Schema](https://github.com/user-attachments/assets/f7311a88-089c-4c44-b47b-9b74cc5b564d)

As the events file had a column in JSON format, the column was trimmed to remove the excess strings for easier quering. SQL query for cleaning can be viewed [here](https://github.com/amirulshafiq98/cafe-promos/blob/main/clean-up.sql)


# Executive Summary
#### Overview:
The objective of this project is to analyse the performance of various promotional campaigns run by a cafe over the course of a month. The cafe aimed to increase customer traffic and engagement through multiple promotional strategies, including Buy-One-Get-One (BOGO) offers and discounts. The project focuses on understanding customer behavior, promotion redemption rates, and sales trends, with the goal of optimising future campaigns to increase customer retention and revenue. 

Below is an overview of the dashboard in Tableau that can be downloaded [here](https://public.tableau.com/views/Coffee-Portfolio/CafePromoDashboard?:language=en-GB&publish=yes&:sid=&:redirect=auth&:display_count=n&:origin=viz_share_link)

<p align="center">
  <img src="https://github.com/user-attachments/assets/54cb1569-6724-4ab1-8b4b-586765b28ecf">
</p>

#### Sales Trend:
- Over the course of the promotion month, total sales amounted to $1.7M, with an average daily revenue of $55,000
- The highest sales day was Day 26, generating $77,000. The highest 7-day moving average (MA7) was recorded on Day 28, with $72,000
- The launch day (Day 0) had the lowest sales of $7,000, followed by Day 30, with sales falling to $35,000, a 39% drop from the previous day
- Despite Day 18 having the most amount of redemptions, it was not even top 3 for revenue generation
- Higher redemptions generally did not equate to higher sales however, lower redemptions did correlate with low sales
- Despite BOGO having lower redemption rates than dicounts, the total dollars redeemed were much higher (>$20,000)

<p align="center">
  <img src="https://github.com/user-attachments/assets/a92fe0e5-c7a6-4fd5-8ff9-6d3468f257e7">
</p>

<p align="center">
  <img src="https://github.com/user-attachments/assets/9f44e3ad-b8ae-4c59-8e09-9b65304085b4">
</p>

#### Total Participations:
- A total of 30,000 customers participated in the promotions, with a 93% redemption rate across all promotions
- The promotion offering a $10 discount for a $10 spend had the highest redemption rate of 85%
- The highest number of redemptions occurred on Day 18, with 2,689 redemptions
- Most customers redeemed their promotion codes within 1 day of receiving them. However, certain longer-duration promotions resulted in higher redemption rates (85% for 10-day offers)

<p align="center">
  <img src="https://github.com/user-attachments/assets/824af2c9-dcd6-4650-a3ef-3fab9c418a18">
</p>

#### Customer Profile:
- 65% of customers were aged 51+, with an average annual income of $74,000
- The majority of customers joined in 2017 (34,000) and 2016 (32,000), with fewer joining in 2014 (11,000)
- Higher-income customers were more likely to participate in the promotions, particularly those with an income above $70,000
- Newer members (2017 onwards) showed lower engagement rates compared to older members, whose redemption rates were consistently above 90%
- Older customers (51+) were more likely to redeem promotions, especially BOGO offers, but newer members were less inclined to participate

<p align="center">
  <img src="https://github.com/user-attachments/assets/bbc9590e-d321-4cdc-afa5-ca2bf55cc862">
</p>

# Recommendations
- **Target Younger Customers:** Marketing efforts should focus on attracting customers aged 50 and below to balance the customer base and increase participation
- **Extend Promotion Durations:** Since 10-day promotions resulted in higher redemption rates, future campaigns should incorporate promotions of similar length to drive engagement
- **Focus on Discounts Over BOGO:** Although BOGO promotions resulted in higher redeemed dollars, they had lower redemption rates than discounts. The cafe can consider implementing small pilot campaigns and use A/B testing to fine-tune the promotion strategies further 
- **Increase Engagement with Newer Members:** Newer members (2017 onwards) had lower redemption rates. The cafe should send more frequent reminders via email, messages, and mail to encourage their participation in future promotions
- **Premium Product Offerings:** Given the higher income demographics, the cafe could consider introducing premium product lines that cater to this segment, potentially increasing revenue from high-income customers


