DELIMITER //

CREATE PROCEDURE PopulatePersonTransfer()
BEGIN
    CREATE TABLE IF NOT EXISTS PersonTransfer (
        PTPK int AUTO_INCREMENT Primary key,
        EmpIDFK int,
        FirstName varchar(255),
        LastName varchar(255),
        Gender varchar(10),
        DateOfJoining varchar(12),
        CurrentRegion varchar(255),
        NewRegion varchar(255),
        FOREIGN KEY (EmpIDFK) REFERENCES person(EmpID)
    );

    TRUNCATE TABLE PersonTransfer;
    INSERT INTO PersonTransfer(EmpIDFK, FirstName, LastName, Gender, DateofJoining, CurrentRegion, NewRegion)
    SELECT
    EmpID, FirstName, LastName, Gender, DateofJoining, Region AS CurrentRegion,
    CASE
        WHEN Gender = 'F'
        THEN 'DC'
        WHEN Gender = 'M'
        THEN 'Capitol'
        END AS NewRegion
    FROM person
    WHERE
    (
        DATE_FORMAT(FROM_DAYS(DATEDIFF(now(),
            CONCAT(
            SUBSTRING_INDEX(DateOfJoining, '/', -1), "-",
            SUBSTRING_INDEX(DateOfJoining, '/', 1), "-",
            SUBSTRING(SUBSTRING_INDEX(DateOfJoining, '/', 2), LENGTH(SUBSTRING_INDEX(DateOfJoining, '/', 2))-1,2)
        ))
            ), '%Y')+0 > 10 AND Gender='F')
    OR 
    (DATE_FORMAT(FROM_DAYS(DATEDIFF(now(),
            CONCAT(
            SUBSTRING_INDEX(DateOfJoining, '/', -1), "-",
            SUBSTRING_INDEX(DateOfJoining, '/', 1), "-",
            SUBSTRING(SUBSTRING_INDEX(DateOfJoining, '/', 2), LENGTH(SUBSTRING_INDEX(DateOfJoining, '/', 2))-1,2)
        ))
            ), '%Y')+0 > 20 AND Gender='M');

    SELECT * FROM PersonTransfer;
END //

DELIMITER ;

--CALL PopulatePersonTransfer();
--DROP Procedure PopulatePersonTransfer;