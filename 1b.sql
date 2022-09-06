DELIMITER //

CREATE PROCEDURE PopulatePersonJoining()
BEGIN
    TRUNCATE Table PersonJoining;
    INSERT INTO PersonJoining(EmpIDFK, FirstName, LastName, DateofBirth, Age, DateOfJoining, DayofJoining, MonthofJoining, YearofJoining, WorkExpinDays)
    SELECT 
        EmpID, 
        FirstName, 
        LastName, 
        DOB as DateOfBirth,
        DATEDIFF(CURDATE(),
            CONCAT(
                SUBSTRING_INDEX(DOB, '/', -1), "-",
                SUBSTRING_INDEX(DOB, '/', 1), "-",
                SUBSTRING(SUBSTRING_INDEX(DOB, '/', 2), LENGTH(SUBSTRING_INDEX(DOB, '/', 2))-1,2)
            )
        )/365.2425 As Age,
        DateOfJoining,
        SUBSTRING(SUBSTRING_INDEX(DateOfJoining, '/', 2), LENGTH(SUBSTRING_INDEX(DateOfJoining, '/', 2))-1,2) As DayofJoining,
        CASE
            WHEN  CAST(SUBSTRING_INDEX(DateOfJoining, '/', 1) AS UNSIGNED) = 1
            THEN 'January'
            WHEN  CAST(SUBSTRING_INDEX(DateOfJoining, '/', 1) AS UNSIGNED) = 2
            THEN 'February'
            WHEN  CAST(SUBSTRING_INDEX(DateOfJoining, '/', 1) AS UNSIGNED) = 3
            THEN 'March'
            WHEN  CAST(SUBSTRING_INDEX(DateOfJoining, '/', 1) AS UNSIGNED) = 4
            THEN 'April'
            WHEN  CAST(SUBSTRING_INDEX(DateOfJoining, '/', 1) AS UNSIGNED) = 5
            THEN 'May'
            WHEN  CAST(SUBSTRING_INDEX(DateOfJoining, '/', 1) AS UNSIGNED) = 6
            THEN 'June'
            WHEN  CAST(SUBSTRING_INDEX(DateOfJoining, '/', 1) AS UNSIGNED) = 7
            THEN 'July'
            WHEN  CAST(SUBSTRING_INDEX(DateOfJoining, '/', 1) AS UNSIGNED) = 8
            THEN 'August'
            WHEN  CAST(SUBSTRING_INDEX(DateOfJoining, '/', 1) AS UNSIGNED) = 9
            THEN 'September'
            WHEN  CAST(SUBSTRING_INDEX(DateOfJoining, '/', 1) AS UNSIGNED) = 10
            THEN 'October'
            WHEN  CAST(SUBSTRING_INDEX(DateOfJoining, '/', 1) AS UNSIGNED) = 11
            THEN 'November'
            WHEN  CAST(SUBSTRING_INDEX(DateOfJoining, '/', 1) AS UNSIGNED) = 12
            THEN 'December'
            END AS MonthofJoining, 
        SUBSTRING_INDEX(DateOfJoining, '/', -1) As YearofJoining,
        DATEDIFF(CURDATE(),
            CONCAT(
                SUBSTRING_INDEX(DateOfJoining, '/', -1), "-",
                SUBSTRING_INDEX(DateOfJoining, '/', 1), "-",
                SUBSTRING(SUBSTRING_INDEX(DateOfJoining, '/', 2), LENGTH(SUBSTRING_INDEX(DateOfJoining, '/', 2))-1,2)
            )
        ) As WorkExpinDays 
    FROM person;
    SELECT * FROM PersonJoining;
END //

DELIMITER ;