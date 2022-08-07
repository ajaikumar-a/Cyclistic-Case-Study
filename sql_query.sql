-- Selecting the Cyclistic database 

USE Cyclistic;



-- Combining the tables using UNION 

SELECT * INTO bikeshare

FROM (

  SELECT 

    *

  FROM

    [april2021]

UNION

  SELECT 

    *

  FROM

    [may2021]

UNION

  SELECT 

    *

  FROM

    [june2021]

UNION

  SELECT 

    *

  FROM

    [july2021]

UNION

  SELECT 

    *

  FROM

    [aug2021]

UNION

  SELECT 

    *

  FROM

    [sept2021]

UNION

  SELECT 

    *

  FROM

    [oct2021]

UNION

  SELECT 

    *

  FROM

    [nov2021]

UNION

  SELECT 

    *

  FROM

    [dec2021]

UNION

  SELECT 

    *

  FROM

    [jan2022]

UNION

  SELECT 

    *

  FROM

    [feb2022]

UNION

  SELECT 

    *

  FROM

    [mar2022]

) t 





-- Removing the records with NULL and 00:00:00 ride_length

DELETE 

FROM

  bikeshare

WHERE

  ride_length IS NULL OR 

  ride_length = '00:00:00'





-- Finding the number of rides per casual and annual members

SELECT 

  member_casual,

  COUNT(ride_id) no_of_rides 

FROM

  bikeshare

GROUP BY

  member_casual






-- Finding the number of rides per weekday

SELECT 

  weekday,

  COUNT(ride_id) weekday_rides

FROM 

  bikeshare

GROUP BY

  weekday

ORDER BY

  weekday_rides DESC;





-- finding the total number of rides

SELECT

  COUNT(ride_id) total_rides 

FROM

  bikeshare;





-- finding the number of round trips

SELECT

  COUNT(ride_id) round_trips

FROM

  bikeshare

WHERE

  start_station_name = end_station_name;





-- finding the number of non-round trips 

SELECT

  COUNT(ride_id) non_round_trips

FROM 

  bikeshare

WHERE

  start_station_name <> end_station_name;





-- finding the number of round trips per route

SELECT

  start_station_name,

  end_station_name,

  COUNT(ride_id) round_trips_per_route 

FROM

  bikeshare

WHERE

  start_station_name = end_station_name

GROUP BY

  start_station_name,

  end_station_name

ORDER BY

  round_trips_per_route DESC;





-- finding the number of non-round trips per route_

SELECT

  start_station_name,

  end_station_name,

  COUNT(ride_id) non_round_trips_per_route 

FROM

  bikeshare

WHERE

  start_station_name != end_station_name

GROUP BY

  start_station_name,

  end_station_name

ORDER BY

  non_round_trips_per_route DESC;  





-- finding the number of round trips by annual and casual members

SELECT

  member_casual,

  COUNT(ride_id) round_trips 

FROM 

  bikeshare

WHERE

  start_station_name = end_station_name

GROUP BY 

  member_casual




-- finding the number of non-round trips by annual and casual members

SELECT

  member_casual,

  COUNT(ride_id) non_round_trips 

FROM 

  bikeshare

WHERE

  start_station_name <> end_station_name

GROUP BY 

  member_casual




-- finding the TOP 50 routes 

SELECT TOP 50

  CONCAT(start_station_name, ' - ', end_station_name) route,

  COUNT(ride_id) trips_per_route 

FROM

  bikeshare 

GROUP BY

 CONCAT(start_station_name, ' - ', end_station_name)

ORDER BY

  trips_per_route DESC;




-- finding the TOP 50 routes with round trips 

SELECT TOP 50

  CONCAT(start_station_name, ' - ', end_station_name) route,

  COUNT(ride_id) round_trips_per_route 

FROM

  bikeshare

WHERE

  start_station_name = end_station_name 

GROUP BY

 CONCAT(start_station_name, ' - ', end_station_name)

ORDER BY

  round_trips_per_route DESC;





-- finding the TOP 50 routes with non-round trips 

SELECT TOP 50

  CONCAT(start_station_name, ' - ', end_station_name) route,

  COUNT(ride_id) non_round_trips_per_route 

FROM

  bikeshare

WHERE

  start_station_name != end_station_name 

GROUP BY

 CONCAT(start_station_name, ' - ', end_station_name)

ORDER BY

  non_round_trips_per_route DESC;




-- finding the distribution of rideable_type

SELECT

  member_casual,

  rideable_type,

  COUNT(ride_id) no_of_rides 

FROM

  bikeshare

GROUP BY

  member_casual,

  rideable_type





-- finding the distribution of rideable_type and member_casual in round trips

SELECT

  member_casual,

  rideable_type,

  COUNT(ride_id) round_trips 

FROM 

  bikeshare

WHERE

  start_station_name = end_station_name

GROUP BY

  member_casual,

  rideable_type

ORDER BY 

  round_trips DESC;



-- finding the distribution of rideable_type and member_casual in non-round trips

  SELECT

  member_casual,

  rideable_type,

  COUNT(ride_id) non_round_trips 

FROM 

  bikeshare

WHERE

  start_station_name <> end_station_name

GROUP BY

  member_casual,

  rideable_type

ORDER BY 

  non_round_trips DESC;




-- finding the distribution of casual and annual members across the year

SELECT

  member_casual,

  CONCAT(DATEPART(MONTH, started_at), ' ', DATEPART(YEAR, started_at)) mon_year,

  COUNT(ride_id) rides 

FROM

  bikeshare

GROUP BY

  member_casual,

  concat(DATEPART(MONTH, started_at), ' ', DATEPART(YEAR, started_at))

ORDER BY

  rides DESC;





-- finding the distribution of casual members across the year

SELECT

  member_casual,

  CONCAT(DATEPART(MONTH, started_at), ' ', DATEPART(YEAR, started_at)) mon_year,

  COUNT(ride_id) rides 

FROM

  bikeshare

WHERE

  member_casual = 'casual'

GROUP BY

  member_casual,

  concat(DATEPART(MONTH, started_at), ' ', DATEPART(YEAR, started_at))

ORDER BY

  rides DESC;






-- finding the distribution of annual members across the year

SELECT

  member_casual,

  CONCAT(DATEPART(MONTH, started_at), ' ', DATEPART(YEAR, started_at)) mon_year,

  COUNT(ride_id) rides 

FROM

  bikeshare

WHERE

  member_casual = 'member'

GROUP BY

  member_casual,

  CONCAT(DATEPART(MONTH, started_at), ' ', DATEPART(YEAR, started_at))

ORDER BY

  rides DESC;






/*
> ### _Best performing months_
*/

-- combining the best performing months into a table

SELECT

  *

INTO best_months 

FROM

(  SELECT 

    *

  FROM

    [june2021]

UNION

  SELECT 

    *

  FROM

    [july2021]

UNION

  SELECT 

    *

  FROM

    [aug2021]

UNION

  SELECT 

    *

  FROM

    [sept2021]) b 





-- finding the distribution of weeekday rides across the best performing months 

SELECT

  member_casual,

  weekday,

  COUNT(ride_id) day_rides 

FROM

  best_months 

GROUP BY

  member_casual,

  weekday

ORDER BY

  day_rides DESC;





-- finding the distribution of rideable_type and member_casual across the best performing months 

SELECT

  member_casual,

  rideable_type,

  COUNT(ride_id) rides 

FROM

  best_months 

GROUP BY

  member_casual,

  rideable_type   

ORDER BY

  rides DESC;




/*
> ### _Worst performing months_
*/

-- creating a table for the worst performing months 

SELECT 

  *

INTO worst_months 

FROM

(SELECT 

    *

  FROM

    [dec2021]

UNION

  SELECT 

    *

  FROM

    [jan2022]

UNION

  SELECT 

    *

  FROM

    [feb2022]

UNION

  SELECT 

    *

  FROM

    [mar2022]) w 





-- finding the distribution of weekday rides across the worst performing months

SELECT 

  member_casual,

  weekday,

  COUNT(ride_id) weekday_rides

FROM

  worst_months

GROUP BY

  member_casual,

  weekday

ORDER BY 

  weekday_rides DESC;
  
-- **--**--**--**--**-- **--**--**--**--**-- **--**--**--**--**-- **--**--**--**--**-- **--**--**--**--**-- **--**--**--**--**-- **--**--**--**--**