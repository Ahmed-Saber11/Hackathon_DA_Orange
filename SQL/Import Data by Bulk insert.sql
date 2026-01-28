CREATE TABLE RawData_Staging (
    realSum NVARCHAR(MAX),
	room_type NVARCHAR(50),
	room_shared NVARCHAR(10), 
    room_private NVARCHAR(10),
	person_capacity NVARCHAR(50), 
	host_is_superhost NVARCHAR(10),
    multi NVARCHAR(50), 
	biz NVARCHAR(50), 
	cleanliness_rating NVARCHAR(50), 
    guest_satisfaction_overall NVARCHAR(50),
	bedrooms NVARCHAR(50), 
	dist NVARCHAR(50), 
    metro_dist NVARCHAR(50), 
	attr_index NVARCHAR(50),
	attr_index_norm NVARCHAR(50), 
    rest_index NVARCHAR(50), 
	rest_index_norm NVARCHAR(50),
	week_type NVARCHAR(20), 
    week_type_id NVARCHAR(50), 
	city NVARCHAR(50), 
	country NVARCHAR(50), 
    Hotel_Address NVARCHAR(MAX),
	Review_Date NVARCHAR(MAX),
	Average_Score NVARCHAR(50), 
    Hotel_Name NVARCHAR(MAX),
	Reviewer_Nationality NVARCHAR(100),
    Review_Total_Negative_Word_Counts NVARCHAR(MAX),  
    Total_Number_of_Reviews NVARCHAR(MAX),
    Review_Total_Positive_Word_Counts NVARCHAR(MAX),
    Total_Number_of_Reviews_Reviewer_Has_Given NVARCHAR(MAX),
    Reviewer_Score NVARCHAR(MAX),
	Tags NVARCHAR(MAX)
);

BULK INSERT RawData_Staging
FROM 'D:\Hackathon_DA\Final_Dataset.csv'
WITH (
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '0x0a', 
    FIRSTROW = 2,
    CODEPAGE = '65001',
    MAXERRORS = 100,  
    ERRORFILE = 'D:\Hackathon_DA\upload_errors.log' );


select distinct week_type from RawData_Staging