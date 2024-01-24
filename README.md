# cyclistic.charliesun

## Business task:

  In this case study, I am tasked with finding key differences in how annual members and casual members use Cyclistic. These differences will be used to provide insights and recommendations to our stakeholders to help convert casual users into annual members.

  
## Description of all data sources used:

  Our data comes directly from the primary source, Cyclistic (Divvy). 

  It is open data made available to use by this license agreement: https://divvybikes.com/data-license-agreement
  
  Our data came in the form of .csv files; one file for each month of the year 2023 (https://divvy-tripdata.s3.amazonaws.com/index.html)


## Documentation of any cleaning or manipulation of data:

  I chose to use SQL in BigQuery to gather, clean, and analyze our data. Because we have 12 large datasets totaling nearly 6 million rows, with 13 columns each, there is too much data to only use a spreadsheet tool.
  *Please see "Data Cleaning and Manipulation" file on main page for complete SQL query*


## Supporting visualizations and key findings:

*tableau dashboard link*
**Ride Duration:**

Casual members' rides last longer than annual members’. On average, casual user rides lasted over 19 minutes while annual member rides lasted just under 12.

**Bike Types:**

Casual users rode electric bikes more than classic bikes and had some usage of docked bikes (870,859 rides with classic bikes, 1,103,644 with electric bikes, 75,765 with docked bikes).
Annual members used classic and electric bikes nearly evenly and did not use docked bikes (1,816,875 rides with classic bikes, 1,841,059 with electric bikes).

**Hour of Day:**

Visualizing the rides per hour of day showed two significant peaks for annual members: In the morning and early evenings, 8AM and 5PM (and surrounding hours).
For casual members, the peak usage hour was 5PM and was not very significant. 

**Day of Week:**

For casual members, the highest usage days were weekend days: Friday, Saturday, and Sunday, significantly peaking on Saturday
For annual members, the highest usage days were in the middle of the week: Tuesday, Wednesday, and Thursday. No day had a significant peak, and usage dropped off a bit on the weekend days.
 
**Month:**

Comparing the rides per month for user types showed virtually no difference. Chicago is a very seasonal city, and it is no surprise that both casual users and annual members rode more during spring and summer months.

**Start Location Map:**

Using start location long/lat coordinates as data points, I found that there was a higher concentration of rides for casual users along the lake shore compared to annual members.
While the density map does show a concentration of rides near the lake shore for annual members, it covers less area, and is noticeably less dense.

Summary of Analysis:

Top three recommendations based on my analysis:


**1. Get casual users to think Cyclistic for more than just recreation/leisure. Our data shows that some casual users likely already use Cyclistic to get home from work. Get casual users to think about using Cyclistic for commuting more.**
 - Casual users showed a higher usage rate of electric bikes. Cyclistic’s electric bikes are a great option for users wanting to fit in some exercise on the way to work but not exert too much energy.	
 - Use referral incentives. Since many annual users are using Cyclistic to commute, they may have colleagues who have used Cyclistic casually, that they could recommend Cyclistic to. For example, a free half year for both users if the new user signs up for an annual membership.
 - Advertise Cyclistic stations near train stations/bus stops that a casual user might frequent

**2. Increase marketing spending for lake shore and other popular tourist locations in Chicago as well as less-known station locations.**
 - If a casual user is using a parking app in a busy or “difficult to drive” location, advertise nearby Cyclistic stations so they may think “hmm, next time, I could just use Cyclistic and bike from/to here”.
 - Utilize ads on various digital channels (search engines, social media platforms) to advertise Cyclistic stations when users are searching for or browsing Chicago’s tourist locations, restaurants, etc.

**3. Increase marketing spending during the weekend days.**
 - One of the biggest differences in the data of the two user types was the amount of rides that were on the weekend days. Since casual users are using Cyclistic more on these days, there is likely value to gain from focusing on digitally marketing during the weekends 


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

