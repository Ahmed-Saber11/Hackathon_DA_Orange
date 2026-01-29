## Orange Data Analytics Hackathon
![Python](https://img.shields.io/badge/Python-3776AB?style=for-the-badge&logo=python&logoColor=white)
![Power BI](https://img.shields.io/badge/Power_BI-F2C811?style=for-the-badge&logo=powerbi&logoColor=black)
![SQL](https://img.shields.io/badge/SQL-CC2927?style=for-the-badge&logo=postgresql&logoColor=white)
![Web Scraping](https://img.shields.io/badge/Web_Scraping-FF6F00?style=for-the-badge&logo=data-stack&logoColor=white)

##  Project Overview
An advanced data engineering and analytics project focused on transforming raw, fragmented data into a structured **Snowflake Schema**. The highlight of this project is the innovative use of **Web Scraping** to handle missing values, ensuring 100% data accuracy instead of traditional estimation.

---

## Data Architecture Pipeline

### 1️⃣ Data Enrichment & Cleaning
* **Merge:** Combined multiple datasets from different sources.
* **Intelligent Scraping:** Developed a custom scraper to fill `Null` values by fetching real-time data from external web sources.
* **Preprocessing:** Applied data type conversion, outlier handling, and text cleaning.

### 2️⃣ Data Modeling (Schema Design)
* **Normalization:** Decomposed tables to **3NF** (Third Normal Form).
* **Snowflake Schema:** Optimized the architecture for analytical performance by creating:
    * **Fact Tables:** Containing quantitative metrics.
    * **Dimension Tables:** Containing descriptive attributes.
* **ERD:** Visual mapping of relationships and foreign keys.

### 3️⃣ Analytical Layer
* **SQL Insights:** Complex queries to extract business KPIs.
* **Python EDA:** Comprehensive statistical analysis and correlation studies.
* **Dashboarding:** Built an interactive dashboard to visualize trends and findings.
