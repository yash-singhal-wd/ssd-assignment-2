# Question 1
## Overview
- Creates a new table 'hike2022' and populates it with 2% hike and recalculates NewSalary using LastSalary.

## Assumption
- The user is in a database that contains 'person' table, which is already populated. 
- The dates in this database are NOT pre-processed, and are stored in varchar format.
  - The dates and other data is directly inserted into the database exactly as it is in csv file.  

## Execution
- First go to the database that contains person table. 
- Then copy and paste the code in q1a.sql, or, run the file using source command.
- This creates a procedure named 'PopulateNewHike2022'. 
- Running the procedure shows the newly populated 'hike2022' table.

```
USE DATABASE ASSIGNMENT2;
DROP PROCEDURE PopulateNewHike2022;
source q1a.sql;
CALL PopulateNewHike2022();
```

***

# Question 1b
## Overview
- Creates a new table 'PersonJoining' and populates it with the required data as mentioned.

## Assumption
- The user is in a database that contains 'person' table, which is already populated. 
- The dates in this database are NOT pre-processed, and are stored in varchar format.
  - The dates and other data is directly inserted into the database exactly as it is in csv file.  

## Execution
- First go to the database that contains person table. 
- Then copy and paste the code in q1b.sql, or, run the file using source command.
- This creates a procedure named 'PopulateNewHike2022'. 
- Running the procedure shows the newly populated 'PersonJoining' table.

```
USE DATABASE ASSIGNMENT2;
DROP PROCEDURE PopulatePersonJoining;
source q1b.sql;
CALL PopulatePersonJoining();
```

***

# Question 1c
## Overview
- Creates a new table 'PersonTransfer' and populates it with NewRegion for males and females based on work experience.

## Assumption
- The user is in a database that contains 'person' table, which is already populated. 
- The dates in this database are NOT pre-processed, and are stored in varchar format.
  - The dates and other data is directly inserted into the database exactly as it is in csv file.  

## Execution
- First go to the database that contains person table. 
- Then copy and paste the code in q1c.sql, or, run the file using source command.
- This creates a procedure named 'PopulatePersonTransfer'. 
- Running the procedure shows the newly populated 'PersonTransfer' table.

```
USE DATABASE ASSIGNMENT2;
DROP PROCEDURE PopulatePersonTransfer;
source q1a.sql;
CALL PopulatePersonTransfer();
```

***

# Question 2
## Overview
- Converts a given timestamp to a new timestamp from a source timezone to a target timezone.

## Assumption
- The nearest epoch to the given timestamp is always the one the one that preceeds it.
    - For ex: If timestamp is '29-08-1998 6:30:00' and we have 2 epochs that corresponds to '29-02-1998 6:30:00' and '12-09-1998 6:45:00' in our database. Then according to my implementation, '29-02-1998 6:30:00' is the 'nearest' one. 
- The dates are given in Indian format that is: 'dd-mm-yyyy'.
- The time can be in 'hh:mm:ss' or 'h:mm:ss'. 
- the timestamp format is date and time seperated by a single space. 
- There is a table named time_zone that is already populated from the given csv file.
- The Create table command is given as follows:
```
CREATE TABLE time_zone(
    zonename varchar(255),
    countrycode varchar(10), 
    timezonecode varchar(10), 
    timestart BIGINT, 
    gmtoffset int, 
    dst int
);
```
- This table is populated with the data in the given csv file.
- The dates in this database are NOT pre-processed, and are stored in varchar format.
    - The dates and other data is directly inserted into the database exactly as it is in csv file. 
- No preprocessing is done whatsoever while populating the database. 

## Execution
- First go to the database that contains time_zone table. 
- Then copy and paste the code in q2.sql, or, run the file using source command.
- This creates a procedure named 'timezoneconvert'. 
- Running the procedure shows the converted time from source timezone to target timezone.
- The timestamp is the first argument, sourcetimezone is the second argument and targettimezone is the third argument.

```
USE DATABASE ASSIGNMENT2;
DROP PROCEDURE timezoneconvert;
source q2.sql;
CALL timezoneconvert('29-07-2022 02:53:00', 'EST', 'IST');

OUTPUT:
+---------------------+
| converted_time      |
+---------------------+
| 2022-07-29 08:53:00 |
+---------------------+
```

***

# Question 3
## Overview
- Shows the data of employees born from 00:00-08:00, 08:01-15:00 and 15:01-22:59 hours.

## Assumption
- The user is in a database that contains 'person' table, which is already populated. 
- The dates in this database are NOT pre-processed, and are stored in varchar format.
  - The dates and other data is directly inserted into the database exactly as it is in csv file.  

## Execution
- First go to the database that contains person table. 
- Then copy and paste the code in q3.sql, or, run the file using source command.
- This creates a procedure named 'toShow'. 
- Running the procedure shows the required data.

```
USE DATABASE ASSIGNMENT2;
DROP PROCEDURE toShow;
source q3.sql;
CALL toShow();
```

***

## Additional:

### Person table definition:

```
 CREATE TABLE person (
     EmpID int NOT NULL PRIMARY KEY,
     NamePrefix varchar(10),
     FirstName varchar(255),
     MiddleInitial varchar(10),
     LastName varchar(255),
     Gender varchar(10),
     Email varchar(255),
     FatherName varchar(255),
     MotherName varchar(255),
     MotherMaidenName varchar(255),
     DOB varchar(12),
     TimeOfBirth varchar(12),
     WeightInKgs int,
     DateOfJoining varchar(12),
     Salary int,
     LastHike varchar(10),  
     PlaceName varchar(255),
     Country varchar(255),
     City varchar(255),
     State varchar(255),
     Region varchar(255)
 );
```