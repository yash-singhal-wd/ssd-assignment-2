DELIMITER //

CREATE PROCEDURE timezoneconvert(
	IN sourcedatetimestamp VARCHAR(255),
    IN sourcetimezonecode VARCHAR(5),
    IN targettimezone VARCHAR(5)
)
BEGIN
    DECLARE signed_hour varchar(50);
    DECLARE real_date varchar(50);
    DECLARE time_jump1 DEC(10,4); 
    DECLARE time_jump2 DEC(10,4); 

    DECLARE the_jump DEC(10.4);

    SELECT CONCAT(
                SUBSTRING_INDEX(SUBSTRING_INDEX(sourcedatetimestamp, ' ', 1), '-', -1) ,
                '-' ,
                SUBSTRING_INDEX(SUBSTRING_INDEX(SUBSTRING_INDEX(sourcedatetimestamp, ' ', 1), '-', 2), '-', -1),
                '-',
                SUBSTRING_INDEX(SUBSTRING_INDEX(sourcedatetimestamp, ' ', 1), '-', 1), 
                ' ',
                SUBSTRING_INDEX(sourcedatetimestamp, ' ', -1) 
    ) INTO real_date;

    SELECT gmtoffset/3600
    INTO time_jump1
    FROM time_zone
    WHERE timestart < (
        select TIMESTAMPDIFF(second,FROM_UNIXTIME(0),real_date)
    ) and timezonecode=sourcetimezonecode
    order by timestart desc
    limit 1;

    SELECT gmtoffset/3600
    INTO time_jump2
    FROM time_zone
    WHERE timestart < (
         select TIMESTAMPDIFF(second,FROM_UNIXTIME(0),real_date)
    ) and timezonecode=targettimezone
    order by timestart desc
    limit 1;

    SELECT time_jump2-time_jump1 INTO the_jump;

    SELECT IF(the_jump<0, '-', '+') INTO signed_hour;
    SELECT CONCAT(signed_hour, CAST(the_jump AS CHAR)) INTO signed_hour;

    SELECT SUBSTRING_INDEX(
        CONVERT_TZ( real_date, '+00:00',
        CONCAT(
            SUBSTRING_INDEX(CAST(signed_hour AS CHAR), '.', 1), 
            ':',
            CONCAT( '0', CAST(CAST(ABS((MOD(signed_hour, 1))*60)AS UNSIGNED)AS CHAR))
        )
    ), '.', 1 ) as converted_time;
	
END //

DELIMITER ;

-- DROP PROCEDURE timezoneconvert;
-- CALL timezoneconvert('29-07-2022 02:53:00', 'EST', 'IST');