-- Design Specification
-- My design for project includes too many lookup tables 
-- like for Job Description, Didnot handle time and year Information properly, 
-- creation of unnecessary tables , Didnot handle Semester Lookup,
-- the student employee relations properly.After all these modifications, the design
-- changes align with the instructor solution. Hence went ahead with that implementation

CREATE TABLE AddressInfo (
       AddressId      INT             PRIMARY KEY          IDENTITY(1,1),
	   Street1        VARCHAR(100)    NOT NULL,
	   Street2        VARCHAR(100)            ,
	   City           VARCHAR(50)     NOT NULL,
	   State          VARCHAR(50)     NOT NULL,
	   -- zip codes could start with 0 , not advisable to store as integer
	   -- Assuming no extensions for zip code and is only 5 bytes
	   ZIP            CHAR(5)         NOT NULL
);

CREATE TABLE People (
       PersonId       INT             PRIMARY Key         IDENTITY(1,1),
       NTID           VARCHAR(20)     NOT NULL,
       FirstName      VARCHAR(20)     NOT NULL,
       LastName       VARCHAR(20)     NOT NULL,
       Password       VARCHAR(50)             ,
	   -- we just need information about date so chose it instead of datetime
       DOB            DATE            NOT NULL,
       SSN			  VARCHAR(12)                         CHECK(SSN LIKE '%-%-%'),
       HomeAddress    INT             NOT NULL            REFERENCES AddressInfo(AddressId),
       LocalAddress   INT                                 REFERENCES AddressInfo(AddressId),
       IsActive       BIT             NOT NULL            DEFAULT 'Y'
);

CREATE TABLE BenefitSelection (
       BenefitSelectionID     INT              PRIMARY KEY    IDENTITY(1,1),
	   BenefitSelection       VARCHAR(10)      NOT NULL
);

CREATE TABLE Benefits (
       BenefitID              INT              PRIMARY KEY    IDENTITY(1,1),
	   BenefitCost            INT              NOT NULL       CHECK(BenefitCost >= 0),
	   BenefitSelectionID     INT              NOT NULL       REFERENCES BenefitSelection(BenefitSelectionID),
	   BenefitDescription     VARCHAR(100) 
);

CREATE TABLE JobInformation (
       JobID                  INT              PRIMARY KEY    IDENTITY(1,1),
	   JobTitle               VARCHAR(50)      NOT NULL,
	   JobDescription         VARCHAR(200)     NOT NULL,
	   JobRequirements        VARCHAR(500)             ,
	   MinPay                 INT              NOT NULL       CHECK(MinPay >= 0),
	   MaxPay                 INT              NOT NULL,      CHECK(MaxPay >= MinPay),
	   UnionJob               BIT              NOT NULL       DEFAULT 'Y'
);

CREATE TABLE EmployeeInfo (
      EmployeeID              INT              PRIMARY KEY    IDENTITY(1,1),
	  PersonID                INT              NOT NULL       REFERENCES People(PersonId),
	  YearlyPay               INT              NOT NULL       CHECK(YearlyPay >= 0),
	  HealthBenefits          INT              NOT NULL       REFERENCES Benefits(BenefitID),
	  VisionBenefits          INT              NOT NULL       REFERENCES Benefits(BenefitID),
	  DentalBenefits          INT              NOT NULL       REFERENCES Benefits(BenefitID),
	  JobInformation          INT              NOT NULL       REFERENCES JobInformation(JobID)
);

CREATE TABLE CourseCatalogue (
      ID                      INT              PRIMARY KEY    IDENTITY(1,1),
      CourseCode              VARCHAR(10)      NOT NULL,
	  CourseNumber            INT              NOT NULL       CHECK (CourseNumber >= 0),
	  CourseTitle             VARCHAR(50)      NOT NULL,
	  CourseDesc              VARCHAR(500)    
);

CREATE TABLE Prerequisites (
      ID                     INT              PRIMARY KEY    IDENTITY(1,1),
	  PreRequsisteID         INT              NOT NULL       REFERENCES CourseCatalogue(ID),
	  ParentID               INT              NOT NULL       REFERENCES CourseCatalogue(ID)
);

CREATE TABLE Buildings (
      ID                     INT              PRIMARY KEY    IDENTITY(1,1),
	  BuildingName           VARCHAR(100)     NOT NULL 
);

CREATE TABLE ProjectInfo (
      ProjectID              INT             PRIMARY KEY    IDENTITY(1,1),
	  ProjectText            VARCHAR(20)     NOT NULL
);

CREATE TABLE ClassRoom (
      ClassRoomID            INT              PRIMARY KEY    IDENTITY(1,1),
	  Building               INT              NOT NULL       REFERENCES Buildings(ID),
	  RoomNumber             VARCHAR(20)      NOT NULL,
	  MaximumSeating         INT              NOT NULL       CHECK(MaximumSeating >= 0),
	  Projector              INT              NOT NULL       REFERENCES ProjectInfo(ProjectID),
	  WhiteBoardCount        INT              NOT NULL       CHECK(WhiteBoardCount >= 0),
	  OtherAV                VARCHAR(100) 
);

CREATE TABLE StudentStatus (
     StudentStatusID         INT             PRIMARY KEY    IDENTITY(1,1),
	 StudentStatus           VARCHAR(20)     NOT NULL
);

CREATE TABLE StudentInfo (
     StudentID               INT             PRIMARY KEY    IDENTITY(1,1),
	 PersonID                INT             NOT NULL       REFERENCES People(PersonId),
	 StudentStatusID         INT                            REFERENCES StudentStatus(StudentStatusID)
);

CREATE TABLE College (
     CollegeID               INT              PRIMARY KEY    IDENTITY(1,1),
	 CollegeName             VARCHAR(100)     NOT NULL 
);

CREATE TABLE AreaOfStudy (
     AreaOfStudyID           INT             PRIMARY KEY    IDENTITY(1,1),
	 StudyTitle              VARCHAR(100)    NOT NULL,
	 CollegeID               INT             NOT NULL       REFERENCES College(CollegeID)
);

CREATE TABLE StudentAreaOfStudy (
    StudentAreaOfStudyID     INT             PRIMARY KEY    IDENTITY (1,1),
	StudentID                INT             NOT NULL       REFERENCES StudentInfo(StudentID),
	AreaID                   INT             NOT NULL       REFERENCES AreaOfStudy(AreaOfStudyID),
	IsMajor                  BIT             NOT NULL       DEFAULT 'Y'         
);

CREATE TABLE SemesterText (
    SemesterTextID           INT             PRIMARY KEY    IDENTITY(1,1),
	SemesterText             VARCHAR(20)     NOT NULL
);

CREATE TABLE SemesterInfo (
    SemesterID              INT              PRIMARY KEY    IDENTITY (1,1),
	Semester                INT              NOT NULL       REFERENCES SemesterText(SemesterTextID),
	-- we can plan semesters ahead so put a check of year till 2100
	YearInfo                INT              NOT NULL       CHECK(YEARInfo >= 1900 AND YEARInfo <= 2100),
	FirstDay                DATE             NOT NULL,
	LastDay                 DATE             NOT NULL
);

CREATE TABLE CourseSchedule (
    CourseScheduleID        INT             PRIMARY KEY     IDENTITY(1,1),
	CourseID                INT             NOT NULL        REFERENCES CourseCatalogue(ID),
	NumberOfSeats           INT             NOT NULL        CHECK(NumberOfSeats >= 0),
	Location                INT                             REFERENCES ClassRoom(ClassRoomID),
	Semester                INT             NOT NULL        REFERENCES SemesterInfo(SemesterId)
);

CREATE TABLE TeachingAssignment (
	ID                      INT             PRIMARY KEY     IDENTITY(1,1),
    EmployeeID              INT             NOT NULL        REFERENCES EmployeeInfo(EmployeeID),
	CourseScheduleID        INT             NOT NULL        REFERENCES CourseSchedule(CourseScheduleID)
);

CREATE TABLE Grades (
    GradeID                 INT            PRIMARY KEY      IDENTITY(1,1),
	Grade                   CHAR(1)        NOT NULL,
	GradeDescription        VARCHAR(100)   NOT NULL
);

CREATE TABLE StudentGradingStatus (
    StudentStatusId         INT            PRIMARY KEY      IDENTITY(1,1),
	StudentStatus           VARCHAR(10)    NOT NULL
);

CREATE TABLE StudentCourseEnrollment (
    EnrollmentID            INT             PRIMARY KEY     IDENTITY(1,1),
	CourseID                INT             NOT NULL        REFERENCES CourseSchedule(CourseScheduleID),
	StudentID               INT             NOT NULL        REFERENCES StudentInfo(StudentID),
	StatusID                INT             NOT NULL        REFERENCES StudentGradingStatus(StudentStatusId),
	GradeID                 INT                             REFERENCES Grades(GradeID)
);

CREATE TABLE DayOfWeekInfo (
   ID                       INT             PRIMARY KEY     IDENTITY(1,1),
   Text                     VARCHAR(10)     NOT NULL
);

CREATE TABLE CourseDailySchedule (
   DailyID                  INT             PRIMARY KEY     IDENTITY(1,1),
   CourseID                 INT             NOT NULL        REFERENCES CourseSchedule(CourseScheduleID),
   DayofWeekID              INT             NOT NULL        REFERENCES DayOfWeekInfo(ID),
   StartTime                TIME            NOT NULL,
   EndTime                  TIME            NOT NULL 
);


--- Begin Of Data Insertion

INSERT INTO AddressInfo(Street1, Street2, City, State, ZIP)
    VALUES
	       ('Castle Black',             'Beyond the Wall',   'Land of Winter',      'Night Watch',      '12345'),
	       ('DreadFort',                'Lust River',        'Winterfell',          'North',            '23456'),
	       ('Pyke',                     'IRON ISLANDS',      'IRONMAN BAY',         'Westcoast',        '34567'),
	       ('Mountains of Moon',        'Vale of Arryn',     'Narrow Sea',          'Eastern Westros' , '45678'),
	       ('Dorne',                    'House of Martell',  'Near Summer Sea',     'Southern Westros', '56789'),
	       ('Winterfell',               'House of Stark',    'Vast land',           'Northern Westros', '67890'),
	       ('Doom of valyria',          'Dothraki',          'Smoking Sea',         'Essos',            '13579'),
	       ('Mother of Mountains',      'Vaes Dothrak',      'Dothraki Sea',        'Essos',            '23759'),
	       ('Eyrie',                    'House Arryn',       'Moutanins Moon',      'Eastern Westros',  '32597'),
	       ('Dragonstone',              'House Baratheon',   'Storm End',           'SothEast Westros', '54786'),
	       ('House of Black And White', 'Bravos',            'Narrow Sea',          'NorthWest Essos',  '97531'),
	       ('King''s Landing',          'Crownlands',        'BlackWater Bay',      'East of Westros',  '75913'),
	       ('House Tyrell',             'HighGarden',        'The Reach',           'SouthWest Westros','24681'),
	       ('DreadFort',                'House Bolton',      'Upper Weaping Water', 'Northeast Westros','13542');                     

INSERT INTO People (NTID, FirstName, LastName, Password, DOB, SSN, HomeAddress, LocalAddress, IsActive)
    VALUES
	       ('646254141', 'Tyrion',   'Lannister', 'DwarfMemeber', '1994-10-22', '123-456-7890', 9,  NULL,    1),
	       ('546254181', 'Daenerys', 'Targaryen', 'KhalDrogo',    '1993-9-21',  '213-434-0781', 8,  7,       1),
	       ('451234512', 'Eddard'  , 'Stark',     'LoyalFriend',  '1910-2-13',  '312-343-0871', 6,  NULL,    0),
	       ('135792468', 'Robert',   'Baratheon', 'AlwaysDrinks', '1920-3-10',  '132-465-7980', 10, NULL,    0),
           ('552319780', 'Jon',      'Snow',      'Bastard',      '1970-8-28',  '456-123-7890', 1,  1,       1),
	       ('663412879', 'Petyr',    'Baelish',   'MasterofCoin', '1920-11-18', '465-132-7809', 4,  NULL,    1),
	       ('773413287', 'Arya',     'Stark',     'FacelessMan',  '1990-5-12',  '564-321-8079', 6,  11,      1),
	       ('887766554', 'Lord',     'Varys',     'WhsiperMaster','1910-8-13',  '678-956-1234', 12, NULL,    1),
	       ('997766455', 'Margaery', 'Tyrell',    'Queen',        '1983-11-5',  '768-596-1324', 13, NULL,    0),
	       ('234156871', 'Ramsay',   'Bolton',    'psychopath',   '1990-12-20', '567-890-1234', 14, NULL,    1);

INSERT INTO College(CollegeName)
    VALUES
	       ('Counseling & Human Services'),
 	       ('Elec Eng & Computer Science'),
	       ('Fashion & Design Technology'),
	       ('Law College'),
	       ('Martin J. Whitman School of Management'),
	       ('Maxwell School of Citizenship and Public Affairs'),
	       ('S.I. Newhouse School of Public Communications'),
	       ('School of Information Studies');

INSERT INTO AreaOfStudy(StudyTitle, CollegeID)
    VALUES
	       ('Family and Human Services', 1),
	       ('Couples and Family Therapy', 1),
 	       ('Computer Engineering',2),
	       ('Electrical Engineering', 2),
	       ('Costume Design', 3),
	       ('Apparel Design', 3),
  	       ('Environmental Law', 4),
     	   ('Federal law', 4),
	       ('Entreprenuership', 5),
	       ('Finance', 5),
      	   ('Public Administration', 6),
	       ('International Relations', 6),
	       ('Journalism', 7),
	       ('Television & Films', 7),
	       ('Information management', 8),
	       ('Telecommunications and Networking', 8);

INSERT INTO StudentStatus(StudentStatus)
    VALUES 
	       ('Undergraduate'),
		   ('Graduate'),
		   ('Non-Matriculated'),
		   ('Graduated');

INSERT INTO StudentInfo(PersonID, StudentStatusID)
    VALUES 
	       (2,2),
	       (5,2),
		   (7,1),
	       (8,4),
		   (9,1);

INSERT INTO StudentAreaOfStudy(StudentID, AreaID, IsMajor)
    VALUES 
	       (1,3,1),
		   (1,4,0),
		   (2,9,0),
		   (2,10,1),
		   (3,11,1),
		   (3,12,0),
		   (4,15,1),
		   (5,4,1);


INSERT INTO Buildings(BuildingName)
    VALUES ('HarrenHal'),
	       ('DragonStone'),
		   ('Casterly Rock'),
		   ('DreadFort'),
		   ('HighGarden'),
		   ('IronRath'),
		   ('Riverrun');
	       

INSERT INTO CourseCatalogue(CourseCode, CourseNumber, CourseTitle, CourseDesc)
    VALUES
	        ('CSE',  581,  'Intro to DataBase',               'DBMS entiry Relationships,SQL query,Indexing,Transactions'),
			('CSE',  382,  'Algorithms & Data Structures',    'Structures, Pointers, Linkedlist, recursions'),
			('CSE',  776,  'Design Patterns',                 'Conceptual understanding of OOD techniques'),
			('CSE',  681,  'Software Modelling & Analysis',   'Modelling software for large scale distributed systems'),
			('NBA', 6780,  'Entrepreneurial Marketing',       'Core marketing strategies for early stage development'),
			('AEM', 1200,  'Intro to Business Management',    'Overview of HR, Marketing, Finance, Strategy'),
			('IST',  618,  'Information Policy',              'Public policies affecting telecom sector'),
			('IST',  619,  'Applied Economics',               'Financial Tools to the managers'),
			('ELE',  324,  'ElectroMagnetics',                'Faraday''s Law, Vector Analysis, Transmission theory'),
			('PHY',  212,  'General Physics',                 'Electricity, Magnetism and Optics'),
			('ELE',  352,  'Digital Signal Processing',       'DFT, Z transforms, FIR, IIR Filters'),
			('ELE',  351,  'Signals and Systems',             'Continous time, Discrete time, frqency Domains'),
			('ELE',  325,  'ElectroMagnetics II',             'Maxwell Equations, Power Waves, Antenna Theory');
            
INSERT INTO Prerequisites(PreRequsisteID, ParentID)
    VALUES 
	        (2,1),
			(4,3),
			(6,5),
			(8,7),
			(10,9),
			(12,11),
			(9,13),
			(10,13);   

INSERT INTO SemesterText (SemesterText)
	VALUES
		   ('Fall'),
		   ('Spring'),
		   ('Summer');

INSERT INTO DayOfWeekInfo(Text)
    VALUES
	       ('Monday'),
		   ('Tuesday'),
		   ('Wednesday'),
		   ('Thursday'),
	  	   ('Friday'),
		   ('Saturday'),
		   ('Sunday');

INSERT INTO Grades(Grade, GradeDescription)
    VALUES
	       ('O', 'Outstanding'),
		   ('E', 'Exceeds Expectations'),
		   ('A', 'Acceptable'),
		   ('P', 'Poor'),
		   ('D', 'Dreadful'),
		   ('T', 'Troll');

INSERT INTO ProjectInfo(ProjectText)
    VALUES 
	       ('Yes-Basic'),
		   ('Yes-SmartBoard'),
		   ('No');

INSERT INTO ClassRoom(Building, RoomNumber, MaximumSeating, Projector, WhiteBoardCount, OtherAV)
    VALUES 
	       (1, 'NewHouse-101',          50, 2, 0, 'Bose Speakers'),
		   (4, 'HungtingtonHall-101',   60, 1, 1,  'Data Projectors'),
		   (3, 'ManagementSchool-202',  80, 3, 2, 'Powered Speakers'),
		   (2, 'LinkHall-203',          90, 2, 0, 'VGA Conversion Devices'),
		   (5, 'SimmonHall-305',       100, 2, 1, '20 Class Room Computers'),
		   (7, 'SLutzker Center-203',  150, 2, 5, 'Latest Audio Visual Technology');

INSERT INTO SemesterInfo(Semester, YearInfo, FirstDay, LastDay)
    VALUES
		   (1, 2016, '2016-08-01', '2016-12-13'),
		   (2, 2016, '2016-01-17', '2016-05-16'),
		   (1, 2015, '2015-08-01', '2015-12-13'),
           (2, 2015, '2015-01-17', '2015-05-16'),
           (3, 2016, '2017-05-15', '2017-08-01');

INSERT INTO CourseSchedule(CourseID, NumberOfSeats, Location, Semester)
    VALUES 
	       (1, 50, 1,    1),
		   (1, 50, 1,    2),
		   (2, 43, 5,    1),
		   (3, 40, 2,    3),
		   (4, 80, 3,    2),
		   (4, 80, NULL, 3),
		   (11,35, NULL, 1),
		   (12, 35, 4,   2);
	      
INSERT INTO CourseDailySchedule(CourseID, DayofWeekID, StartTime, EndTime)
    VALUES 
	       (1, 4, '05:00:00', '07:20:00'),
		   (1, 1, '11:00:00', '12:20:00'),
		   (2, 4, '11:00:00', '12:20:00'),
		   (2, 2, '03:00:00', '04:00:00'),
		   (3, 3, '02:05:00', '03:15:00'),
		   (3, 6, '09:55:00', '11:00:00'),
		   (4, 5, '04:30:00', '06:00:00'),
		   (4, 3, '03:45:00', '05:00:00'),
		   (4, 1, '08:45:00', '11:00:00'),
		   (3, 2, '08:00:00', '09:20:00'),
		   (7, 3, '10:10:00', '11:20:00'),
		   (8, 4, '01:20:00', '02:30:00');

INSERT INTO JobInformation(JobTitle, JobDescription, JobRequirements, MinPay, MaxPay, UnionJob)
    VALUES 
	       ('RSA',                 'Residential Security Aid',             'Student on the Campus',      9, 12, 0),
		   ('Assistant Professor', 'Conduct the course schedule',          'PHD',                       40, 50, 1),
		   ('RA',                  'Research Assistant',                   'Work on a research project',20, 25, 0),
		   ('TA',                  'Teaching Assistant',                   'Aid in the course grading', 15, 20, 0),
		   ('Food Service',        'Maintain Sanity in Dining Halls',      'Uniform needed for job',    10, 12, 0),
		   ('IT Service Aid',      'Troubleshooting the software issues',  'Knowledge of boot system',  12, 15, 0),
		   ('Librarian',           'Maintain the book records in library', 'English Proficiency',       13, 16, 0),
		   ('Associate Professor', 'Teach the Course for Undergraduate',   'Less Experience',           25, 30, 0);

INSERT INTO BenefitSelection(BenefitSelection)
    VALUES 
           ('Single'),
           ('Family'),
           ('Op-out');

INSERT INTO Benefits(BenefitCost, BenefitSelectionID, BenefitDescription)
    VALUES  
	       (50000,  1, 'single Affordable Health Cost'),
		   (20000,  1, 'single Affordable Vision Cost'),
		   (28000,  1, 'single Affordable Dental benefit'),
		   (150000, 2, 'Family Health cost'),
		   (250000, 2, 'Family premium Health cost'),
		   (200000, 2, 'Family Vision cost'),
		   (100000, 2, 'Family Dental cost'),
		   (35000,  3, 'op-out Health cost'),
		   (15000,  3, 'op-out vision cost'),
		   (22000,  3, 'op-out Dental cost'),
		   (25000,  3, 'op-out Premium Dental cost');
		   
INSERT INTO EmployeeInfo(PersonID, YearlyPay, HealthBenefits, VisionBenefits, DentalBenefits, JobInformation)
    VALUES 
	       (1,  95000, 1, 2, 3,  2),
		   (3,  50000, 5, 6, 7,  1),
		   (4,  75000, 4, 9, 11, 3),
		   (6,  40000, 8, 9, 10, 5),
		   (10, 60000, 4, 2, 10, 8);

INSERT INTO TeachingAssignment(EmployeeID, CourseScheduleID)
    VALUES 
	       (1, 1),
		   (1, 2),
		   (2, 3),
		   (3, 4),
		   (4, 5),
		   (4, 6),
		   (5, 7),
		   (5, 8);
		   
INSERT INTO StudentGradingStatus(StudentStatus)
    VALUES 
	       ('Audit'),
		   ('Register'),
           ('Pass'),
		   ('Fail'),
		   ('CourseDrop');

-- here CourseId refers to CourseScheduleID
INSERT INTO StudentCourseEnrollment(CourseId, StudentID, StatusID, GradeID)
    VALUES  
	       (1, 1, 1, 2),
		   (2, 2, 2, 2),
		   (3, 2, 2, 3),
		   (1, 2, 3, 4),
		   (2, 3, 5, NULL),
		   (5, 4, 2, 2),
		   (7, 3, 4, 5),
		   (8, 1, 4, 6);

-- Creates a view to get the list of all the students
-- who have failed in the courses in current Year 2016
-- Run the below Query to drop the view
-- DROP VIEW StudentsOnProbation
-- Run the below Statement to Check the output
-- SELECT * FROM StudentsOnProbation

CREATE VIEW StudentsOnProbation AS
      SELECT p.FirstName, p.LastName, cc.CourseCode, cc.CourseNumber, sgs.StudentStatus, st.SemesterText, si.YearInfo
          FROM StudentCourseEnrollment sc
	      INNER JOIN StudentInfo s ON
	      sc.StudentID = s.StudentID
	      INNER JOIN CourseSchedule cs ON
	      cs.CourseScheduleID = sc.CourseID
	      INNER JOIN CourseCatalogue cc ON
	      cs.CourseID = cc.ID
	      INNER JOIN StudentGradingStatus sgs ON
	      sgs.StudentStatusId = sc.StatusID
	      INNER JOIN People p ON
	      p.PersonID = s.PersonID
	      INNER JOIN SemesterInfo si ON
	      si.SemesterID = cs.Semester
	      INNER JOIN SemesterText st ON
	      si.Semester = st.SemesterTextID
	      WHERE sgs.StudentStatus IN ('Fail')
	      AND si.YearInfo IN (2016);

-- create a view to get all the students , their areas of study Concentration,
-- college under which they study or affliated to, Major or Minor Status, and their studentstatus
-- Run the below Query to drop the view
-- DROP VIEW StudentAreaOfConcentrationAndStatusInfo
-- Run the below Statement to Check the output
-- SELECT * FROM StudentAreaOfConcentrationAndStatusInfo

CREATE VIEW StudentAreaOfConcentrationAndStatusInfo AS
      SELECT p.FirstName, p.LastName, ss.StudentStatus, Aos.StudyTitle, sas.IsMajor, c.CollegeName
          FROM  StudentInfo si,StudentStatus ss, StudentAreaOfStudy sas,
		        AreaOfStudy Aos, College c, People p
          WHERE si.PersonID = p.PersonID AND
                si.StudentStatusID = ss.StudentStatusID AND 
				sas.StudentID = si.StudentID AND
				sas.AreaID = Aos.AreaOfStudyID AND
                Aos.CollegeID = c.CollegeID 

-- create a view to get the course time table which includes 
-- instructor name, CourseName, Building, ClassRoom, Daily Schedule 
-- like dayofweek, start and end times 
-- Run the below Query to drop the view
-- DROP VIEW CourseTimeTableWithScheduleInfo
-- Run the below Statement to Check the output
-- SELECT * FROM CourseTimeTableWithScheduleInfo

CREATE VIEW CourseTimeTableWithScheduleInfo AS
       SELECT    P.FirstName+' '+P.LastName AS Instructor, 
	             CC.CourseCode+ ' '+ CAST(CC.CourseNumber AS VARCHAR(10)) AS CourseName, 
	             B.BuildingName, CR.RoomNumber, ST.SemesterText, DOW.Text AS DayofWeekInfo, 
				 CDS.StartTime, CDS.EndTime
	       FROM  TeachingAssignment TA, CourseSchedule CS, CourseDailySchedule CDS,
		         EmployeeInfo EI, People P, CourseCatalogue CC, ClassRoom CR,
				 SemesterInfo SI, SemesterText ST, Buildings B, DayOfWeekInfo DOW
		   WHERE TA.EmployeeID = EI.EmployeeID AND
		         P.PersonID    = EI.PersonID AND
				 CS.CourseScheduleID = TA.CourseScheduleID AND
                 CC.ID  = CS.CourseID AND
				 CDS.CourseID = CS.CourseScheduleID AND
				 CR.ClassRoomID = CS.Location AND
				 CS.Semester = SI.SemesterID AND
				 SI.Semester = ST.SemesterTextID AND
				 B.ID = CR.Building AND 
				 CDS.DayofWeekID = DOW.ID


-- create a view to get the Faculty Name, their job description, All the Benefits Costs Enrollment,
-- Address to send the pay checks 
-- Run the below Query to drop the view
-- DROP VIEW FacultyAndBenefitsInfo
-- Run the below Statement to Check the output
-- SELECT * FROM FacultyAndBenefitsInfo

CREATE VIEW FacultyAndBenefitsInfo AS
      SELECT  DISTINCT P.FirstName, P.LastName, B1.BenefitCost AS HealthCost, 
	                   B2.BenefitCost AS VisionCost, B3.BenefitCost AS DentalCost, 
	                   A.Street1+ ',' + A.street2 + ',' + A.City + ','+ A.State + ','+ A.ZIP AS AddressInfo,
				       JI.JobDescription
	      FROM   EmployeeInfo EI, TeachingAssignment TA, People P, AddressInfo A,
		         Benefits B1, Benefits B2, Benefits B3, BenefitSelection BS, JobInformation JI
		  WHERE  TA.EmployeeID = EI.EmployeeID AND 
		         P.PersonID = EI.PersonID AND
		         P.HomeAddress = A.AddressID AND
				 EI.HealthBenefits = B1.BenefitID AND
				 EI.VisionBenefits = B2.BenefitID AND
				 EI.DentalBenefits = B3.BenefitID AND 
				 JI.JobID = EI.JobInformation

-- change the course schedule of a course for ease of instructor 
-- which involves changing the start and end time of the course, dayofweek ofschedule.
-- Execute the below Query to drop the procedure
-- DROP PROCEDURE dbo.ChangeCourseScheduleTimings
-- Execute the Code with the below Qeury
-- This query has start tme less than end time hence is a failure
-- EXEC dbo.ChangeCourseScheduleTimings '1', '1', '09:00:00', '08:30:00' ,'3'
-- EXEC dbo.ChangeCourseScheduleTimings '1', '1', '08:30:00', '09:40:00' ,'4'
CREATE PROCEDURE dbo.ChangeCourseScheduleTimings(@EmployeeID AS INTEGER, @CourseScheduleID AS INTEGER,
                                                                 @StartTime AS TIME, @EndTime AS TIME, 
                                                                                @DayOfWeek AS INTEGER)
	  AS 
	      -- check if the instructor and CoursescheduleID exist in the TeachingAssignment Table
	      IF NOT EXISTS(SELECT * FROM TeachingAssignment WHERE EmployeeID = @EmployeeID AND 
		                                                   CourseScheduleID = @CourseScheduleID)
			 BEGIN
			       PRINT 'There is no faculty and CourseSchedule associated with the given parameters'
			 END
			     -- DayOfWeek is index  week days from Monday to Sunday
		  IF ((@DayOfWeek < 1) OR (@DayOfWeek > 7))
             BEGIN
                   PRINT 'Invalid DayOfweek parameter received'
             END
          IF (DATEDIFF(second, 0, @StartTime) -  DATEDIFF(second, 0, @EndTime) > 0)
              BEGIN
	--		       SELECT DATEDIFF(second, 0, @StartTime) -  DATEDIFF(second, 0, @EndTime)
                   PRINT 'StartTime Must be greater than End Time.'
              END
          ELSE
              BEGIN
                    UPDATE CourseDailySchedule
                    SET DayOfWeekID = @DayOfWeek, 
                    StartTime = @StartTime, 
                    EndTime   = @EndTime
					WHERE CourseID = @CourseScheduleID;
                    PRINT 'Updated the CourseDailySchedule with the given parameters'
			  END;


-- create a procedure for a student to register for a course
-- the procedure should check if the student is already resgistered ,
-- if so return an error.
-- If the student failed in the prerquisite course or didnot register for 
-- prerequisiste course return an error
-- Else update the course enrollment and number of open seats  
-- If there are no open seats return an error 
-- EXEC dbo.StudentCourseRegistration '4', '4' , '6'
-- PRINTS That the student has not registered for courses ELE 324, PHY 212
-- Drop the Procedure with the below Query
-- DROP PROCEDURE dbo.StudentCourseRegistration

CREATE PROCEDURE dbo.StudentCourseRegistration(@StudentID AS INTEGER,
                                               @CourseID  AS INTEGER,
                                               @CourseScheduleID AS INTEGER)
      AS
	    DECLARE @preReqID AS INTEGER
        SET @preReqID = 0
		DECLARE @flag AS INTEGER
		SET @flag = 0;
		IF NOT EXISTS (SELECT * 
                           FROM CourseSchedule 
                           WHERE CourseScheduleID = @CourseScheduleID AND
                           @CourseID = CourseID)
          BEGIN
              PRINT 'The Corresponsing Course doesnot exist in the schedule Information'
              RETURN
          END
		DECLARE @OpenSeats AS INTEGER 
		SET @OpenSeats = 0
		SELECT @OpenSeats = NumberOfSeats
            FROM CourseSchedule 
            WHERE CourseScheduleID = @CourseScheduleID AND
            @CourseID = CourseID
        IF @OpenSeats <= 0
		  BEGIN
		      PRINT 'There are no open seats left for the student to Register.'
			  RETURN
		  END
        DECLARE MyCursor CURSOR FOR
        SELECT PreRequsisteID 
            FROM  Prerequisites
	        WHERE ParentID = @CourseID  
        OPEN MyCursor
		FETCH NEXT FROM MyCursor INTO @preReqID
        WHILE @@FETCH_STATUS = 0
            BEGIN
               IF NOT EXISTS(SELECT * 
                                  FROM  StudentCourseEnrollment 
                                  WHERE StudentId = @StudentID AND
								        CourseId  = @preReqID)
                  BEGIN
				      DECLARE @CourseName AS VARCHAR(20)
                      SELECT @CourseName = (CC.CourseCode+ ' ' +CAST(CC.CourseNumber AS VARCHAR(10))) 
                          FROM CourseCatalogue CC
                          WHERE CC.ID = @preReqID 
                      PRINT 'The student has not completed the PreRequisite ' + @CourseName
                      SET @flag = 1
				  END
			   ELSE
			      BEGIN
				      DECLARE @GradeID AS INTEGER
					  SELECT @CourseName = (CC.CourseCode+ ' ' +CAST(CC.CourseNumber AS VARCHAR(10))) 
					      FROM CourseCatalogue CC 
						  WHERE CC.ID = @preReqID 
					  SELECT @GradeID = GradeID
					      FROM StudentCourseEnrollment 
						  WHERE CourseID = @CourseScheduleID
						  AND StudentID = @StudentID
					  -- If the grade is from poor to troll
					  -- student is advised to retake the prerequisiste first
                      IF @GradeID IS NOT NULL AND @GradeID >=4 AND @GradeID <= 7
					    BEGIN
						   PRINT 'The student should repeat the prerequsiste ' + 
						          @CourseName + ' due to poor performance'
						END
				  END
				FETCH NEXT FROM MyCursor INTO @preReqID
			END
        IF @flag = 1
           BEGIN
              CLOSE MyCursor
              DEALLOCATE MyCursor
              RETURN
           END
        CLOSE MyCursor
        DEALLOCATE MyCursor
		-- Now check if the student is already 
		-- registered in this course
		-- In this case return failure
        IF EXISTS(SELECT * 
                      FROM StudentCourseEnrollment 
                      WHERE StudentId = @StudentID AND
                      CourseId  = @CourseScheduleID)
           BEGIN
		       SELECT @CourseName = (CC.CourseCode+ ' ' +CAST(CC.CourseNumber AS VARCHAR(10))) 
                          FROM CourseCatalogue CC 
                          WHERE CC.ID = @CourseID 
               PRINT 'The student has already Registered for the Course' + @CourseName
               RETURN
		   END
        INSERT INTO StudentCourseEnrollment(CourseID, StudentID, StatusID, GradeID)
		     VALUES 
                   (@CourseScheduleID, @StudentID, 3, NULL);
		UPDATE CourseSchedule
		SET NumberOfSeats = NumberOfSeats - 1
		WHERE CourseScheduleID = @CourseScheduleID AND
		      CourseId  = @CourseID
		
 -- Because of Research grants and Benefits the University 
-- wants to update the yearly pay of the faculty in the
-- university. Increase the Yearly pay of Assistant Professor
-- by 10% and Associate Professor by 20% 
-- Execute the below query to drop the Procedure
-- DROP PROCEDURE dbo.IncreasetheFacultyPay 
-- Return an integer with Success/Failure of Table Updation
-- Excute the Procedure as given below
-- DECLARE @result AS INTEGER 
-- EXEC dbo.IncreasetheFacultyPay @result OUTPUT
-- SELECT @result 

CREATE PROCEDURE dbo.IncreasetheFacultyPay(@output AS INTEGER OUT) 
      AS
	    BEGIN TRAN
	       SET @output = 0
		   DECLARE MyCursor CURSOR FOR 
	       SELECT e.EmployeeID, p.FirstName, p.LastName, e.YearlyPay, e.JobInformation
		   FROM EmployeeInfo e
           INNER JOIN People P ON
           P.PersonID = e.PersonID
           WHERE JobInformation IN (SELECT JobID 
			                             FROM JobInformation
										 WHERE JobTitle IN ('Assistant Professor', 'Associate Professor'))
		   OPEN MyCursor
		   DECLARE @FirstName AS VARCHAR(20)
		   DECLARE @LastName AS VARCHAR(20)
		   DECLARE @EmployeeID AS INTEGER
		   DECLARE @Pay AS INTEGER
		   DECLARE @newPay AS INTEGER
		   DECLARE @JobID AS INTEGER
		   FETCH NEXT FROM MyCursor INTO @EmployeeID, @FirstName, @LastName, @Pay, @JobID
		   WHILE @@FETCH_STATUS = 0
		       BEGIN
			       -- Increase the Pay by 10% for Assistant Professor
			       IF @JobID = 2
				     BEGIN
					     SET @newPay = @Pay * 1.1
					 END
				   -- Increase the Pay by 20% for Associate Professor
				   ELSE
				     BEGIN
					     SET @newPay = @Pay * 1.2
					 END
			       UPDATE EmployeeInfo
				   SET YearlyPay = @newPay
				   WHERE EmployeeID = @EmployeeID
				   IF @@ERROR <> 0
				     BEGIN
					    PRINT 'Error In Updation of Table. Rollback the Transaction'
						 CLOSE MyCursor
                         DEALLOCATE MyCursor
		                 SET @output = 0
						 ROLLBACK TRAN
						 RETURN @output
					 END
			       PRINT 'The pay is updated for the Employee ' + @FirstName + ' ' + @LastName
				         + ' From ' + CAST(@Pay AS VARCHAR(10)) + ' to ' + CAST(@newPay AS VARCHAR(10)) 
				   FETCH NEXT FROM MyCursor INTO @EmployeeID, @FirstName, @LastName, @Pay, @JobID
			   END
		   CLOSE MyCursor
           DEALLOCATE MyCursor
		   SET @output = 1
		COMMIT TRAN
		   RETURN @output

-- Return a Table which contains the Undergraduate and
-- Graduate students and number of credits completed. Assume
-- Each course is of 3 credits . Count the Credit Completion
-- only on  courses passed by Students.
-- DROP The function as below
-- DROP FUNCTION dbo.CalculateCreditsCompleted
-- EXECUTE the Query As below
-- SELECT * FROM dbo.CalculateCreditsCompleted()

CREATE FUNCTION dbo.CalculateCreditsCompleted()
     RETURNS @rtnTable TABLE(StudentName  VARCHAR(50), StudentStatus VARCHAR(20),CreditComplete INTEGER)
	 AS 
	    BEGIN
		   INSERT INTO @rtnTable
		       SELECT P.FirstName + ' ' + P.LastName, SS.StudentStatus, COUNT(*) * 3
			       FROM StudentCourseEnrollment SCE
                   INNER JOIN StudentInfo SI ON
				   SI.StudentID = SCE.StudentID
				   INNER JOIN People P ON
				   P.PersonID = SI.PersonID
				   INNER JOIN StudentStatus SS ON
				   SS.StudentStatusID = SI.StudentStatusID
				   INNER JOIN Grades G ON
				   G.GradeID = SCE.GradeID
				   -- check the grade so that only passed courses are counted
				   WHERE G.GradeID BETWEEN 1 AND 4
				   GROUP BY P.FirstName + ' ' + P.LastName, SS.StudentStatus
				   HAVING SS.StudentStatus IN ('Undergraduate','Graduate')
		   RETURN 
		END

