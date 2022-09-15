DELIMITER //

CREATE PROCEDURE PopulateNewHike2022()
BEGIN 
    DROP VIEW IF EXISTS requiredPersonHike;

    Create View requiredPersonHike AS
    Select EmpID, FirstName, LastName, Gender, WeightInKgs, Salary, CAST( SUBSTRING(LastHike,1,LENGTH(LastHike)-1) AS UNSIGNED ) As LastHike
    From person where WeightInKgs < 50;

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

--drop procedure PopulateNewHike2022;
-- CALL PopulateNewHike2022();


------ PERSON DEFININTION --------

-- CREATE TABLE person (
--     EmpID int NOT NULL PRIMARY KEY,
--     NamePrefix varchar(10),
--     FirstName varchar(255),
--     MiddleInitial varchar(10),
--     LastName varchar(255),
--     Gender varchar(10),
--     Email varchar(255),
--     FatherName varchar(255),
--     MotherName varchar(255),
--     MotherMaidenName varchar(255),
--     DOB varchar(12),
--     TimeOfBirth varchar(12),
--     WeightInKgs int,
--     DateOfJoining varchar(12),
--     Salary int,
--     LastHike varchar(10),  
--     PlaceName varchar(255),
--     Country varchar(255),
--     City varchar(255),
--     State varchar(255),
--     Region varchar(255)
-- );