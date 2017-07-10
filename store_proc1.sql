-- change the course schedule of a course for ease of instructor 
-- which involves changing the start and end time of the course, dayofweek ofschedule.
-- Execute the below Query to drop the procedure
-- DROP PROCEDURE dbo.ChangeCourseScheduleTimings
-- Execute the Code with the below Qeury
-- This query has start tme less than end time hence is a failure
-- EXEC dbo.ChangeCourseScheduleTimings '1', '1', '09:00:00', '08:30:00' ,'3'
-- EXEC dbo.ChangeCourseScheduleTimings '1', '1', '08:30:00', '09:40:00' ,'4'
CREATE PROCEDURE dbo.ChangeCourseScheduleTimings(@EmployeeID AS INTEGER, @CourseScheduleID AS INTEGER,
                                                 @StartTime AS TIME, @EndTime AS TIME, @DayOfWeek AS INTEGER)
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