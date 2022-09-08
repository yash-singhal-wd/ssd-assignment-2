DELIMITER //

CREATE PROCEDURE GetOfficeByCountry(
	IN sourcedatetimestamp VARCHAR(255),
    IN sourcetimezonecode VARCHAR(5),
    IN targettimezone VARCHAR(5)
)
BEGIN
	-- SELECT * 
 	-- FROM offices
	-- WHERE country = countryName;
END //

DELIMITER ;

----------v imp
SELECT gmtoffset/3600 as required_time_jump
FROM time_zone
WHERE timestart = (
    SELECT unix_timestamp(
        CONCAT(
            SUBSTRING_INDEX(SUBSTRING_INDEX("27-03-1988 6:30:00", ' ', 1), '-', -1) ,
            '-' ,
            SUBSTRING_INDEX(SUBSTRING_INDEX(SUBSTRING_INDEX("27-03-1988 6:30:00", ' ', 1), '-', 2), '-', -1),
            '-',
            SUBSTRING_INDEX(SUBSTRING_INDEX("27-03-1988 6:30:00", ' ', 1), '-', 1), 
            ' ',
            SUBSTRING_INDEX("27-03-1988 6:30:00", ' ', -1) 
        )
    )
) and timezonecode='CEST'
limit 1;
----------v imp
