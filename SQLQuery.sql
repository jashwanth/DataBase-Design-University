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
       SSN			  VARCHAR(11)             ,
       HomeAddress    INT             NOT NULL            REFERENCES AddressInfo(AddressId),
       LocalAddress   INT                                 REFERENCES AddressInfo(AddressId),
       IsActive       BIT             NOT NULL
);

CREATE TABLE BenefitSelection (
       BenefitSelectionID     INT              PRIMARY KEY    IDENTITY(1,1),
	   BenefitSelection       VARCHAR(10)      NOT NULL
);
CREATE TABLE Benefits (
       BenefitID              INT              PRIMARY KEY    IDENTITY(1,1),
	   BenefitCost            INT              NOT NULL,
	   BenefitSelectionID     INT              NOT NULL       REFERENCES BenefitSelection(BenefitSelectionID),
	   BenefitDescription     VARCHAR(100) 
);

CREATE TABLE JobInformation (
       JobID                  INT              PRIMARY KEY    IDENTITY(1,1),
	   JobTitle               VARCHAR(50)      NOT NULL,
	   JobDescription         VARCHAR(200)     NOT NULL,
	   JobRequirements        VARCHAR(500)             ,
	   MinPay                 INT              NOT NULL,
	   MaxPay                 INT              NOT NULL,
	   UnionJob               BIT              NOT NULL
);

CREATE TABLE EmployeeInfo (
      EmployeeID              INT              PRIMARY KEY    IDENTITY(1,1),
	  PersonID                INT              NOT NULL       REFERENCES People(PersonId),
	  YearlyPay               INT              NOT NULL,
	  HealthBenefits          INT              NOT NULL       REFERENCES Benefits(BenefitID),
	  VisionBenefits          INT              NOT NULL       REFERENCES Benefits(BenefitID),
	  DentalBenefits          INT              NOT NULL       REFERENCES Benefits(BenefitID),
	  JobInformation          INT              NOT NULL       REFERENCES JobInformation(JobID)
);

CREATE TABLE CourseCatalogue (
      ID                      INT              PRIMARY KEY    IDENTITY(1,1),
      CourseCode              VARCHAR(10)      NOT NULL,
	  CourseNumber            INT              NOT NULL,
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
      ProjectID              INT              PRIMARY KEY    IDENTITY(1,1),
	  ProjectText            VARCHAR(20)     NOT NULL
);

CREATE TABLE ClassRoom (
      ClassRoomID            INT              PRIMARY KEY    IDENTITY(1,1),
	  Building               INT              NOT NULL       REFERENCES Buildings(ID),
	  RoomNumber             VARCHAR(20)      NOT NULL,
	  MaximumSeating         INT              NOT NULL,
	  Projector              INT              NOT NULL       REFERENCES ProjectInfo(ProjectID),
	  WhiteBoardCount        INT              NOT NULL,
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
	IsMajor                  BIT             NOT NULL           
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
	NumberOfSeats           INT             NOT NULL,
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
	GradeID                 INT             NOT NULL        REFERENCES Grades(GradeID)
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