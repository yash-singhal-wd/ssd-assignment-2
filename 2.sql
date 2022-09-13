--testing
-- epoch: 481078800 & timestamp(for me): 31-03-1985 06:30:00 & timestamp(real): 1985-03-31 06:30:00 & zone=CEST

--DATE_FORMAT(DATE_ADD(FROM_UNIXTIME(0), interval epoch second),'%Y-%m-%d %H:%i:%s');
--SELECT TIMESTAMPDIFF(second,FROM_UNIXTIME(0),'1901-01-01 05:23:55');
--CALL timezoneconvert('29-07-2022 02:53:00', 'EST', 'IST')

SELECT unix_timestamp(
            CONCAT(
                SUBSTRING_INDEX(SUBSTRING_INDEX('29-07-2022 02:53:00', ' ', 1), '-', -1) ,
                '-' ,
                SUBSTRING_INDEX(SUBSTRING_INDEX(SUBSTRING_INDEX('29-07-2022 02:53:00', ' ', 1), '-', 2), '-', -1),
                '-',
                SUBSTRING_INDEX(SUBSTRING_INDEX('29-07-2022 02:53:00', ' ', 1), '-', 1), 
                ' ',
                SUBSTRING_INDEX('29-07-2022 02:53:00', ' ', -1) 
            )
        ) as timestamp_;

SELECT gmtoffset/3600
    FROM time_zone
    WHERE timestart < (
        SELECT unix_timestamp(
            CONCAT(
                SUBSTRING_INDEX(SUBSTRING_INDEX('29-07-2022 02:53:00', ' ', 1), '-', -1) ,
                '-' ,
                SUBSTRING_INDEX(SUBSTRING_INDEX(SUBSTRING_INDEX('29-07-2022 02:53:00', ' ', 1), '-', 2), '-', -1),
                '-',
                SUBSTRING_INDEX(SUBSTRING_INDEX('29-07-2022 02:53:00', ' ', 1), '-', 1), 
                ' ',
                SUBSTRING_INDEX('29-07-2022 02:53:00', ' ', -1) 
            )
        )
    ) and timezonecode='CEST'
    order by timestart desc
    limit 1;

-----------------------------------------------------


DELIMITER //

CREATE PROCEDURE timezoneconvert(
	IN sourcedatetimestamp VARCHAR(255),
    IN sourcetimezonecode VARCHAR(5),
    IN targettimezone VARCHAR(5)
)
BEGIN
    DECLARE signed_hour varchar(50);
    DECLARE time_jump1 DEC(10,4); 
    DECLARE time_jump2 DEC(10,4); 
    DECLARE time_jump3 DEC(10,4);

    DECLARE the_jump DEC(10.4);

    SELECT gmtoffset/3600
    INTO time_jump1
    FROM time_zone
    WHERE timestart < (
        select TIMESTAMPDIFF(second,FROM_UNIXTIME(0),
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
    order by timestart desc
    limit 1;

    select time_jump1;

    SELECT gmtoffset/3600
    INTO time_jump2
    FROM time_zone
    WHERE timestart < (
         select TIMESTAMPDIFF(second,FROM_UNIXTIME(0),
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
    ) and timezonecode=targettimezone
    order by timestart desc
    limit 1;

    select time_jump2;

    SELECT time_jump2-time_jump1 INTO the_jump;

    SELECT IF(the_jump<0, '-', '+') INTO signed_hour;
    SELECT CONCAT(signed_hour, CAST(the_jump AS CHAR)) INTO signed_hour;

    SELECT SUBSTRING_INDEX(
        CONVERT_TZ(
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
            SUBSTRING_INDEX(CAST(signed_hour AS CHAR), '.', 1), 
            ':',
            CONCAT( '0', CAST(CAST(ABS((MOD(signed_hour, 1))*60)AS UNSIGNED)AS CHAR))
        )
    ), '.', 1 ) as converted_time;
	
END //

DELIMITER ;

-----------------------------------------------------
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
            SUBSTRING_INDEX(CAST(6 AS CHAR), '.', 1), 
            ':',
            CONCAT( '0', CAST(CAST(ABS((MOD(6, 1))*60)AS UNSIGNED)AS CHAR))
        )
    ) as converted_time;
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
SELECT CONVERT_TZ('2022-07-29 02:53:00','+00:00','+4:00');



---------------testing
SELECT gmtoffset/3600
    FROM time_zone
    WHERE timestart = (
        SELECT unix_timestamp(
            CONCAT(
                SUBSTRING_INDEX(SUBSTRING_INDEX("31-03-1974 08:30:00", ' ', 1), '-', -1) ,
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