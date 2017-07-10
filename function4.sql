-- Return a Table which contains the Undergraduate and
-- Graduate students and number of credits completed. Assume
-- Each course is of 3 credits . Count the Credit Completion
-- only on passed courses.
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