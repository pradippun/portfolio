--create table 'hrdata'--


CREATE TABLE hrdata
(	
	emp_no int8 PRIMARY KEY,
	gender varchar(50) NOT NULL,
	marital_status varchar(50),
	age_band varchar(50),
	age int8,
	department varchar(50),
	education varchar(50),
	education_field varchar(50),
	job_role varchar(50),
	business_travel varchar(50),
	employee_count int8,
	attrition varchar(50),
	attrition_label varchar(50),
	job_satisfaction int8,
	active_employee int8
);

--Copy HR Data to the hrdata table

COPY hrdata FROM '/Users/pradippun/Desktop/HR Data Analysis/hrdata.csv' DELIMITER ',' CSV HEADER;


SELECT *
	FROM hrdata;
	
--sum of employee count

SELECT sum(employee_count)
	FROM hrdata
	

--sum of employee count with 'high school' education

SELECT sum(employee_count) as highschool_emp_count
	FROM hrdata
	WHERE education = 'High School'

--sum of employee count in 'Sales' department
SELECT sum(employee_count) as sales_emp_count
	FROM hrdata
	WHERE department = 'Sales'

--count of attrition for employees with 'high school' education
SELECT count(attrition) as attrition_hs
	FROM hrdata
	WHERE attrition = 'Yes' and education = 'High School'
	
--count of attrition for employees with 'High School' education and in 'Sales' department
SELECT count(attrition) as attrition_hs_sales
	FROM hrdata
	WHERE attrition = 'Yes' and education = 'High School' and department = 'Sales'

--calculate attrition rate %
 SELECT ROUND(((SELECT count(attrition) from hrdata where attrition = 'Yes')/
 sum(employee_count)) * 100, 2) AS attrition_rate
 	FROM hrdata

--calculate attrition rate % for 'Sales' department
 SELECT ROUND(((SELECT count(attrition) from hrdata where attrition = 'Yes'and department = 'Sales')/
 sum(employee_count)) * 100, 2) AS attrition_rate
 	FROM hrdata
	WHERE department = 'Sales'


--calculate active employee
SELECT sum(employee_count) - (SELECT count(attrition) from hrdata where attrition = 'Yes') AS active_emp
	FROM hrdata
	
	
--calculate active 'Male' employee
SELECT sum(employee_count) - (SELECT count(attrition) from hrdata where attrition = 'Yes' 
							  and gender = 'Male') AS active_male_emp
	FROM hrdata	
	WHERE gender = 'Male'

--Calculate an average age
SELECT ROUND(avg(age),0) AS avg_age
	FROM hrdata

--Atriation by Gender
SELECT gender, count(attrition) AS attrition
	FROM hrdata
	WHERE attrition = 'Yes'
	GROUP BY gender
	
--Department attrition %
SELECT department, count(attrition) AS atrition, 
			 round((cast (count(attrition) as numeric)/
					(SELECT count(attrition) FROM hrdata WHERE attrition ='Yes')) *100,2) AS attrition_percentage
	FROM hrdata
	WHERE attrition = 'Yes'
	GROUP BY department
	ORDER BY count(attrition) desc


--Job Satisfaction Rating table by Job Role

CREATE EXTENSION IF NOT EXISTS tablefunc;

SELECT *
FROM crosstab(
	'SELECT job_role, job_satisfaction, sum(employee_count)
	FROM hrdata
	GROUP BY job_role, job_satisfaction
	ORDER BY job_role, job_satisfaction'
	) AS ct(job_role varchar(50), one numeric, two numeric, three numeric, four numeric)
ORDER BY job_role;
