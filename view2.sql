-- create a view to get all the students , their areas of study Concentration,
-- college under which they study or affliated to, Major or Minor Status, and their studentstatus
-- Run the below Query to drop the view
-- DROP VIEW StudentAreaOfConcentrationAndStatusInfo
-- Run the below Statement to Check the output
-- SELECT * FROM StudentAreaOfConcentrationAndStatusInfo

CREATE VIEW StudentAreaOfConcentrationAndStatusInfo AS
      SELECT p.FirstName, p.LastName, ss.StudentStatus, Aos.StudyTitle, sas.IsMajor, c.CollegeName
          FROM StudentInfo si,StudentStatus ss, StudentAreaOfStudy sas,
		       AreaOfStudy Aos, College c, People p
          WHERE si.PersonID = p.PersonID AND
                si.StudentStatusID = ss.StudentStatusID AND 
				sas.StudentID = si.StudentID AND
				sas.AreaID = Aos.AreaOfStudyID AND
                Aos.CollegeID = c.CollegeID 
