# Data Analytic Portfolio 

## Table of Contents
- [Porject 1 - HR Data Analytics and Visualisation](#HR-Data-Analytics-and-Visualisation)  

## HR Data Analytics and Visualisation

### Project Overview

This data analysis project aims to provide insights into the current HR data of a company. By creating a data visualisation dashboard that contains various aspects of the HR data, we seek to identify trends and gain a deeper understanding of the company's employees in one easily accessible dashboard. 

[HR Analytics Dashboard](https://public.tableau.com/app/profile/pradip.pun/viz/HRAnalyticsDashboard_16986995899550/HRANALYTICSDASHBOARD) 
![Screenshot 2023-10-30 at 21 00 30](https://github.com/pradippun/portfolio/assets/149323535/11d29033-1623-4aaf-89f9-a9b51a9d6acc)


### Data Sources

HR Data: The primary dataset used for this analysis is the [HR Data.xlsx](https://github.com/pradippun/portfolio/blob/main/HR%20Data.xlsx) file, containing detailed information about each employee who has worked for the company.  

### Tools
- **Excel** - Data Cleaning/ Preparing CSV file for SQL table [hrdata.csv](https://github.com/pradippun/portfolio/blob/main/hrdata.csv). Running test with Pivot Table
- **Tableau** - Data Visualisation - [HR Analytics Dashboard](https://public.tableau.com/app/profile/pradip.pun/viz/HRAnalyticsDashboard_16986995899550/HRANALYTICSDASHBOARD) 
- **PostgreSQL** - Running test for the Tableau report using [SQL Queries](https://github.com/pradippun/portfolio/blob/main/HR_Data_Test_SQL.sql)

### Data Cleaning/ Preparation
In the initial data preparation phase, I performed the following tasks:
1. Data loading and inspection.
2. Handling missing values.
3. Data cleaning and formatting.

### Data Visualisation
For the data visualisation, I have used Tableau to create an interactive dashboard that contains information such as KPIs, department attrition share, and job satisfaction ratings by job roles.
Following are some of the Tableau features I have used to create the [HR Analytics Dashboard](https://public.tableau.com/app/profile/pradip.pun/viz/HRAnalyticsDashboard_16986995899550/HRANALYTICSDASHBOARD): 
1. Calculated Fields to calculate the attrition count and attrition rate %.
2. Heat Map Chart to show the job satisfaction rating.
3. Bin Size in bar chart to group the age.
4. Pie Chart and Dual Axis to create a Donut Chart.

### Testing the Tableau report using **SQL**
Quality assurance tests have been run using PostgreSQL queries to check the accuracy and quality of the data presented in the 'HR Analytics Dashboard'. 
This step of the project also allowed me to test each feature and filter on the report worked as per the requirement. 
Following are some examples of the [SQL Queries](https://github.com/pradippun/portfolio/blob/main/HR_Data_Test_SQL.sql):
1. Creating a table in DB
```sql
CREATE TABLE hrdata
(	
	emp_no int8 PRIMARY KEY,
	gender varchar(50) NOT NULL,
	age_band varchar(50),
	age int8,
	department varchar(50),
	education varchar(50),
	education_field varchar(50),
	job_role varchar(50),
	employee_count int8,
	attrition varchar(50),
	attrition_label varchar(50),
	job_satisfaction int8,
	active_employee int8
);
```
2. Count of attrition for employees with 'High School' education and in 'Sales' department
```sql
SELECT count(attrition) as attrition_hs_sales
	FROM hrdata
	WHERE attrition = 'Yes' and education = 'High School' and department = 'Sales'
```
3. Calculate attrition rate % for the 'Sales' department
```sql
 SELECT ROUND(((SELECT count(attrition) from hrdata where attrition = 'Yes'and department = 'Sales')/
 sum(employee_count)) * 100, 2) AS attrition_rate
 	FROM hrdata
	WHERE department = 'Sales'
```
4. Job Satisfaction Rating table by Job Role
```sql
SELECT *
FROM crosstab(
	'SELECT job_role, job_satisfaction, sum(employee_count)
	FROM hrdata
	GROUP BY job_role, job_satisfaction
	ORDER BY job_role, job_satisfaction'
	) AS ct(job_role varchar(50), one numeric, two numeric, three numeric, four numeric)
ORDER BY job_role;
```

### Testing the Tableau report using **Excel**
Quality assurance tests have been run again but this time using Excel Pivot Tables. 
Following are some pivot tables and graphs created to test the results. 

<img width="839" alt="Screenshot 2023-11-16 at 15 28 33" src="https://github.com/pradippun/portfolio/assets/149323535/a037e88b-2a62-438b-96c5-9ee93d5153b0">

### Results/ Findings
The result of this project is an interactive HR dashboard that allows the HR team and other stakeholders to easily access some crucial information focused on employee attrition in the company. 
Here are some examples of findings: 
1. There have been a total of **1,470** staff employed by the company, of which **237** have left the company (**16.12%** attrition rate).
2. Employees with a high school education have the highest attrition rate of 18.24%. 
3. The R&D department has the highest share (56.12%) of attrition rate. This may be due to the high number of low job satisfaction ratings in Laboratory Technician and Research Scientist roles.
4. The highest attrition rate is in the age group 25-34. 

### Recommendations
Based on the analysis, I recommend the company do further thorough research on why the identified employee segments have the highest attrition rate. Some reasons to research could be a lack of career progression, more flexible work-life balance, salary and work culture. This will help the company retain it's employees and save effort and expenses on highring/ training new employees.  
