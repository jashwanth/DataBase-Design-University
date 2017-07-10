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