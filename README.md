# Cyclistic Case Study 

## Business Task

  In this case study, I am tasked with finding key differences in how annual members and casual users use Cyclistic bikeshare. 
  
  I will use these differences to provide insights and recommendations to our stakeholders to achieve their goal of convert casual users into annual members through digital marketing.

  
## Data Sources, Data Cleaning, and Manipulation

 Our data [source](https://divvy-tripdata.s3.amazonaws.com/index.html) comes directly from the primary source: Cyclistic Bikeshare services (Divvy). The data is open and made available to use by [this license agreement](https://divvybikes.com/data-license-agreement). It comes in the form of 12 .csv files, one for each month of 2023.

  I chose to use SQL in BigQuery to gather, clean, and analyze our data. Because of the quantity of data (nearly 6 million rows with 13 columns), a spreadsheet tool would be quite unwieldy to use for this task.
  
  [Click here for full SQL Query](https://github.com/TankaJahari/cyclistic.charliesun/blob/main/Data%20Cleaning%20and%20Manipulation.sql) 
  
  
  (*Please Note: For null values and statistical outliers in my analysis, I've included (#) tags to reference my 'comments' file in the this repository that provides a bit of background information and explanation.*)


## Supporting Visualizations and Key Findings

*tableau dashboard link*

### Total Rides

 - Of the 5,708,202 rides in our analysis, casual users accounted for ~36% (2,050,268) of the total, and annual users accounted for ~64% (3,657,934). 

### Ride Durations

 - Casual member rides lasted longer than annual member rides. On average, casual user rides lasted over 19 minutes while annual member rides lasted just under 12 minutes.

### Bike Types

 - There are three bike types in our data: classic, electric, and docked. 

 - Casual users had significantly more rides with electric bikes than classic bikes: 870,859 classic bike rides, 1,103,644 electric bike rides, and 75,765 docked bike rides. Docked bikes were used exclusively by casual users, but only accounted for 3.6% of their total rides.

 - Annual members used classic and electric bikes nearly evenly: 1,816,875 classic bike rides vs. 1,841,059 electric bike rides.

 - Overall, rides with electric bikes were roughly four minutes shorter than classic bike rides. For annual members, electric bike rides were only shorter than classic bike rides by about one minute. For casual users, electric bike rides . 

### Hour of Day

 - Visualizing the data for rides per hour of day showed both similarities as well as differences in the two user types.

 - For casual users, the ride count started low in the morning but continuously rose throughout the day and **peaked at 5PM** before a decline into the nighttime hours.

 - For annual members, the ride count also started low in the early morning, but rose more rapidly and **spiked at 8AM**. It then trailed off until 12PM before rising again and **peaked at 5PM**. There was a steeper decline into the nighttime hours for annual members. 


### Day of Week

 - For casual users, the highest usage days were weekend days: **Friday, Saturday, and Sunday**, significantly peaking on Saturday.

 - For annual members, the highest usage days were in the middle of the week: **Tuesday, Wednesday, and Thursday**. No day had a significant peak, and usage dropped off on the weekend days.
 
### Month

 - Comparing the rides per month for user types showed virtually no differences in their trends. Both casual users and annual members used Cyclistic significantly more during spring and summer months with their peaks being in July and August respectively. 


### Ride Locations

 - Using the latitude and longtitude coordinates of ride start locations as geographical data points for rides, our visualization showed that there was a higher concentration of rides for casual users near the lake shore compared to annual members.

 - While the annual members' density map does show a concentration of rides near the lake shore, it spans less area and is less dense.

## Summary of Analysis

 - Casual users, compared to annual members, likely utilized Cyclistic more for recreation and leisure based on their **longer average ride durations, peak usage days (weekends), preference for electric bikes, and ride locations**. Casual users were also the sole users of docked bikes.

 - Annual members on the other hand, likely used Cyclistic more for commuting and as a general mode transportation. This observation is based on their **peak usage days and hours (weekdays; 8AM and 5PM), shorter average ride durations, and total volume of rides**. These insights indicate that annual members use Cyclistic more frequently  Annual members showed a relatively negligible difference in bike type preference.


 - However, our data did show some simliarities between the user types. Aside from the identical trend of rides in the spring and summer months, many casual users are likely also using Cyclistic for at least part of their commutes. While casual users did not have a peak hour at 8AM, their highest usage hour was still at 5PM. These metrics suggest that casual users are opting to use Cyclistic when their workday is over, and are in less of a rush compared to the morning. 


   
## Recommendations for Our Stakeholders


### Get casual users to think of Cyclistic for commuting more often

 - The data for casual users showed that many already do use Cyclistic to commute *from* work in the evenings, but not *to* work in the mornings. This could be for many reasons, but a logical guess is that they are in a hurry to get to work and/or don't want to show up sweaty and out of breath in business attire and thus opt for the faster and more traditional modes of transportation in the morning. 


Since casual users showed a preference for electric bikes, focus on marketing Cyclistic's electric bikes as an easy and quick way to still get a bike ride in on the way to work. Electric bikes showed a lower average ride duration across all user types, indicating that they are faster and more time-efficient. This makes them a great option for users who want to bike to work but are reluctant to due to logistical constraints. 

   
 - Use and promote referral incentives. Since so many annual members use Cyclistic to commute to work, they may have colleagues and co-workers who use the service casually, that could be converted into annual members by seeing Cyclistic as an option for commuting. For example: three free months of membership for both parties if a new user is referred and signs up for an annual membership.


### Give annual members priority access to electric bikes 

 - As mentioned earlier, our data showed that casual users preferred electric bikes a fair amount over classic bikes. 
   
 - Utilize ads on various digital channels (search engine ads, social media platforms) to advertise Cyclistic when users are searching for or browsing through Chicago’s top tourist locations, restaurants, etc.


### Focus marketing and advertising resources on high casual user traffic times and locations

 - Casual users used Cyclistic more on the weekend days and in the spring and summer months. Since casual users are using Cyclistic more during these time periods, there is value to gain from focusing advertising resources when users .

 - If a casual user is using a parking app in a busy or “difficult to drive” location, advertise nearby Cyclistic stations so they might think *“Hmmm, next time, I could just use Cyclistic and bike from/to here. I could save on gas and parking AND see more of Chicago”*.

   
