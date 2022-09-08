DELIMITER //

CREATE PROCEDURE PopulateNewHike2022()
BEGIN 
    -- DROP PROCEDURE IF EXISTS PopulateNewHike2022;

    DROP VIEW IF EXISTS requiredPersonHike;

    Create View requiredPersonHike AS
    Select EmpID, FirstName, LastName, Gender, WeightInKgs, Salary, CAST( SUBSTRING(LastHike,1,LENGTH(LastHike)-1) AS UNSIGNED ) As LastHike
    From person where WeightInKgs < 50;

    Select EmpID, FirstName, LastName, Gender, WeightInKgs, LastHike, Salary AS LastSalary, (LastHike+2) AS NewHike , (Salary*((LastHike+2)/100+1)) As NewSalary
    from requiredPersonHike;

    CREATE TABLE IF NOT EXISTS hike2022 (
        HikePK int AUTO_INCREMENT Primary key,
        EmpIDFK int,
        FirstName varchar(255),
        LastName varchar(255),
        Gender varchar(10),
        WeightInKg int,
        LastHike int ,  
        LastSalary int,
        NewHike int,
        NewSalary int,
        FOREIGN KEY (EmpIDFK) REFERENCES person(EmpID)
    );
    TRUNCATE TABLE hike2022;

    INSERT INTO hike2022 (EmpIDFK, FirstName, LastName, 
                            Gender, WeightInKg, LastHike, 
                            LastSalary, NewHike, NewSalary)
    Select 
        EmpID, FirstName, LastName, 
        Gender, WeightInKgs, LastHike, 
        Salary AS LastSalary, (LastHike+2) AS NewHike, 
        (Salary*(LastHike/100+1)) As NewSalary
    from requiredPersonHike;

    DROP VIEW IF EXISTS requiredPersonHike;
    Select * from hike2022;

END //

DELIMITER ;