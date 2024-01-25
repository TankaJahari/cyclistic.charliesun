--I downloaded each the dataset for each month in 2023 from this source: https://divvy-tripdata.s3.amazonaws.com/index.html 

--Then, I uploaded each month's .csv file to BigQuery.

--The datasets all have identical columns, so we can aggregate them into one dataset for the entire year's trip data. 

--Created new table as 'cyclistic.total_data_2023' using UNION ALL function to return all rows, and will manually check for duplicates.
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
