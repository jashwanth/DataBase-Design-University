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