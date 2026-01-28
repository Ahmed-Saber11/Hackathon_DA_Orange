-- Dim_Locations  --> done
CREATE TABLE Dim_Locations (
    Location_ID INT IDENTITY(1,1) PRIMARY KEY,
    City NVARCHAR(100),
    Country NVARCHAR(100)
);
 
-- Dim_Hotels   --> done
CREATE TABLE Dim_Hotels (
    Hotel_ID INT IDENTITY(1,1) PRIMARY KEY,
    Hotel_Name NVARCHAR(500),
    Hotel_Address NVARCHAR(MAX),
    Average_Score FLOAT,
    Location_ID INT FOREIGN KEY REFERENCES Dim_Locations(Location_ID)
);

--  Dim_Properties  --> done
CREATE TABLE Dim_Properties (
    Property_ID INT IDENTITY(1,1) PRIMARY KEY,
    Room_Type NVARCHAR(100),
    Room_Shared BIT,     
    Room_Private BIT,
    Person_Capacity INT,
    Host_Is_Superhost BIT,
    Bedrooms INT,
    Multi BIT,
    Biz BIT
);

-- Fact_Reviews
 CREATE TABLE Fact_Reviews (
    Review_ID INT IDENTITY(1,1) PRIMARY KEY,
    Hotel_ID INT FOREIGN KEY REFERENCES Dim_Hotels(Hotel_ID),
    Property_ID INT FOREIGN KEY REFERENCES Dim_Properties(Property_ID),
    RealSum FLOAT,
    Review_Date DATETIME,
    Cleanliness_Rating FLOAT,
    Guest_Satisfaction FLOAT,
    Dist_From_Center FLOAT,
    Metro_Dist FLOAT,
    Attr_Index FLOAT,
    Rest_Index FLOAT,
    Reviewer_Score FLOAT,
    Reviewer_Nationality NVARCHAR(100),
    Tags NVARCHAR(MAX),
    Week_Type NVARCHAR(20)
);


-- insert Data in Tables
INSERT INTO Dim_Locations (city, country)
SELECT DISTINCT city, country 
FROM Dim_Locations 
-- WHERE city IS NOT NULL;

select * from Dim_Locations


---
INSERT INTO Dim_Properties (Room_Type, Room_Shared, Room_Private, Person_Capacity, Host_Is_Superhost, Bedrooms, Multi, Biz)
SELECT DISTINCT 
    room_type, 
    CASE WHEN room_shared = 'True' THEN 1 ELSE 0 END,
    CASE WHEN room_private = 'True' THEN 1 ELSE 0 END,
    TRY_CAST(person_capacity AS INT),
    CASE WHEN host_is_superhost = 'True' THEN 1 ELSE 0 END,
    TRY_CAST(bedrooms AS INT),
    TRY_CAST(multi AS BIT),
    TRY_CAST(biz AS BIT)
FROM RawData_Staging;

select * from Dim_Properties


----
INSERT INTO Dim_Hotels (Hotel_Name, Hotel_Address, Average_Score, Location_ID)
SELECT DISTINCT 
    S.Hotel_Name, 
    S.Hotel_Address, 
    TRY_CAST(S.Average_Score AS FLOAT), 
    L.Location_ID
FROM RawData_Staging S
JOIN Dim_Locations L ON S.city = L.City AND S.country = L.Country;

select * from Dim_Hotels


--
INSERT INTO Fact_Reviews (Hotel_ID, Property_ID, RealSum, Review_Date, Cleanliness_Rating, Guest_Satisfaction,
Dist_From_Center, Metro_Dist, Attr_Index, Rest_Index, Reviewer_Score, Reviewer_Nationality, Tags, Week_Type)
SELECT Top(2000000)
    H.Hotel_ID, 
    P.Property_ID,
    TRY_CAST(S.realSum AS FLOAT),
    TRY_CAST(S.Review_Date AS DATETIME),
    TRY_CAST(S.cleanliness_rating AS FLOAT),
    TRY_CAST(S.guest_satisfaction_overall AS FLOAT),
    TRY_CAST(S.dist AS FLOAT),
    TRY_CAST(S.metro_dist AS FLOAT),
    TRY_CAST(S.attr_index AS FLOAT),
    TRY_CAST(S.rest_index AS FLOAT),
    TRY_CAST(S.Reviewer_Score AS FLOAT),
    S.Reviewer_Nationality,
    S.Tags,
    S.week_type
FROM RawData_Staging S
JOIN Dim_Hotels H ON S.Hotel_Name = H.Hotel_Name AND S.Hotel_Address = H.Hotel_Address
JOIN Dim_Properties P ON S.room_type = P.Room_Type 
    AND TRY_CAST(S.person_capacity AS INT) = P.Person_Capacity
    AND TRY_CAST(S.bedrooms AS INT) = P.Bedrooms;
	
