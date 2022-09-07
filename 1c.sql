DELIMITER //

CREATE PROCEDURE PopulatePersonTransfer()
BEGIN
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
    DATEDIFF(
        CURDATE(),
        CONCAT(
            SUBSTRING_INDEX(DateOfJoining, '/', -1), "-",
            SUBSTRING_INDEX(DateOfJoining, '/', 1), "-",
            SUBSTRING(SUBSTRING_INDEX(DateOfJoining, '/', 2), LENGTH(SUBSTRING_INDEX(DateOfJoining, '/', 2))-1,2)
        )
    )/365.2425 > 10;

    SELECT * FROM PersonTransfer;
END //

DELIMITER ;