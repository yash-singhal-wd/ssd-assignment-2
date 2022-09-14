DELIMITER //

CREATE PROCEDURE toShow()
BEGIN
    DROP VIEW IF EXISTS time_details;

    Create View time_details AS
    SELECT 
        Region,
        TimeOfBirth,
        CAST(SUBSTRING_INDEX(TimeOfBirth, ':', 1) AS UNSIGNED) As BirthHour,
        CAST(
            SUBSTRING(
                SUBSTRING_INDEX(TimeOfBirth, ':', 2), 
                LENGTH(SUBSTRING_INDEX(TimeOfBirth, ':', 2))-1,
            2) AS UNSIGNED
        ) as BirthMinute,
        SUBSTRING(SUBSTRING_INDEX(TimeOfBirth, ':', -1), 4,2) AS BirthTimeStatus
    from person;

    CREATE TABLE toShow1 (
        EmployeeRegion varchar(255),
        No_of_Employees_bw_0000_to_0800_hrs int
    );

    INSERT INTO toShow1(EmployeeRegion, No_of_Employees_bw_0000_to_0800_hrs)
    Select region,count(*) AS No_of_Employees_bw_0000_to_0800_hrs
    from time_details
    where ( 
        ( BirthTimeStatus='AM' and BirthHour=12 )
        or
        ( BirthTimeStatus='AM' and ( (BirthHour>=1 and BirthHour<=7) ) ) 
        or
        ( BirthTimeStatus='AM' and ( (BirthHour=8 and BirthMinute=0) ) )
    )
    group by region
    order by region;

    CREATE TABLE toShow2 (
        EmployeeRegion varchar(255),
        No_of_Employees_bw_0801_to_1500_hrs int
    );

    INSERT INTO toShow2(EmployeeRegion, No_of_Employees_bw_0801_to_1500_hrs)
    Select region,count(*) AS No_of_Employees_bw_0801_to_1500_hrs
    from time_details
    where (
        ( BirthTimeStatus='AM' and ( (BirthHour=8 and BirthMinute>=1) ) )
        or 
        ( BirthTimeStatus='AM' and ( (BirthHour>=9 and BirthHour<=11) ) )
        or
        ( BirthTimeStatus='PM' and ( (BirthHour=12) ) )
        or 
        ( BirthTimeStatus='PM' and ( (BirthHour>=1 and BirthHour<=2) ) )
        or
        ( BirthTimeStatus='PM' and ( (BirthHour=3 and BirthMinute=0) ) )
    ) 
    group by region
    order by region;

    CREATE TABLE toShow3 (
        EmployeeRegion varchar(255),
        No_of_Employees_bw_1501_to_2259_hrs int
    );

    INSERT INTO toShow3(EmployeeRegion,No_of_Employees_bw_1501_to_2259_hrs)
    Select region, count(*) AS No_of_Employees_bw_1501_to_2259_hrs
    from time_details
    where ( 
        ( BirthTimeStatus='PM' and ( (BirthHour=3 and BirthMinute>=1) ) )
        or
        ( BirthTimeStatus='PM' and ( (BirthHour>3 and BirthHour<10) ) )
        or 
        ( BirthTimeStatus='PM' and ( (BirthHour=10 and BirthMinute<=59) ) )
    ) 
    group by region
    order by region;

    Select toShow1.EmployeeRegion,
        No_of_Employees_bw_0000_to_0800_hrs,
        No_of_Employees_bw_0801_to_1500_hrs,
        No_of_Employees_bw_1501_to_2259_hrs
        from toShow1, toShow2, toShow3
        where toShow1.EmployeeRegion = toShow2.EmployeeRegion 
            and toShow2.EmployeeRegion=toShow3.EmployeeRegion
            and toShow3.EmployeeRegion=toShow1.EmployeeRegion;

    DROP TABLE IF EXISTS toShow1;
    DROP TABLE IF EXISTS toShow2;
    DROP TABLE IF EXISTS toShow3;

    DROP VIEW IF EXISTS time_details;
END // 

DELIMITER ;

-- DROP PROCEDURE toShow;
-- CALL toShow();