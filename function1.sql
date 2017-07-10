--Return top 5 Employees names who have enrolled in highest cost benefit plans.
-- DROP FUNCTION dbo.FindEmployeeWithMaxBenefitCostEnrollment
-- SELECT * FROM dbo.FindEmployeeWithMaxBenefitCostEnrollment()
CREATE FUNCTION dbo.FindEmployeeWithMaxBenefitCostEnrollment()
       RETURNS @EmployeeTotalbenefitcost TABLE 
	           (FirstName VARCHAR(20), LastName VARCHAR(20),HealthBenefit INTEGER,
			    VisionBenefitCost  INTEGER, DentalBenefit INTEGER, TotalCost INTEGER)
       BEGIN
	      INSERT INTO @EmployeeTotalbenefitcost
		  SELECT p.FirstName, p.LastName, b1.BenefitCost, b2.BenefitCost, b3.BenefitCost , (b1.BenefitCost+b2.BenefitCost+b3.BenefitCost) AS Cost
		  --SELECT  (b1.BenefitCost+b2.BenefitCost+b3.BenefitCost) AS Cost
		     FROM EmployeeInfo e 
			 INNER JOIN People p ON
			 e.PersonID = p.PersonID
			 INNER JOIN Benefits b1 ON
			 b1.BenefitID = e.HealthBenefits
			 INNER JOIN Benefits b2 ON
			 b2.BenefitID = e.VisionBenefits
			 INNER JOIN Benefits b3 ON
			 b3.BenefitID = e.DentalBenefits
--			 ORDER BY b1.BenefitCost+b2.BenefitCost+b3.BenefitCost DESC
--           ORDER BY Cost DESC
--			 GROUP BY p.FirstName,p.LastName, b1.BenefitCost, b2.BenefitCost, b3.BenefitCost
			 --GROUP BY b1.BenefitCost+b2.BenefitCost+b3.BenefitCost
			 ORDER BY Cost DESC
	      RETURN 
       END;