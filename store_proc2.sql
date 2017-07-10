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
		
         
		-- check the number of open seats for the course in the CourscheduleTable
