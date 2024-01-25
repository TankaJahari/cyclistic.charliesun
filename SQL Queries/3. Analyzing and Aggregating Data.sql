--From `total_data_2023_v3`, I will run different queries to aggregate data into new tables by attributes like month, day, etc. These individual tables will be smaller files and easy to work with in Tableau.

--Creating a table with total rides by user_type
CREATE TABLE `cyclistic.total` AS(
SELECT 
COUNT(*) AS total_rides,
AVG(ride_duration_minutes) AS avg_ride_duration,
user_type
FROM `cyclistic.total_data_2023_v3`
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
FROM `cyclistic.total_data_2023_v3`
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
FROM `cyclistic.total_data_2023_v3`
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

--Rides per hour of day (saved as table by exporting results rather than using 'CREATE TABLE' function)
SELECT 
  COUNT(*) AS ride_count,
  hour_of_ride,
  user_type,
FROM `cyclistic.total_data_2023_v3`
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
FROM `cyclistic.total_data_2023_v3` 
GROUP BY bike_type, user_type
)

--Average Ride Duration per bike type
CREATE TABLE `cyclistic.biketype_duration` AS(
SELECT bike_type,
AVG(ride_duration_minutes) AS avg_duration
FROM `cyclistic.total_data_2023_v3`
GROUP BY bike_type
)

--Average Ride Duration per bike type and user type
CREATE TABLE `cyclistic.biketype_users_duration` AS(
SELECT bike_type,
user_type,
AVG(ride_duration_minutes) AS avg_duration
FROM `cyclistic.total_data_2023_v3`
GROUP BY bike_type, user_type
)

--Ride start location coordinates
CREATE TABLE `cyclistic.start_coordinates` AS(
  SELECT
start_lat, start_lng, 
user_type
FROM `cyclistic.total_data_2023_v3`
)
