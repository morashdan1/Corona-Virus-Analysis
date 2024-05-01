use coronavirus ;
-- To avoid any errors, check missing value / null value 
-- Q1. Write a code to check NULL values
select * from [Corona Virus Dataset] where Province is null 
or Country_Region is null
or Latitude is null
or Longitude is null
or Date is null
or Confirmed is null
or Deaths is null
or Recovered is null;
--Q2. If NULL values are present, update them with zeros for all columns. 
update [Corona Virus Dataset]
set Latitude = 0 
where Latitude is null ;

update [Corona Virus Dataset]
set Longitude = 0 
where Longitude is null ;
-- Q3. check total number of rows
select count (*) as tatal_num_of_rows
from [Corona Virus Dataset] ;
-- Q4. Check what is start_date and end_date
select min(Date) as start_date , max (Date) as end_date 
from [Corona Virus Dataset]  ;
-- Q5. Number of month present in dataset
select DATEDIFF(MONTH , MIN(Date) , MAX(Date) ) as num_of
from [Corona Virus Dataset];
-- Q6. Find monthly average for confirmed, deaths, recovered
select MONTH(Date),year (Date) , AVG (Confirmed) as avg_coformed , avg( Deaths ) as avg_death , avg( Recovered) as avg_rec
from [Corona Virus Dataset]
group by MONTH(Date) , year (Date);
-- Q7. Find most frequent value for confirmed, deaths, recovered each month 
WITH ModeCounts AS
(
    SELECT
         YEAR([Date]) AS Year,
MONTH([Date]) AS Month, [Confirmed],
           ROW_NUMBER() OVER (PARTITION BY YEAR([Date]),
MONTH([Date]) ORDER BY COUNT(*) DESC) AS ModeRank
    FROM [Corona Virus Dataset]
    GROUP BY YEAR([Date]), MONTH([Date]), [Confirmed]
)
SELECT [Year], [Month], [Confirmed] AS ModeConfirmed
FROM [ModeCounts]
WHERE [ModeRank] = 1;
-----------------------
WITH ModeCounts AS
(
    SELECT
         YEAR([Date]) AS Year,
MONTH([Date]) AS Month, [Recovered],
           ROW_NUMBER() OVER (PARTITION BY YEAR([Date]),
MONTH([Date]) ORDER BY COUNT(*) DESC) AS ModeRank
    FROM [Corona Virus Dataset]
    GROUP BY YEAR([Date]), MONTH([Date]), [Recovered]
)
SELECT [Year], [Month], [Recovered] AS ModeRecovered
FROM [ModeCounts]
WHERE [ModeRank] = 1;
-------------------------
WITH ModeCounts AS
(
    SELECT
         YEAR([Date]) AS Year,
MONTH([Date]) AS Month, [Deaths],
           ROW_NUMBER() OVER (PARTITION BY YEAR([Date]),
MONTH([Date]) ORDER BY COUNT(*) DESC) AS ModeRank
    FROM [Corona Virus Dataset]
    GROUP BY YEAR([Date]), MONTH([Date]), [Recovered]
)
SELECT [Year], [Month], [Deaths] AS ModeDeaths
FROM [ModeCounts]
WHERE [ModeRank] = 1;
-- Q8. Find minimum values for confirmed, deaths, recovered per year
select year(Date) as year ,min(Recovered)as min_recoverd 
from [Corona Virus Dataset]
group by year (Date);

select year(Date) as year , min(Confirmed)as min_confirmed
from [Corona Virus Dataset]
group by year (Date);

select year(Date) as year ,
min(Deaths) as min_death
from [Corona Virus Dataset]
group by year (Date);
-- Q9. Find maximum values of confirmed, deaths, recovered per year
select year(Date) as year ,max(Recovered)as max_recoverd 
from [Corona Virus Dataset]
group by year (Date);

select year(Date) as year , max(Confirmed)as max_confirmed
from [Corona Virus Dataset]
group by year (Date);

select year(Date) as year ,
max(Deaths) as max_death
from [Corona Virus Dataset]
group by year (Date);

-- Q10. The total number of case of confirmed, deaths, recovered each month
select year(Date) as year ,sum(Recovered)as total_recoverd 
from [Corona Virus Dataset]
group by year (Date);

select year(Date) as year , sum(Confirmed)as total_confirmed
from [Corona Virus Dataset]
group by year (Date);

select year(Date) as year ,
sum(Deaths) as total_death
from [Corona Virus Dataset]
group by year (Date);

-- Q11. Check how corona virus spread out with respect to confirmed case
--      (Eg.: total confirmed cases, their average, variance & STDEV )
select sum (Confirmed) as total_Confirmed , avg (Confirmed)  as avg_Confirmed, 
       VAR ( Confirmed)  as variance, STDEV( Confirmed) as STDEV
from [Corona Virus Dataset];
-- Q12. Check how corona virus spread out with respect to death case per month
--      (Eg.: total confirmed cases, their average, variance & STDEV )
select MONTH(Date) as month , YEAR (Date) as year, sum (Deaths) as total_death , avg (Deaths)  as avg_death, 
        VAR ( Deaths)  as variance, STDEV( Deaths) as STDEV
from [Corona Virus Dataset]
group by MONTH(Date), YEAR (Date) ;
-- Q13. Check how corona virus spread out with respect to recovered case
--      (Eg.: total confirmed cases, their average, variance & STDEV )
select sum (Recovered) as total_Recovered , avg (Recovered)  as avg_Recovered, 
       VAR ( Recovered)  as variance, STDEV( Recovered) as STDEV
from [Corona Virus Dataset];
-- Q14. Find Country having highest number of the Confirmed case
--  the highest confirmed recorded in a day 
select  top 1 Country_Region , max(Confirmed) as total 
from [Corona Virus Dataset]
group by Country_Region 
order by total desc ;
--the highest confirmed recorded overall
select  top 1 Country_Region , sum(Confirmed) as total 
from [Corona Virus Dataset]
group by Country_Region 
order by total desc ;
-- Q15. Find Country having lowest number of the death case
select  TOP 1 Country_Region , sum(Deaths) as total 
from [Corona Virus Dataset]
 group by Country_Region 
 order by total ASC ;

-- Q16. Find top 5 countries having highest recovered case
select   TOP 5 Country_Region , sum(Recovered) as total 
from [Corona Virus Dataset]
group by Country_Region 
order by total desc ;