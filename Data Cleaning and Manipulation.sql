--First, I uploaded each month's .csv file to BigQuery (data from https://divvy-tripdata.s3.amazonaws.com/index.html) 

--The datasets all have identical columns, so we can aggregate them into one dataset for the entire year's trip data. 

--Created new table as 'cyclistic.total_data_2023' using UNION function (JOINs do not apply in this scenario).
CREATE TABLE `cyclistic.total_data_2023` AS (
 SELECT * 
 FROM `crack-mariner-411305.cyclistic.cyclistic_2023_01`
 UNION ALL
 SELECT *
 FROM `crack-mariner-411305.cyclistic.cyclistic_2023_02`
 UNION ALL
 SELECT *
 FROM `crack-mariner-411305.cyclistic.cyclistic_2023_03`
 UNION ALL
 SELECT *
 FROM `crack-mariner-411305.cyclistic.cyclistic_2023_04`
 UNION ALL
 SELECT *
 FROM `crack-mariner-411305.cyclistic.cyclistic_2023_05`
 UNION ALL
 SELECT *
 FROM `crack-mariner-411305.cyclistic.cyclistic_2023_06`
 UNION ALL
 SELECT *
 FROM `crack-mariner-411305.cyclistic.cyclistic_2023_07`
 UNION ALL
 SELECT *
 FROM `crack-mariner-411305.cyclistic.cyclistic_2023_08`
 UNION ALL
 SELECT *
 FROM `crack-mariner-411305.cyclistic.cyclistic_2023_09`
 UNION ALL
 SELECT *
 FROM `crack-mariner-411305.cyclistic.cyclistic_2023_10`
 UNION ALL
 SELECT *
 FROM `crack-mariner-411305.cyclistic.cyclistic_2023_11`
 UNION ALL
 SELECT *
 FROM `crack-mariner-411305.cyclistic.cyclistic_2023_12`
)

--Checking for duplicate ride_ids in new dataset. Duplicate rows would need to addressed since ride_id is specific to each ride. 
--RESULTS: The query returned 0 duplicate rows.
SELECT COUNT(ride_id) - COUNT(Distinct(ride_id)) AS duplicate_ride_id_count
FROM `cyclistic.total_data_2023`


--Checking for null values in our dataset.
--RESULTS: Nulls found only in the `start` and `end` station names/ids for both member types. #nulls
SELECT 
member_casual,
COUNTIF(ride_id IS NULL) AS null_ride_id,
COUNTIF(rideable_type IS NULL) AS null_count_rideable_type,
COUNTIF(started_at IS NULL) AS null_count_started_at,
COUNTIF(ended_at IS NULL) AS null_count_ended_at,
COUNTIF(start_station_name IS NULL) AS null_count_start_station_name,
COUNTIF(start_station_ID IS NULL) AS null_count_start_station_id,
COUNTIF(end_station_name IS NULL) AS null_count_end_station_name,
COUNTIF(end_station_id IS NULL) AS null_count_end_station_id,
COUNTIF(start_lat IS NULL) AS null_count_start_lat,
COUNTIF(start_lng IS NULL) AS null_count_start_lng,
COUNTIF(end_lat IS NULL) AS null_count_end_lat,
COUNTIF(end_lng IS NULL) AS null_count_end_lng,
COUNTIF(member_casual IS NULL) AS null_count_member_casual
FROM `cyclistic.total_data_2023`
group by member_casual 

--Creating a new table with new columns calculated from started_at data that lets us observe datapoints like each ride's duration, hour of the day, day of week, and month. 
--Rounding the ride duration to 2 decimal points. Also re-naming and rearranging some columns. 
CREATE TABLE `cyclistic.total_data_2023_v2` AS(
  SELECT 
ride_id, rideable_type AS bike_type, started_at, ended_at, member_casual AS user_type, start_lat, start_lng, end_lat, end_lng,
ROUND(TIMESTAMP_DIFF(ended_at, started_at, second)/60,2) AS ride_duration_minutes,
EXTRACT (DAYOFWEEK FROM started_at) AS day_of_week,
EXTRACT (MONTH FROM started_at) AS month_of_ride,
EXTRACT (HOUR FROM started_at) AS hour_of_ride,
start_station_name, end_station_name, start_station_id, end_station_id
FROM `cyclistic.total_data_2023`
)

--Examining at the minimum, maximum, and average ride durations for each user type:
SELECT AVG(ride_duration_minutes) AS avg,
MIN(ride_duration_minutes) AS min,
MAX(ride_duration_minutes) AS max, 
user_type
FROM `cyclistic.total_data_2023_v2`
GROUP BY user_type

--RESULTS: The max ride duration for casual users was 98,489.07 minutes (roughly 68 days). The minimum was -16,656.52 minutes. Examining the data shows that these are outliers. These would skew results so we need to omit them. For this analysis, I'm excluding rides where the duration = 0 OR longer than 480 minutes. Rides like these are not regular use-cases for Cyclistic users, and shouldn't apply to our analysis. I will note in the visuazliations and presentations of this analysis that said datapoints are being excluded. #outliers  

--We have negative trip durations which at first glance seem omittable (negative time???), but my logic tells me that the start/end times were flipped due to a technical error. We can still get usable ride durations from these.

--Converting negative ride durations to positive using their absolute values. Omitting rides that lasted 480 minutes or more. #outliers
CREATE TABLE `cyclistic.total_data_2023_v4` AS(
SELECT 
ride_id, bike_type, started_at, ended_at, user_type, start_lat, start_lng, end_lat, end_lng,
ABS(ride_duration_minutes) AS ride_duration_minutes,
day_of_week,month_of_ride,hour_of_ride,start_station_name, end_station_name, start_station_id, end_station_id
FROM `cyclistic.total_data_2023_v2`
WHERE started_at != ended_at 
AND 
ABS(ride_duration_minutes) < 480
)

--From `total_data_2023_v4`, I will run different queries to aggregate data into new tables by attributes like month, day, etc. These individual tables will be smaller files and easier to work with in Tableau.

--Creating a table with total rides by user_type
CREATE TABLE `cyclistic.total` AS(
SELECT 
COUNT(*) AS total_rides,
AVG(ride_duration_minutes) AS avg_ride_duration,
user_type
FROM `cyclistic.total_data_2023_v4`
GROUP BY user_type
)

--Rides per day of week
--Using CASE statements for month and day tables so integers will display as strings with full month/day names. 
--Also using the CASE statement in the ORDER BY clauses to order the data chronologically. 
CREATE TABLE `cyclistic.days` AS(
SELECT 
  count(*) AS ride_count,
  user_type,
CASE
  WHEN day_of_week = 1 THEN 'Sunday'
  WHEN day_of_week = 2 THEN 'Monday'
  WHEN day_of_week = 3 THEN 'Tuesday'
  WHEN day_of_week = 4 THEN 'Wednesday'
  WHEN day_of_week = 5 THEN 'Thursday'
  WHEN day_of_week = 6 THEN 'Friday'
  WHEN day_of_week = 7 THEN 'Saturday' END AS day_of_week
FROM `cyclistic.total_data_2023_v4`
GROUP BY day_of_week, user_type
ORDER BY
CASE day_of_week
  WHEN 'Monday' THEN 2
  WHEN 'Tuesday' THEN 3
  WHEN 'Wednesday' THEN 4
  WHEN 'Thursday' THEN 5
  WHEN 'Friday' THEN 6
  WHEN 'Saturday' THEN 7
  WHEN 'Sunday' THEN 1
END
)

--Rides per month
CREATE TABLE `cyclistic.months` AS(
SELECT 
  count(*) AS ride_count,
  user_type,
CASE
  WHEN month_of_ride = 1 THEN 'January'
  WHEN month_of_ride = 2 THEN 'February'
  WHEN month_of_ride = 3 THEN 'March'
  WHEN month_of_ride = 4 THEN 'April'
  WHEN month_of_ride = 5 THEN 'May'
  WHEN month_of_ride = 6 THEN 'June'
  WHEN month_of_ride = 7 THEN 'July'
  WHEN month_of_ride = 8 THEN 'August'
  WHEN month_of_ride = 9 THEN 'September'
  WHEN month_of_ride = 10 THEN 'October'
  WHEN month_of_ride = 11 THEN 'November'
  WHEN month_of_ride = 12 THEN 'December' END AS month_of_ride
FROM `cyclistic.total_data_2023_v4`
GROUP BY month_of_ride, user_type
ORDER BY
CASE month_of_ride
    WHEN 'January' THEN 1
    WHEN 'February' THEN 2
    WHEN 'March' THEN 3
    WHEN 'April' THEN 4
    WHEN 'May' THEN 5
    WHEN 'June' THEN 6
    WHEN 'July' THEN 7
    WHEN 'August' THEN 8
    WHEN 'September' THEN 9
    WHEN 'October' THEN 10
    WHEN 'November' THEN 11
    WHEN 'December' THEN 12
  END
)

--Rides per hour of day
SELECT 
  COUNT(*) AS ride_count,
  hour_of_ride,
  user_type,
FROM `cyclistic.total_data_2023_v4`
GROUP BY
  hour_of_ride, user_type
ORDER BY 
  hour_of_ride

--Rides per bike type 
--(Annual members had 0 'docked bike' rides. The lack of nulls in bike type data confirms that the count is zero)
CREATE TABLE `cyclistic.biketype` AS(
SELECT bike_type,
user_type,
COUNT(*) as ride_count,
FROM `cyclistic.total_data_2023_v4` 
GROUP BY bike_type, user_type
)

--Ride start location coordinates
CREATE TABLE `cyclistic.start_coordinates` AS(
  SELECT
start_lat, start_lng, 
user_type
FROM `cyclistic.total_data_2023_v4`
)

--END



