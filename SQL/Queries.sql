-- EDA
select * from Dim_locations
select count(*) from Dim_locations

select * from Dim_Hotels
select count(*) from Dim_Hotels

select * from Dim_Properties
select count(*) from Dim_Properties


select * from Fact_Reviews
select count(*) from Fact_Reviews

---------------------------------------------------------
-- What is the average price per listing

select AVG(realSum) as AVG_PRICE 
from Fact_Reviews


-- How does average price vary by room type

select AVG(f.RealSum) as AVG_price , D.Room_Type 
from Fact_Reviews f inner join Dim_Properties D
on D.Property_ID = f.Property_ID
Group by D.Room_Type


-- What is the average price per person capacity

select AVG(RealSum) as AVG_price , D.Person_Capacity
from Fact_Reviews f , Dim_Properties D  
where D.Property_ID = f.Property_ID  
Group by D.Person_Capacity 


-- Does increasing the number of bedrooms proportionally increase price
select P.Bedrooms ,AVG(f.RealSum) as AVG_Price
from Dim_Properties P , Fact_Reviews f
Group by P.Bedrooms


-- Avg Price Shared / Private

select p.Room_Type,AVG(f.RealSum) AS avg_price
FROM Fact_Reviews f,Dim_Properties p
WHERE p.Room_Type IN ('Shared room', 'Private room')
GROUP BY p.Room_Type;


-- Avg RealSum by countries

SELECT l.Country, AVG(f.RealSum) AS avg_price
FROM Fact_Reviews f
JOIN Dim_Hotels h ON f.Hotel_ID = h.Hotel_ID
JOIN Dim_Locations l ON h.Location_ID = l.Location_ID
GROUP BY l.Country

 
-- Avg RealSum by cities

SELECT top l.City, AVG(f.RealSum) AS avg_price
FROM Fact_Reviews f
JOIN Dim_Hotels h ON f.Hotel_ID = h.Hotel_ID
JOIN Dim_Locations l ON h.Location_ID = l.Location_ID
GROUP BY l.City


--  Avg Guest_Satisfaction per Country

SELECT 
    l.Country,
    AVG(f.Guest_Satisfaction) AS avg_guest_satisfaction
FROM Fact_Reviews f
JOIN Dim_Hotels h ON f.Hotel_ID = h.Hotel_ID
JOIN Dim_Locations l ON h.Location_ID = l.Location_ID
GROUP BY l.Country
ORDER BY avg_guest_satisfaction DESC;  -- optional: most satisfied country first


-- Avg Cleanliness by Superhost

SELECT 
    p.Host_Is_Superhost,
    AVG(f.Cleanliness_Rating) AS avg_cleanliness
FROM Fact_Reviews f
JOIN Dim_Properties p ON f.Property_ID = p.Property_ID
GROUP BY p.Host_Is_Superhost;


-- Cleanliness_Rating vs RealSum

select f.Cleanliness_Rating, AVG(f.RealSum) AS avg_price
FROM Fact_Reviews f
GROUP BY f.Cleanliness_Rating
ORDER BY f.Cleanliness_Rating


-- Which room type is the most common
 
select count(*) as common ,p.Room_Type
from Dim_Properties p
group by p.Room_Type

-- Do private rooms generate higher guest satisfaction than shared rooms

SELECT 
    'Private' AS Room_Type,
    AVG(FR.Guest_Satisfaction) AS Avg_Guest_Satisfaction
FROM Fact_Reviews FR
JOIN Dim_Properties DP
    ON FR.Property_ID = DP.Property_ID
WHERE DP.Room_Private = 1

UNION ALL

SELECT 
    'Shared' AS Room_Type,
    AVG(FR.Guest_Satisfaction) AS Avg_Guest_Satisfaction
FROM Fact_Reviews FR
JOIN Dim_Properties DP
    ON FR.Property_ID = DP.Property_ID
WHERE DP.Room_Shared = 1;


-- What is the average guest satisfaction score
select AVG(f.Guest_Satisfaction) as Avg_
from Fact_Reviews f


-- Number of Bedrooms with Price
select p.Bedrooms ,AVG(f.RealSum) as Avg_price
from Dim_Properties P join Fact_Reviews f
on p.Property_ID = f.Property_ID
group by  p.Bedrooms


