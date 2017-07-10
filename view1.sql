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


