# Cyclistic Case Study 

## Business Task

  In this case study, I am tasked with finding key differences in how annual members and casual users use Cyclistic bikeshare. These differences will be used to provide insights and recommendations to our stakeholders to help convert casual users into annual members.

  
## Data Sources, Data Cleaning, and Manipulation

 [Our data](https://divvy-tripdata.s3.amazonaws.com/index.html) comes directly from the primary source: Cyclistic Bikeshare services (Divvy). The data is open and made available to use by [this license agreement](https://divvybikes.com/data-license-agreement). It comes in the form of 12 .csv files, one for each month of 2023.

  I chose to use SQL in BigQuery to gather, clean, and analyze our data. Because of the quantity of data (nearly 6 million rows with 13 columns), a spreadsheet tool would be quite unwieldy to use for this task.
  
  [Click here for full SQL Query](https://github.com/TankaJahari/cyclistic.charliesun/blob/main/Data%20Cleaning%20and%20Manipulation.sql) 
  *Please Note: For null values and statistical outliers in my analysis, I've included (#) tags to reference my 'comments' found at the end of this README file that provide a bit of background information and explanation.*


## Supporting Visualizations and Key Findings

*tableau dashboard link*

### Total Rides

 - Of the 5,708,202 rides in our analysis, casual users accounted for ~36% (2,050,268) of the total, and annual users accounted for ~64% (3,657,934). 

### Ride Durations

 - Casual member rides lasted longer than annual member rides. On average, casual user rides lasted over 19 minutes while annual member rides lasted just under 12 minutes.

### Bike Types

 - There are three bike types in our data: classic, electric, and docked. Docked bikes were used exclusively by casual users, and only made up 3.6% of their total rides. 

 - Casual users had significantly more rides with electric bikes than classic bikes: 870,859 classic bike rides, 1,103,644 electric bike rides, 75,765 docked bike rides.

 - Annual members used classic and electric bikes nearly evenly: 1,816,875 classic bike rides vs. 1,841,059 electric bike rides.

 - Rides with electric bikes were shorter than rides with classic bikes for both usertypes.

 - Rides with docked bike lasted the longest on average, at nearly 45 minutes.

### Hour of Day

 - Visualizing the data for rides per hour of day showed both similarities as well as differences in the two user types.

 - For casual users, the ride count started low in the morning but continuously rose throughout the day and **peaked at 5PM** before a decline into the nighttime hours.

 - For annual members, the ride count also started low in the early morning, but rose more rapidly and **spiked at 8AM**. It then trailed off until 12PM before rising again and **peaked at 5PM**. There was a steeper decline into the nighttime hours for annual members. 


### Day of Week

 - For casual users, the highest usage days were weekend days: **Friday, Saturday, and Sunday**, significantly peaking on Saturday.

 - For annual members, the highest usage days were in the middle of the week: **Tuesday, Wednesday, and Thursday**. No day had a significant peak, and usage dropped off on the weekend days.
 
### Month

 - Comparing the rides per month for user types showed virtually no differences in their trends. Both casual users and annual members used Cyclistic significantly more during spring and summer months with their peak being in July. 


### Ride Locations

 - Using the latitude and longtitude coordinates of ride start locations as geographical data points for rides, our visualization showed that there was a higher concentration of rides for casual users near the lake shore compared to annual members.

 - While the annual members' density map does show a concentration of rides near the lake shore, it spans less area and is less dense.

## Summary of Analysis

 - Casual users, compared to annual members, likely utilized Cyclistic more for recreation and leisure based on their **longer average ride durations, peak usage days (weekends), preference for electric bikes, and ride locations**. Casual users were also the sole users of docked bikes.

 - Annual members on the other hand, likely used Cyclistic more for commuting and as a general means for transportation. This observation is based on their **peak usage days and hours (weekdays; 8AM and 5PM), shorter average ride durations, and total volume of rides**. Annual members showed a relatively negligible difference in bike type preference.


 - However, our data did show some simliarities between the user types. Aside from the identical trend of rides in the spring and summer months, many casual users are likely also using Cyclistic for at least part of their commutes. While casual users did not have a peak hour at 8AM, their *highest usage hour was still at 5PM*. This may suggest that casual users are opting to use Cyclistic when their workday is over, and are in less of a rush than in the morning. 


   
## Recommendations for Stakeholders


### Get casual users to think about using Cyclistic for commuting more, with a focus on electric bikes.

 - The data for casual users showed that many may already be using Cyclistic to commute *from*, but not *to* work. This could be for many reasons, but a logical guess would be that they are in a hurry to get to work, or don't want to show up sweaty and out of breath in business attire, thus opt for traditional modes of transportation. Since casual users showed a high usage rate of electric bikes, we could specifically market using electric bikes to get to work. Electric bikes are a great option for users wanting to fit in some exercise on the way to work while not exerting too much energy. 
   
 - Create/use referral incentives. Since many annual members use Cyclistic to commute, they may have colleagues and co-workers who use the service casually, that could be converted into annual members by seeing Cyclistic as an option for commuting. For example, a free half or quarter year of membership for both users if the new user signs up for an annual membership.


### Increase marketing spending that targets the lake shore and other popular tourist locations in Chicago.

 - If a casual user is using a parking app in a busy or “difficult to drive” location, advertise nearby Cyclistic stations so they might think “hmm, next time, I could just use Cyclistic and bike from/to here”.
   
 - Utilize ads on various digital channels (search engine ads, social media platforms) to advertise Cyclistic stations when users are searching for or browsing Chicago’s tourist locations, restaurants, etc.

 - Increase awareness of Cyclistic stations near train stations/bus stops that casuals users frequent.


### 3. Increase marketing spending during the weekend days and spring and summer months.

 - One of the biggest differences in the data of the two user types was the amount of rides that were on the weekend days. Since casual users are using Cyclistic more on these days, there is likely value to gain from focusing on marketing to them during the weekends.

 - Although it's quite predictable for a city like Chicago, our data confirms that the spring and summer months are when the majority of rides take place. Focus marketing resources on the spring and summer months if not already doing so.
   








--#Comments:

--#nulls

--Roughly ~550,000 null station names/ids for annual members and ~350,000 for casual users. 

--For Annual members, there were more nulls (missing data) in their start_station data than in their end_station data by about 0.4%. 

--For Casual users, the inverse was true: *Less* nulls in start_station data by about 14.6%. So the trips for Casual riders more often had their start_station data while missing a larger proportion of end_station data.

--This pattern may not be relevant to the analysis for our current task, but it could be useful in others so I wanted to include it in some way.


--#outliers


--Examining the data showed that the vast majority of rides (5,577,916 of 5,718,880, 97.5%) being no longer than one hour.

--It is more than possible for users to use their bikes for longer than one hour, so I don't want to simply omit all rides past one hour.

--To be safe, I'll use a cut-off of eight hours, or 480 minutes. Only 10,674 rides out of 5,708,202 rides (0.19%) lasted longer than 480 minutes. There are rides within these 10,674 that lasted multiple WEEKS and would skew our findings 

--*I know this isn't ideal or perfect and there are scientific ways to more precisely determine outliers, but being that I'm working with almost 6 million observations, I'm just moving forward. I played w/ methods like z-scores, interquartile range, and looking at the median absolute deviation (doing some quick research showed that MAD is a robust statistic to measure deviation from the median), but I need to refresh and supplement my stats skills to effectively use these.*



