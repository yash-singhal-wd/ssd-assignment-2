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
------------  ye sahi hai -------------
Select TimeOfBirth, region, count(*)
from time_details
where ( 
    ( BirthTimeStatus='AM' and BirthHour=12 )
    or
    ( BirthTimeStatus='AM' and ( (BirthHour>=1 and BirthHour<=7) ) ) 
    or
    ( BirthTimeStatus='AM' and ( (BirthHour=8 and BirthMinute=0) ) )
)
group by region;
------------  ye sahi hai -------------

------------ ye bhi sahi hai ----------
Select TimeOfBirth, region, count(*)
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
group by region;
------------ ye bhi sahi hai ----------

------------ ye bhi sahi hai ----------

Select TimeOfBirth, region, count(*)
from time_details
where ( 
    ( BirthTimeStatus='PM' and ( (BirthHour=3 and BirthMinute>=1) ) )
    or
    ( BirthTimeStatus='PM' and ( (BirthHour>3 and BirthHour<10) ) )
    or 
    ( BirthTimeStatus='PM' and ( (BirthHour=10 and BirthMinute<=59) ) )
) 
group by region;
------------ ye bhi sahi hai ----------

Select TimeOfBirth, BirthHour, count(*)
from time_details
where (
     ( BirthTimeStatus='PM' and ( (BirthHour=3 and BirthMinute>=1) ) ) );