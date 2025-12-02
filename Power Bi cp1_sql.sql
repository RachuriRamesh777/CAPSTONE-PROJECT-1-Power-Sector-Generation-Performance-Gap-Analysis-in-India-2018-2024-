			create database capstone1;
	
--Now that Our cleaned dataset is in SQL Server, the next step is to run queries to prepare the data for Power BI visualizations.

/*1. Explore the table
Check the first few rows to ensure the data is correct:*/
		USE capstone1;
SELECT TOP 100 * FROM power_data;

--Check the number of rows:
SELECT COUNT(*) AS Total_Rows FROM power_data;	 /*1048575 Rows there*/

SELECT [Monitored CAP in MW]
FROM power_data
WHERE [Generation / Today's Program] = 50.84;

/*2. Run aggregation queries
To get key insights:
 */
--1. Total generation by Region:
SELECT Region, SUM([Generation / Today's Actual]) AS Total_Generation
FROM power_data
GROUP BY Region;
  /* We have 5 regions of power generation order by:
1. EASTERN-      1227147.77649998
2. NORTH EASTERN-122192.770700005
3. NORTHERN	-    1775557.49940003
4. SOUTHERN	-    1388721.3421
5. WESTERN	-    2662895.27879997  */

--2. Average CAP under outage by Station Type

SELECT [Station Type], AVG([CAP under outage]) AS Avg_CAP_Outage
FROM power_data
GROUP BY [Station Type];

/* Just like 5 regions, 5 Types of Power generation stations are there,
Having different Avarage CAP_Outage.
As mentioned below:
1. HYDRO    35.6544283852306
2. NUCLEAR	119.551576088951
3. THER (DG) 0.0823410696266398
4. THER (GT) 218.395427264494
5. THERMAL   267.216843774395
*/

--3.Coal stock statistics by Sector
SELECT Sector, AVG([Coal Stock in Days]) AS Avg_Coal_Stock, MAX([Coal Stock in Days]) AS Max_Coal_Stock
FROM power_data
GROUP BY Sector;
/*Here Sectors are 3 with Avarage coal stock in normal days to max stock at peak days in Tonns.
1. CENTRAL SECTOR 11.8345666235446	  156
2. PVT SECTOR	  10.8592677999375	  128
3. STATE SECTOR	  12.376353170821	  764860
*/


/*The cleaned dataset from Python was saved to SQL Server (capstone1, table power_data) using Windows Authentication.
Aggregations on coal stock were performed, and the data is now ready for creating Power BI dashboards to analyze generation, 
outages, and trends.*/

--Note: Connect SQL Server in Power BI for Dash Boards and visualization.
/*1. Connect Power_BI to SQL Server:
     Use “Get Data -SQL Server”.
     Select  database (capstone1) and table (power_data) or write custom queries.
	 
  2. Create dashboards and visuals:
	 Use Region, State, Sector, Station Type as filters or axes.
     Use numeric columns (Generation, CAP under outage, Coal Stock) as values.
     Show trends, comparisons, and highlight extreme values.
     Optional enhancements:
     Time-based charts for generation trends.
	 Conditional formatting for high/low outages or coal stock.
	 KPI visuals for quick insights.
*/