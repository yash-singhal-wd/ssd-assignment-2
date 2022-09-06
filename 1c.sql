SELECT
EmpID, FirstName, LastName, Gender, DateofJoining, Region AS CurrentRegion 
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