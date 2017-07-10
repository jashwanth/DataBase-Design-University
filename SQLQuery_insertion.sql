--Return top 5 Employees names who have enrolled in highest cost benefit plans.
CREATE FUNCTION dbo.FindEmployeeWithMaxBenefitCostEnrollment()
       RETURNS @maxbenefitcost TABLE 
	           (EmployeeID AS INTEGER, BenefitCost  INTEGER)
       BEGIN
	      INSERT INTO @maxbenefitcost
		  SELECT e.
		     FROM EmployeeInfo e 
			 INNER JOIN Benefits b
	      RETURN 
       END;