DELIMITER //

CREATE PROCEDURE timezoneconvert(
	IN sourcedatetimestamp VARCHAR(255),
    IN sourcetimezonecode VARCHAR(5),
    IN targettimezone VARCHAR(5)
)
BEGIN
    DECLARE time_jump DEC(10,4); 

    SELECT gmtoffset/3600
    INTO time_jump
    FROM time_zone
    WHERE timestart = (
        SELECT unix_timestamp(
            CONCAT(
                SUBSTRING_INDEX(SUBSTRING_INDEX(sourcedatetimestamp, ' ', 1), '-', -1) ,
                '-' ,
                SUBSTRING_INDEX(SUBSTRING_INDEX(SUBSTRING_INDEX(sourcedatetimestamp, ' ', 1), '-', 2), '-', -1),
                '-',
                SUBSTRING_INDEX(SUBSTRING_INDEX(sourcedatetimestamp, ' ', 1), '-', 1), 
                ' ',
                SUBSTRING_INDEX(sourcedatetimestamp, ' ', -1) 
            )
        )
    ) and timezonecode=sourcetimezonecode
    limit 1;

    SELECT CONVERT_TZ(
        CONCAT(
                SUBSTRING_INDEX(SUBSTRING_INDEX(sourcedatetimestamp, ' ', 1), '-', -1) ,
                '-' ,
                SUBSTRING_INDEX(SUBSTRING_INDEX(SUBSTRING_INDEX(sourcedatetimestamp, ' ', 1), '-', 2), '-', -1),
                '-',
                SUBSTRING_INDEX(SUBSTRING_INDEX(sourcedatetimestamp, ' ', 1), '-', 1), 
                ' ',
                SUBSTRING_INDEX(sourcedatetimestamp, ' ', -1) 
        ),
        '+00:00',
        CONCAT(
            SUBSTRING_INDEX(CAST(time_jump AS CHAR), '.', 1), 
            ':',
            CONCAT( '0', CAST(CAST(ABS((MOD(time_jump, 1))*60)AS UNSIGNED)AS CHAR))
        )
    ) as converted_time;

	
END //

DELIMITER ;
    -- SELECT CONCAT(
    --             SUBSTRING_INDEX(SUBSTRING_INDEX(sourcedatetimestamp, ' ', 1), '-', -1) ,
    --             '-' ,
    --             SUBSTRING_INDEX(SUBSTRING_INDEX(SUBSTRING_INDEX(sourcedatetimestamp, ' ', 1), '-', 2), '-', -1),
    --             '-',
    --             SUBSTRING_INDEX(SUBSTRING_INDEX(sourcedatetimestamp, ' ', 1), '-', 1), 
    --             ' ',
    --             SUBSTRING_INDEX(sourcedatetimestamp, ' ', -1) 
    -- ) as true_date;

    -- select time_jump;

SELECT CONCAT(
    SUBSTRING_INDEX(CAST(-10.25 AS CHAR), '.', 1), 
    ':',
    CONCAT( '0', CAST(CAST(ABS((MOD(-10.25, 1))*60)AS UNSIGNED)AS CHAR)));

Select CONCAT( '0', CAST(CAST((MOD(0.1011, 1)*60)AS UNSIGNED)AS CHAR)); -- getting minutes

-- 23-01-1974 08:30:00 
-- 2010-09-26 16:30:00  |  26-09-2010 16:30:00  |  1285498800  |  WST 
-- SELECT from_unixtime(1285498800)
SELECT CONVERT_TZ('2022-07-29 02:53:00','+00:00','-4:00');



---------------testing
SELECT gmtoffset/3600
    FROM time_zone
    WHERE timestart = (
        SELECT unix_timestamp(
            CONCAT(
                SUBSTRING_INDEX(SUBSTRING_INDEX("23-01-1974 08:30:00", ' ', 1), '-', -1) ,
                '-' ,
                SUBSTRING_INDEX(SUBSTRING_INDEX(SUBSTRING_INDEX("23-01-1974 08:30:00", ' ', 1), '-', 2), '-', -1),
                '-',
                SUBSTRING_INDEX(SUBSTRING_INDEX("23-01-1974 08:30:00", ' ', 1), '-', 1), 
                ' ',
                SUBSTRING_INDEX("23-01-1974 08:30:00", ' ', -1) 
            )
        )
    ) and timezonecode='ARST'
    limit 1;
-------------------


----- SELECT CONVERT_TZ('2008-05-15 12:00:00','+00:00','+10:00');