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
