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

-- Q1a --

CREATE TABLE hike2022 (
    HikePK int AUTO_INCREMENT Primary key,
    EmpIDFK int,
    FirstName varchar(255),
    LastName varchar(255),
    Gender varchar(10),
    WeightInKg int,
    LastHike int ,  
    LastSalary int,
    NewHike int,
    NewSalary int,
    FOREIGN KEY (EmpIDFK) REFERENCES person(EmpID)
);

-- Q1b --

CREATE TABLE PersonJoining (
    PJoinPK int,
    EmpIDFK int,
    FirstName varchar(255),
    LastName varchar(255),
    DateOfBirth varchar(12),
    Age int,
    DateOfJoining varchar(12),
    DayofJoining varchar(5),
    MonthofJoining varchar(50),
    YearofJoining varchar(5),
    WorkExpinDays int,
    PRIMARY KEY (PJoinPK),
    FOREIGN KEY (EmpIDFK) REFERENCES person(EmpID)
);
