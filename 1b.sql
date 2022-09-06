-- DROP VIEW IF EXISTS requiredPersonJoining;
-- TRUNCATE TABLE PersonJoining;

Create View requiredPersonJoining AS
Select EmpID, FirstName, LastName, DOB AS DateOfBirth, WeightInKgs, Salary, CAST( SUBSTRING(LastHike,1,LENGTH(LastHike)-1) AS UNSIGNED ) As LastHike
From person where WeightInKgs < 50;

select DOB, SUBSTRING_INDEX(DOB, '/', 1) As MONTH_, SUBSTRING(SUBSTRING_INDEX(DOB, '/', 2), LENGTH(SUBSTRING_INDEX(DOB, '/', 2))-1,2) As DAY_, SUBSTRING_INDEX(DOB, '/', -1) As YEAR_  from person;

SELECT
  SUBSTRING_INDEX(name,' ', 1) AS first_name, 
  SUBSTRING_INDEX(name,' ', -1) AS last_name 
  FROM students;