# Cyclistic Case Study 

## Business Task

  In this case study, I am tasked with finding key differences in how annual members and casual members use Cyclistic. These differences will be used to provide insights and recommendations to our stakeholders to help convert casual users into annual members.

  
## Data Sources

  Our data comes directly from the primary source: Cyclistic Bikeshare services (Divvy). The data is open and made available to use by [this license agreement](https://divvybikes.com/data-license-agreement)
  
  [Our data](https://divvy-tripdata.s3.amazonaws.com/index.html) comes in the form of 12 .csv files, one for each month of 2023.


## Data Cleaning and Manipulation

  I chose to use SQL in BigQuery to gather, clean, and analyze our data. Because there are 12 large datasets that total nearly 6 million rows with 13 columns, a spreadsheet tool would be quite unwieldy.
  
  [Click here for full SQL Query](https://github.com/TankaJahari/cyclistic.charliesun/blob/main/Data%20Cleaning%20and%20Manipulation.sql)


## Supporting Visualizations and Key Findings

*tableau dashboard link*

### Total Rides

 - Of the 5,708,202 rides in our analysis, casual users accounted for 2,050,268 (~36%), and annual users accounted for 3,657,934 (~64%).

### Ride Durations

 - Casual member rides lasted longer than annual member rides. On average, casual user rides lasted over 19 minutes while annual member rides lasted just under 12 minutes.

### Bike Types

 - There are three bike types in our data: classic, electric, and docked. Docked bikes were used exclusively by casual users and made up 3.6% of their total rides. 

 - Casual users had significantly more rides with electric bikes than classic bikes: 870,859 classic bike rides, 1,103,644 electric bike rides, 75,765 docked bike rides.

 - Annual members used classic and electric bikes nearly evenly: 1,816,875 classic bike rides vs. 1,841,059 electric bike rides.

 - Electric bike rides were shorter than classic bike rides for both types of users. 

### Hour of Day

 - Visualizing the data for rides per hour of day showed both similarities and differences between the two user types.

 - For annual members, the ride count started low in the early morning, trended upwards and **spiked at 8AM**. It then trailed off before rising again and **peaked at 5PM**. 

 - For casual members, the ride count also started low in the morning but continuously trended upwards throughout the day and also peaked at around 5PM.

### Day of Week

 - For casual members, the highest usage days were weekend days: **Friday, Saturday, and Sunday**, significantly peaking on Saturday.

 - For annual members, the highest usage days were in the middle of the week: **Tuesday, Wednesday, and Thursday**. No day had a significant peak, and usage dropped off on the weekend days.
 
### Month

 - Comparing the rides per month for user types showed virtually no difference. Chicago is a very seasonal city, and it is no surprise that both casual users and annual members used Cyclistic significantly more during spring and summer months. This data can still be helpful for as evidence that marketing resources should be allocated towards these times of year.

### Ride Locations

 - Using start location long/lat coordinates as geographical data points for rides, our visualization showed that there was a higher concentration of rides for casual users along the lake shore compared to annual members.

 - While the density map does show a concentration of rides near the lake shore for annual members, it covers less area and is less dense.

## Summary of Analysis

 - Casual users, compared to annual members, likely utilized Cyclistic more for recreation and leisure based on their **longer average ride durations, peak usage days (weekends), and ride locations**.

 - Annual members on the other hand, likely utilized Cyclistic more for commuting and as a general means of transportation. This observation is based on their **peak usage days and hours (weekdays; 8AM and 5PM), shorter average ride durations, and total volume of rides**.


 - However, our data does show some simliarities. Aside from the predictable outcome that both user types ride Cyclistic bikes more during the spring and summer months due to Chicago's climate, many casual users are likely also using Cyclistic for at least part of their commutes. While casual users did not have a peak hour at 8AM, their *highest usage hour was also at 5PM*. This suggests that casual users may be opting to use Cyclistic when their workday is over, and are in less of a rush. 


   
## Recommendations for Stakeholders


### 1. Get casual users to think about using Cyclistic for commuting more. Our data shows that casual users may already be using Cyclistic to commute after work. 

 - Market Cyclistic's electric bikes, especially as a morning commute option. The data for casual users showed that many may already using Cyclistic to commute *from*, but not *to* work. This could be for many reasons, but a logical guess would be that they're in a hurry to get to work, or don't want to show up sweaty and out of breath in business attire. Since casual users showed a high usage rate of electric bikes, we could specifically market using electric bikes to get to work. Electric bikes are a great option for users wanting to fit in some exercise on the way to work while not exerting too much energy.
   
 - Use referral incentives. Since many annual members use Cyclistic to commute, they may have colleagues and co-workers who use the service casually, that could be converted into annual members by seeing Cyclistic as an option for commuting. For example, a free half or quarter year of membership for both users if the new user signs up for an annual membership.
   

### 2. Increase marketing spending for the lake shore and other popular tourist locations in Chicago as well as less-known station locations.

 - If a casual user is using a parking app in a busy or “difficult to drive” location, advertise nearby Cyclistic stations so they may think “hmm, next time, I could just use Cyclistic and bike from/to here”.
   
 - Utilize ads on various digital channels (search engines, social media platforms) to advertise Cyclistic stations when users are searching for or browsing Chicago’s tourist locations, restaurants, etc.

 - Increase awareness of Cyclistic stations near train stations/bus stops that casuals users frequent.


### 3. Increase marketing spending during the weekend days and spring and summer months.

 - One of the biggest differences in the data of the two user types was the amount of rides that were on the weekend days. Since casual users are using Cyclistic more on these days, there is likely value to gain from focusing on marketing to them during the weekends.


--#Comments:

--#nulls
--Roughly ~550,000 null station names/ids for annual members and ~350,000 for casual users. 
--For Annual members, there were more nulls (missing data) in their start_station data than in their end_station data by about 0.4%. 
--For Casual members, the inverse was true: *Less* nulls in start_station data by about 14.6%. So the trips for Casual riders more often had their start_station data while missing a larger proportion of end_station data.
--This pattern may not be relevant to the analysis for our current task, but it could be useful in others so I wanted to include it in some way.


--#outliers
--Examining the data showed that the vast majority of rides (5,577,916 of 5,718,880, 97.5%) being no longer than one hour.
--It is more than possible for users to use their bikes for longer than one hour, so I don't want to simply omit all rides past one hour.
--To be safe, I'll use a cut-off of eight hours, or 480 minutes. Only 10,674 rides out of 5,708,202 rides (0.19%) lasted longer than 480 minutes. There are rides within these 10,674 that lasted multiple WEEKS and would skew our findings 

--*I know this isn't ideal or perfect and there are scientific ways to more precisely determine outliers, but being that I'm working with almost 6 million observations, I'm just moving forward. I played w/ methods like z-scores, interquartile range, and looking at the median absolute deviation (doing some quick research showed that MAD is a robust statistic to measure deviation from the median), but I need to refresh and supplement my stats skills to effectively use these.*

