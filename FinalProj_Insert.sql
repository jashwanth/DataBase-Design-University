INSERT INTO Address (Street1, Street2, City, State, ZIP)
	VALUES
		('212 Westcott Street', 'Apt#1', 'Syracuse', 'New York', '13210'),
		('324 Mapple Street', 'Apt#54', 'New York City', 'New York', '12344'),
		('234 Cherry Street', 'Apt#6', 'Rochester', 'New York', '78665'),
		('176 Stevenson Street', 'Apt#2', 'San Diego', 'California', '87665'),
		('786 Maddinson Street', 'Apt#45', 'Chicago', 'Illinois', '90871'),
		('123 Lancaster Avenue', 'Apt#8', 'San Fransisco', 'California', '56752'),
		('456 Wooden Street', 'Apt#12', 'Boulder', 'Colarado', '33455'),
		('324 Artint Street', 'Apt#4', 'Albany', 'New York', '34566'),
		('234 Frantin Street', 'Apt#61', 'Salem', 'Oregon', '89665'),
		('897 Westcott Street', 'Apt#13', 'Syracuse', 'New York', '13210'),
		('432 Mapple Street', 'Apt#4', 'New York City', 'New York', '12344'),
		('987 Cherry Street', 'Apt#16', 'Rochester', 'New York', '78665'),
		('123 Stevenson Street', 'Apt#12', 'San Diego', 'California', '87665'),
		('345 Maddinson Street', 'Apt#5', 'Chicago', 'Illinois', '90871'),
		('908 Lancaster Avenue', 'Apt#18', 'San Fransisco', 'California', '56752'),
		('234 Wooden Street', 'Apt#2', 'Boulder', 'Colarado', '33455'),
		('456 Artint Street', 'Apt#14', 'Albany', 'New York', '34566'),
		('567 Frantin Street', 'Apt#1', 'Salem', 'Oregon', '89665');




INSERT INTO Person (NTID, FirstName, LastName, EmailAddress, Password, SSN, DOB, HomeAddress, LocalAddress, IsActive)
	VALUES
		('678567437', 'Michael', 'Jackson', 'mjackson@syr.edu', 'mjackson123', '324-765-9876', '1994-10-22', 1, 2, 1),
		('987923723', 'Bob', 'Marley', 'bmarley@syr.edu', 'bmarley123', '765-564-8976', '1993-12-7', 4, NULL, 1),
		('232456666', 'Taylor', 'Swift', 'tswift@syr.edu', 'tswift123', '342-876-9876', '1994-8-3', 3, NULL, 1),
		('762490840', 'Britney', 'Spears', 'bspears@syr.edu', 'bspears123', '987-678-3456', '1992-8-12', 5, NULL, 1),
		('988729277', 'Lady', 'Gaga', 'lgaga@syr.edu', 'lgaga123', '456-098-4567', '1991-9-22', 6, NULL, 1),
		('214218899', 'Katy', 'Perry', 'kperry@syr.edu', 'kperry123', '678-345-3456', '1997-4-15', 2, NULL, 1),
		('986522828', 'Bruno', 'Mars', 'bmars@syr.edu', 'bmars123', '456-452-9087', '1993-4-15', 7, NULL, 1),
		('627280027', 'Janet', 'Jackon', 'jjackson@syr.edu', 'kjjackson123', '456-546-3456', '1990-8-18', 8, NULL, 0),
		('234444989', 'Donna', 'Summer', 'dsummer@syr.edu', 'kdsummer123', '987-567-3412', '1992-4-15', 9, NULL, 1),
		('786556682', 'Elvis', 'Presley', 'epresley@syr.edu', 'epresley123', '786-345-1267', '1965-11-22', 1, 2, 1),
		('622890865', 'Mariah', 'Carey', 'mcarley@syr.edu', 'mcarley123', '232-567-9854', '1957-12-7', 4, NULL, 1),
		('908976788', 'Jay', 'Z', 'jayz@syr.edu', 'jayz123', '234-567-1267', '1963-8-3', 3, NULL, 1),
		('898979878', 'Bruce', 'Springsteen', 'bspringstreen@syr.edu', 'bspringstreen123', '567-267-8765', '1959-8-12', 5, NULL, 1),
		('354356679', 'Stevie', 'Wonder', 'swonder@syr.edu', 'swonder123', '165-234-1313', '1971-9-22', 6, NULL, 1),
		('345667889', 'Aretha', 'Franklin', 'afranklin@syr.edu', 'afranklin123', '212-323-6789', '1967-4-15', 2, NULL, 1),
		('988745647', 'Diana', 'Ross', 'dross@syr.edu', 'dross123', '678-323-7544', '1968-4-15', 7, NULL, 1),
		('456788646', 'Billy', 'Joel', 'bjoel@syr.edu', 'bjoel123', '783-341-9876', '1972-8-18', 8, NULL, 0),
		('547687899', 'Bob', 'Dylan', 'bdylan@syr.edu', 'bdylan123', '298-544-981', '1973-4-15', 9, NULL, 1);



INSERT INTO StudentStatus (StudentStatus)
	VALUES
		('Undergraduate'),
		('Graduate'),
		('Non-Matriculated'),
		('Grduated');

INSERT INTO Student (PersonId, StudentStatusId)
	VALUES
		(1,1),
		(2,1),
		(3,1),
		(4,1),
		(5,2),
		(6,2);

INSERT INTO College (CollegeName)
	VALUES
		('Collge of Law'),
		('L.C.Smith Collge of Engineering'),
		('Newhouse School of Public Communications'),
		('Collge of Visual Arts'),
		('Collge of Arts and Sciences'),
		('David B.Falk College of Sports and Human Dynamics');

INSERT INTO Discipline (DisciplineName, CollegeId)
	VALUES
		('BioMedical And Chemical Engineering',2),
		('Civil And Environmental Engineering',2),
		('Electrical Engineering and Computer Science',2),
		('Applied Law Sciences',1),
		('Gymnastics',6),
		('Arts of Eighteenth Century',5);


INSERT INTO StudentDiscipline (StudentId, DisciplineId, IsMajor)
	VALUES
		(1,1,1),
		(1,2,0),
		(2,1,1),
		(2,3,0),
		(3,2,1),
		(3,5,0),
		(4,3,1),
		(5,4,1),
		(6,5,1);

INSERT INTO CourseCatalog (CourseCode, CourseNumber, CourseTitle, CourseDesc)
	VALUES
		('CSE', 235, 'Basic Data Structures', 'Deals with Basic Data Structures and Algoritms'),
		('CSE', 421, 'Computer Architecture', 'Introduction to Computer Architecture'),
		('CSE', 410, 'Operating Systems', 'Deals with Operating Systems'),
		('CSE', 612, 'Advanced Data Structures and Algoritms', 'Deals with advanced topics of Data Structures and Algorithms'),
		('CSE', 643, 'Advanced Computer Architecture', 'Insights into advanced computer architecture concepts'),
		('CSE', 678, 'Advanced Operating Systems', 'Deals with advanced OS Concepts'),
		('EEE', 243, 'Basic Electronics', 'Insights into Basic Electronic Concepts'),
		('EEE', 445, 'Advanced Electronics', 'Deals with Advanced Electronics'),
		('MEC', 345, 'Machines', 'Deals with the functionality of Machines');

INSERT INTO Prerequisites (CoursePrerequisiteId, CourseId)
	VALUES
		(1,4),
		(2,5),
		(3,6),
		(7,8);

INSERT INTO Building (BuildingName)
	VALUES
		('Boland'),
		('Brewster'),
		('Slocum'),
		('SkyHall'),
		('Ernie Davis'),
		('Haven');

INSERT INTO ProjectorStatus (ProjectorStatus)
	VALUES
		('Yes-Basic'),
		('Yes-SmartBoard'),
		('No');

INSERT INTO ClassRoom (BuildingId, RoomNumber, MaxSeating, ProjectorStatus, NumberOfWhiteBoards, OtherAV)
	VALUES
		(1, 'Bol-564', 70, 2, 2, 'Wireless Microphone'),
		(2, 'Brew-342', 120, 2, 3, 'Podium with Microphone'),
		(3, 'Sloc-765', 130, 1, 3, 'Powered Speakers'),
		(4, 'Sky-134', 70, 3, 1, NULL),
		(5, 'Ernie-234', 80, 2, 2,  'Data Projectors'),
		(6, 'Hav-345', 120, 2, 2, 'Powered Speakers'),
		(1, 'Bol-453', 89, 1, 3, 'Podium with Microphone'),
		(2, 'Bre-342', 58, 3, 1, NULL),
		(3, 'Sloc-345', 145, 3, 3, 'Powered Speakers');

INSERT INTO SemesterText (SemesterText)
	VALUES
		('Fall'),
		('Spring'),
		('Summer');

INSERT INTO Semester (Semester, YearOfSemester, FirstDay, LastDay)
	VALUES
		(1, 2016, '2016-08-12', '2016-12-6'),
		(2, 2016, '2016-01-12', '2016-05-16'),
		(1, 2015, '2015-08-06', '2015-12-9'),
		(2, 2015, '2015-01-07', '2015-05-17');

INSERT INTO WeekDayInfo (DayInfo)
	VALUES
		('Monday'),
		('Tuesday'),
		('Wednesday'),
		('Thursday'),
		('Friday'),
		('Saturday'),
		('Sunday');


INSERT INTO CourseSchedule (CourseId, NumberOfSeats, Location, Semester)
	VALUES
		(1, 120, 1, 1),
		(2, 140, 2, 1),
		(3, 85, 3, 1),
		(4, 120, 1, 2),
		(5, 140, 2, 2),
		(6, 85, 3, 2),
		(7, 105, 4, 1),
		(8, 105, 4, 2),
		(9, 110, 6, 1);



INSERT INTO CourseDailySchedule (CourseId, WeekDayInfoId, StartTime, EndTime)
	VALUES
		(1, 1, '08:00', '09:20'),
		(1, 3, '08:00', '09:20'),
		(2, 2, '10:00', '11:20'),
		(2, 4, '10:00', '11:20'),
		(3, 1, '10:00', '11:20'),
		(3, 3, '10:00', '11:20'),
		(4, 3, '12:00', '13:20'),
		(4, 4, '12:00', '13:20'),
		(5, 1, '18:00', '19:20'),
		(5, 3, '18:00', '19:20'),
		(6, 2, '18:00', '19:20'),
		(6, 4, '18:00', '19:20'),
		(7, 5, '08:00', '09:20'),
		(8, 5, '10:00', '11:20'),
		(9, 5, '18:00', '19:20');

INSERT INTO EnrollmentStatus (EnrollmentStatus)
	VALUES
		('Regular'),
		('Audit'),
		('Pass'),
		('Fail');

INSERT INTO Grade (Grade, GradeDescription)
	VALUES
		('O','Outstanding'),
		('E','Exceeds Expectations'),
		('A','Acceptable'),
		('P','Poor'),
		('D','Dreadful'),
		('T','Troll');
		
INSERT INTO StudentEnrollment (CourseScheduleId, StudentId, EnrollmentStatus, GradeId)
	VALUES
		(1, 1, 1, 1),
		(2, 1, 1, 2),
		(3, 1, 1, 1),
		(4, 2, 1, NULL),
		(5, 2, 1, 1),
		(1, 3, 1, NULL),
		(2, 3, 1, 3),
		(6, 2, 1, 4),
		(7, 4, 1, NULL),
		(7, 5, 1, 1),
		(8, 6, 1, 1);

INSERT INTO BenefitSelection (BenefitSelection)
	VALUES
		('Single'),
		('Family'),
		('Op-out');

INSERT INTO Benefits (BenefitSelection, BenefitCost, BenefitDescription)
	VALUES
		(1,75000,'Single-Luxery'),
		(2,175000,'Family-Luxery'),
		(1,30000,'Single-Normal'),
		(2,70000,'Family-Normal'),
		(3,67000,'opout'),
		(1,15000,'Single-Premium');

INSERT INTO JobInformation (JobTitle, JobDescription, JobRequirements, MinPay, MaxPay, UnionJob)
	VALUES
		('Teaching Assistant', 'Helps the Proffesor to manage the Course', 'Graduate Student', '20', '25',1),
		('Research Assistant', 'Helps the Proffesor in his research', 'PhD Student', '25', '35',1),
		('Grader', 'Grades the Assisgnements', 'Graduate Student', '12', '20',1),
		('Junior Professor', 'Less than 5 years of experience', 'PhD', '60', '85',1),
		('Senior Professor', '5 to 15 years of experience', 'PhD and 5 years of experience', '100', '125',0),
		('Senior Most Professor', 'More than 25 years of experience', 'PhD and 25 years of experience', '175', '200',0);

INSERT INTO Employee (PersonId, YearlyPay, HealthBenefits, VisionBenefits, DentalBenefits, JobId)
	VALUES
		(10, 75000, 4, 1, 1, 4),
		(11, 75000, 4, 1, 1, 4),
		(12, 125000, 2, 1, 1, 5),
		(13, 125000, 2, 1, 1, 5),
		(14, 175000, 4, 1, 1, 6),
		(15, 175000, 4, 1, 1, 6),
		(16, 75000, 2, 1, 1, 4),
		(17, 125000, 2, 1, 1, 5),
		(18, 175000, 2, 1, 1, 6),
		(6, 30000, 3, 3, 3, 1),
		(5, 40000, 3, 3, 3, 2),
		(4, 25000, 3, 3, 3, 3);

INSERT INTO CourseInstructor (EmployeeId, CourseScheduleId)
	VALUES
		(1, 1),
		(2, 2),
		(3, 3),
		(4, 4),
		(5,	5),
		(6,	5),
		(7,	7),
		(10,4),
		(11,5),
		(12,6);
