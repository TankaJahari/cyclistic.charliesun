# Case Study - Cyclistic Bikeshare Data Analysis 

## Introduction

  In this case study, I am playing the role of a junior data analyst, a member of the marketing analyst team for a fictional bike-share company in Chicago called Cyclistic.

  
Cyclistic's finance analysts have found that annual members are much more profitable than casual users, and as a result, the director of marketing believes that maximizing the number of annual memberships is key to the future success of the company.


My goal is to analyze and discover key insights as to how casual riders and annual members use Cyclistic differently. I will use these insights to provide marketing strategy recommendations that will help convert casual users into annual members. For these recommendations to be approved, they need to be supported with compelling data findings and visualizations.




  
## Data Source, Cleaning, and Manipulation

### Data Source

 Our [data](https://divvy-tripdata.s3.amazonaws.com/index.html) comes directly from the primary source: Cyclistic Bikeshare services (Divvy). The data is open and made available to use by [this license agreement](https://divvybikes.com/data-license-agreement). 
 
 It comes in the form of 12 .csv files, one for each month of 2023.

  I chose to use SQL in BigQuery to gather, clean, and analyze our data. Because of the quantity of data (nearly 6 million rows with 13 columns), a spreadsheet tool would be quite unwieldy to use for this task.

### Combining Data

I downloaded all 12 .csv files from our data source. Next, I uploaded each file to BigQuery. I aggregated identical columns from all months to create one dataset to facilitate comprehensive analysis for the whole year, and named the table `tota_data_2023`

[Click here for related SQL Query](https://github.com/thecharliesun/cyclistic.charliesun/blob/main/SQL%20Queries/1.%20Combining%20Data.sql) 

### Cleaning and Transforming Data


To ensure data integrity, I first ran a query to count all duplicate records in our dataset. If the query returned anything but 0, I would run a query to select the actual duplicate records and examine and make a decision on omitting them.


I checked for null values, which were found exclusively in the start_station and end_station columns. This would limit our analysis related to start stations, so I will try to mitigate the lack of this by using findings from other attributes to derive insights. In a situation where station data is essential, I would find and use strategies to handle the missing values in a way that still allows for a complete analysis. 


I created a new dataset, `total_data_2023_v2` with calculated columns to make observations on data points like each ride's duration, hour of the day, day of week, and month. I also chose to rename and rearrange some columns for improved readability.

Examining some summary statistics like minimum, maximum, and average, on ride durations showed that we have some extremely long ride durations as well as negative ride durations. These are potential outliers in our data that could skew the results of analyses. I also suspected there may be rides with durations equal to zero, so I ran a query to count 'zero duration rides' which returned a result of 997 rides. Rides with durations equal to exactly zero would have start and end times exactly equal to each other, which would be impossible for a human user to cause, thus likely a technical errorin Cyclistic's system. 

Negative ride durations at first appear to be irrational and possibly the result of a technical error, but I realized that the start and end times are simply flipped. We can still extract rational ride durations from these data points. I created a new table named `total_data_2023_v3` to omit outliers (rides that lasted 480 minutes or more)*, as well as any trips that had a duration of exactly zero.

[Click here for related SQL Query](https://github.com/thecharliesun/cyclistic.charliesun/blob/main/SQL%20Queries/2.%20Cleaning%20and%20Transforming%20Data.sql)

(*For null values and statistical outliers in my analysis, I've included # tags in my SQL code to reference the 'Comments' section at the end of this README file that provides a bit of background information and explanation.*)*


### Analyzing and Aggregating Data

With our data cleaned and ready to go, I ran multiple queries to create individual datasets based on metrics like bike types, hour of ride, day of ride, etc. These smaller tables make it easier to extract different insights about specific attributes of rides, as well as visualize our data in a BI tool. 


[Click here for SQL Query](https://github.com/thecharliesun/cyclistic.charliesun/blob/main/SQL%20Queries/3.%20Analyzing%20and%20Aggregating%20Data.sql)
  
  


## Supporting Visualizations and Key Findings

For this analysis, I used Tableau Public to visualize the findings from our data in a dashboard with graphs, charts and maps.

[Link to Tableau Dashboard](https://public.tableau.com/views/CyclisticCaseStudy_17060520013410/Dashboard1?:language=en-US&publish=yes&:display_count=n&:origin=viz_share_link)
### Key Findings:
**Total Rides**

 - Of the 5,708,202 rides in our analysis, casual users accounted for ~36% (2,050,268), annual users accounted for ~64% (3,657,934).
<p align="center">  
<img src= "https://github.com/thecharliesun/cyclistic.charliesun/blob/main/Visualizations/Total%20Rides.PNG?raw=true">
</p>


**Ride Durations**

 - On average, casual users had longer rides than annual members. Casual user rides lasted over 19 minutes while annual member rides lasted just under 12 minutes.

<p align="center">  
<img src= "https://github.com/thecharliesun/cyclistic.charliesun/blob/main/Visualizations/Overall%20Avg%20Durations.PNG?raw=true">
</p>
 
 - Overall, rides with electric bikes were roughly four minutes shorter on average than classic bike rides.
   
 - For annual members, electric bike rides were about one minute shorter than classic bike rides.
   
 - For casual users, electric bike rides were shorter by about nine minutes.

<p align="center">  
<img src= "https://github.com/thecharliesun/cyclistic.charliesun/blob/main/Visualizations/Bike%20Type%20Durations.PNG?raw=true">
</p>
   

**Bike Types**


 - There are three bike types found in our data: classic, electric, and docked. 

 - Casual users had significantly more rides with electric bikes than classic bikes: 870,859 classic bike rides, 1,103,644 electric bike rides, and 75,765 docked bike rides. Docked bikes were used exclusively by casual users, but only accounted for 3.6% of their total rides.

 - Annual members used classic and electric bikes nearly evenly: 1,816,875 classic bike rides vs. 1,841,059 electric bike rides.

<p align="center">  
<img src= "https://github.com/thecharliesun/cyclistic.charliesun/blob/main/Visualizations/Rides%20per%20Bike%20Type.PNG?raw=true">
</p>

**Hour of Day**

 - Visualizing the data for rides per hour of day showed differences as well as similarities between the two user types.

 - For casual users, the ride count started low in the morning but continuously rose throughout the day and **peaked at 5PM** before seeing a decline into the nighttime hours.

 - For annual members, the ride count also started low in the early morning, but rose more rapidly and **spiked at 8AM**. It then trailed off until 12PM before rising again and **peaked at 5PM**. There was a steeper decline into the nighttime hours for annual members, meaning they rode Cyclistic bikes less at night than casual users. 

<p align="center">  
<img src= "https://github.com/thecharliesun/cyclistic.charliesun/blob/main/Visualizations/Hour%20of%20Day.PNG?raw=true">
</p>

**Day of Week**

 - For casual users, the highest usage days were weekend days: **Friday, Saturday, and Sunday**, significantly peaking on Saturday.

 - For annual members, the highest usage days were in the middle of the week: **Tuesday, Wednesday, and Thursday**. No day had a significant peak like Saturday for casual users, and usage was lower on the weekend days.

<p align="center">  
<img src= "https://github.com/thecharliesun/cyclistic.charliesun/blob/main/Visualizations/Day%20of%20Week.PNG?raw=true">
</p>
 
**Month**

 - Comparing the rides per month for user types showed virtually no differences in their trends. Both casual users and annual members used Cyclistic significantly more during spring and summer months with their peaks being in July and August respectively. 

<p align="center">  
<img src= "https://github.com/thecharliesun/cyclistic.charliesun/blob/main/Visualizations/Rides%20per%20Month.PNG?raw=true">
</p>

**Ride Locations**

 - Using the latitude and longtitude coordinates of ride start locations as geographical data points for rides, our visualization showed that there was a higher concentration of casual user rides near the lake shore compared to annual members.

<p align="center">  
<img src= "https://github.com/thecharliesun/cyclistic.charliesun/blob/main/Visualizations/Casual%20Ride%20Locations.PNG?raw=true">
</p>

 - While the annual members' density map does show a concentration of rides near the lake shore, it spans less area and is less dense.


<p align="center">  
<img src= "https://github.com/thecharliesun/cyclistic.charliesun/blob/main/Visualizations/Member%20Ride%20Locations.PNG?raw=true">
</p>


## Summary of Analysis

 - Casual users, compared to annual members, likely utilized Cyclistic more for recreation and leisure based on their **longer average ride durations, peak usage days (weekends), preference for electric bikes, and ride locations**. Casual users also used Cyclistic during the nighttime hours more than annual members (proportionally).

 - Annual members on the other hand, likely used Cyclistic more for commuting and as a general mode transportation. This observation is based on their **peak usage days and hours (weekdays; 8AM and 5PM), shorter average ride durations, and total volume of rides**. These insights indicate that annual members use Cyclistic more frequently  Annual members showed a relatively negligible difference in bike type preference.


 - However, our data did show some simliarities between the user types. Aside from the identical trend of rides in the spring and summer months, many casual users are likely also using Cyclistic for at least part of their commutes. While casual users did not have the same peak hour at 8AM, their highest usage hour was still 5PM. These metrics suggest that casual users are opting to use Cyclistic when their workday is over, and are in less of a rush compared to the morning. 


   
## Recommendations for Stakeholders


### Get casual users to think of Cyclistic for commuting more often

 - The data for casual users showed that many already do use Cyclistic to commute *from* work in the evenings, but not *to* work in the mornings. This could be for many reasons, but a logical guess is that they are in a hurry to get to work and/or don't want to show up sweaty and out of breath in business attire and thus opt for the faster and more traditional modes of transportation in the morning. 


 - Since casual users showed a preference for electric bikes, focus on marketing Cyclistic's electric bikes as an easy and quick way to still get a bike ride in on the way to work. Electric bikes showed a lower average ride duration across all user types, indicating that they are faster and more time-efficient. This makes them a great option for users who want to bike to work but are reluctant to due to logistical constraints. 

   
 - Use and promote referral incentives. Since so many annual members use Cyclistic to commute to work, they may have colleagues and co-workers who use the service casually, that could be converted into annual members by seeing Cyclistic as an option for commuting. For example: three free months of membership for both parties if a new user is referred and signs up for an annual membership.


### Give annual members a form of priority access to electric bikes 

 - As mentioned earlier, our data showed that casual users noticeably preferred electric bikes over classic bikes. This could be due to the ease and speed of rides with electric bikes. 
   
 - Aligning with the part of my first recommendation of marketing Cyclistic's electric bikes for commuting, giving priority access to new annual members at high traffic times/locations could incentivize casual users to purchase annual memberships.


### Focus marketing and advertising resources on high casual user traffic times and locations

 - Casual users used Cyclistic more during weekend days and spring and summer months. Since these are high traffic periods for casual users, there is more visibility for advertisements/marketing. 
   
  - Utilize advertisements across various channels (physical and digital) to advertise to casual users. If casual users are searching for/browsing through Chicago’s top tourist locations, restaurants, etc., ensure advertising/marketing visibility on digital platforms. Additionally, increase the presence of physical advertisements locations near Chicago's lake shore, where casual users showed a high volume of Cyclistic rides.

 - If a casual user is using a parking app in a busy or 'difficult to drive' location, advertise nearby Cyclistic stations so they might think *“Hmmm, next time, I could just use Cyclistic and bike from/to here. I could save on gas and parking AND see more of Chicago”*.

## Conclusion

My analysis revealed both differences and similarities in how casual users and annual members ride Cyclistic bikes. Casual users seem to favor Cyclistic for recreational purposes based on their usage data but are also likely using Cyclistic for commuting and transportation, though not as frequently or regularly as annual members. 


A combination of promoting Cyclistic’s fleet of electric bikes, using Cyclistic to commute, and focusing marketing and advertising resources on peak casual usage periods would make for a powerful campaign to sway casual users into becoming subscribing annual members.


## Additional Comments

### #nulls

I identified approximately 550,000 null values for station names/IDs among annual members and around 350,000 for casual users.

Annual members exhibit slightly more missing data in start_station compared to end_station, approximately 0.4% more. Ccasual users have fewer null values in start_station data, with a difference of about 14.6%. 

While the pattern may not directly impact our current analysis, it could be relevant for future considerations.

### #outliers

I examined ride durations and found that 97.5% of rides last less than an hour (5,577,916 out of 5,718,880). It's not at all unlikely for users to use their bikes for longer than one hour, so I don't want to simply omit all rides past one hour.

To filter out extreme cases, I implemented an eight-hour (480 minutes) cutoff, affecting only 10,674 rides (0.19%). Some of these rides extended to *multiple weeks*, which would greatly skew our analysis.

I acknowledge that this is not the ideal or perfect method to determine outliers, and there are scientific ways to more precisely do so, but the sheer volume of observations (almost 6 million) led to my decision to use some more pragmatic decisions for this analysis.

I played with methods like z-scores, interquartile range, and using the median absolute deviation, but I will first need to refresh and supplement my stats skills to effectively use these in future analyses.
