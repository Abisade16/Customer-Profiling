# Customer-Profiling
Classifying customers based on loyalty and bonus scores (Customer Segmentation)

## Ovierview
Ninja Telecommunications is an Internet Service Provider in Nigeria. To support their revenue drive and marketing effort, they want to have a better understanding of
their customers, especially with regards to how they use their Internet Data Plans. The company would like to be more efficient in their Free Data Offerings and has provided 6 months customer data for profiling before further analysis.

## The Data
- Six months of Customers Data.
- Primary City represents the city where customer resides.
- Account Number represents the customer’s unique Identification.
- Customer Type indicates whether a customer is corporate or retails.
- Data Subscribed is the amount of Internet Data Purchased by the customer at a particular time
in a month.
- Data Bonus is the amount of Free Internet Data given to the customer at a particular time in a
month.
- Bonus Used is the amount of the Free Internet Data used by the customer at a particular time in
a month.
- YM represents the Months in the year for the transactions, covering a six month period.

## Tools
- R

# Method Used
Customer profiling was done based on a set of rules that result in loyalty and bonus scores  
Assigned Scores: 20 15 10 5 1  

Loyalty Score        
- Purchased Data Every Month: 20
- Purchased Data 5 out of 6 months: 15
- Purchased Data 4 out of 6 Months: 10
- Purchased Data less than 4 out of 6 months: 5
- Did not purchase data in the 6 months period: 1

Bonus Score        
- Did not use bonus at all in 6 months: 20
- Did not use bonus at all in 5 out of 6 months: 15
- Did not use bonus at all in 4 out of 6 months: 10
- Did not use bonus at all in less than 4 out of 6 months: 5
- Used bonus data in all of the 6 months: 1
  
## Output
Customers were grouped into the following categories  
Tier 1 Priority Service – Above 85%  
Tier 2 Priority Service – Between 75% and 85%  
Tier 3 Priority Service + Incentives – Above 60% and Less than 75%  
Tier 4 Priority Marketing + Incentives – Less than or equal to 60%
