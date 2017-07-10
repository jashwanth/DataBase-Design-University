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