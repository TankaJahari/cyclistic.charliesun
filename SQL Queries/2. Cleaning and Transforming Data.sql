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
--Rounding the ride duration to 2 decimal places. Also re-naming and rearranging some columns. 
CREATE TABLE `cyclistic.total_data_2023_v2` AS(
  SELECT 
ride_id, rideable_type AS bike_type, started_at, ended_at, member_casual AS user_type, start_lat, start_lng, end_lat, end_lng,
ROUND(TIMESTAMP_DIFF(ended_at, started_at, second)/60,2) AS ride_duration_minutes,
EXTRACT (DAYOFWEEK FROM started_at) AS day_of_week,
EXTRACT (MONTH FROM started_at) AS month_of_ride,
EXTRACT (HOUR FROM started_at) AS hour_of_ride,
start_station_name, end_station_name, start_station_id, end_station_id
FROM `cyclistic.total_data_2023`

 --Examining the minimum, maximum, and average ride durations for each user type:
SELECT AVG(ride_duration_minutes) AS avg,
MIN(ride_duration_minutes) AS min,
MAX(ride_duration_minutes) AS max, 
user_type
FROM `cyclistic.total_data_2023_v2`
GROUP BY user_type

--I'm suspecting that there might be rides with durations = 0. These could not be rides that actually happened, since their start and end time would have to be be exactly the same.
--This query returns a result of 997 rides with durations = 0.
SELECT 
COUNT(*) AS zero_rides
FROM `cyclistic.total_data_2023_v3`
WHERE ride_duration_minutes = 0

  
--RESULTS: The max ride duration for casual users was 98,489.07 minutes (roughly 68 days). The minimum was -16,656.52 minutes. Examining the data shows that these are outliers. These would skew results so we need to omit them. For this analysis, I'm excluding rides where the duration = 0 OR longer than 480 minutes. Rides like these are not regular use-cases for Cyclistic users, and shouldn't apply to our analysis. I will note in the visuazliations and presentations of this analysis that said datapoints are being excluded. #outliers  

--We have negative trip durations which at first glance seem omittable ("negative time??"), but my logic tells me that the start/end times were flipped due to a technical error. We can still get usable ride durations from these.
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
