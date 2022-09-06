DELIMITER //

CREATE PROCEDURE PopulateNewHike2022()
BEGIN 
    -- DROP PROCEDURE IF EXISTS PopulateNewHike2022;
    DROP VIEW IF EXISTS requiredPersonHike;
    TRUNCATE TABLE hike2022;

    Create View requiredPersonHike AS
    Select EmpID, FirstName, LastName, Gender, WeightInKgs, Salary, CAST( SUBSTRING(LastHike,1,LENGTH(LastHike)-1) AS UNSIGNED ) As LastHike
    From person where WeightInKgs < 50;

    Select EmpID, FirstName, LastName, Gender, WeightInKgs, LastHike, Salary AS LastSalary, (LastHike+2) AS NewHike , (Salary*(LastHike/100+1)) As NewSalary
    from requiredPersonHike;

    INSERT INTO hike2022 (EmpIDFK, FirstName, LastName, Gender, WeightInKg, LastHike, LastSalary, NewHike, NewSalary)
    Select EmpID, FirstName, LastName, Gender, WeightInKgs, LastHike, Salary AS LastSalary, (LastHike+2) AS NewHike, (Salary*(LastHike/100+1)) As NewSalary
    from requiredPersonHike;

    Select * from hike2022;

END //

DELIMITER ;