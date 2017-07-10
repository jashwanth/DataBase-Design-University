-- Because of Research grants and Benefits the University 
-- wants to update the yearly pay of the faculty in the
-- university. Increase the Yearly pay of Assistant Professor
-- by 10% and Associate Professor by 20% 
-- Execute the below query to drop the Procedure
-- DROP PROCEDURE dbo.IncreasetheFacultyPay 
-- Return an integer with Success/Failure of Table Updation
-- Excute the Procedure as given below
-- DECLARE @result AS INTEGER 
-- EXEC dbo.IncreasetheFacultyPay @result OUTPUT
-- SELECT @result 

CREATE PROCEDURE dbo.IncreasetheFacultyPay(@output AS INTEGER OUT) 
      AS
	    BEGIN TRAN
	       SET @output = 0
		   DECLARE MyCursor CURSOR FOR 
	       SELECT e.EmployeeID, p.FirstName, p.LastName, e.YearlyPay, e.JobInformation
		   FROM EmployeeInfo e
           INNER JOIN People P ON
           P.PersonID = e.PersonID
           WHERE JobInformation IN (SELECT JobID 
			                             FROM JobInformation
										 WHERE JobTitle IN ('Assistant Professor', 'Associate Professor'))
		   OPEN MyCursor
		   DECLARE @FirstName AS VARCHAR(20)
		   DECLARE @LastName AS VARCHAR(20)
		   DECLARE @EmployeeID AS INTEGER
		   DECLARE @Pay AS INTEGER
		   DECLARE @newPay AS INTEGER
		   DECLARE @JobID AS INTEGER
		   FETCH NEXT FROM MyCursor INTO @EmployeeID, @FirstName, @LastName, @Pay, @JobID
		   WHILE @@FETCH_STATUS = 0
		       BEGIN
			       -- Increase the Pay by 10% for Assistant Professor
			       IF @JobID = 2
				     BEGIN
					     SET @newPay = @Pay * 1.1
					 END
				   -- Increase the Pay by 20% for Associate Professor
				   ELSE
				     BEGIN
					     SET @newPay = @Pay * 1.2
					 END
			       UPDATE EmployeeInfo
				   SET YearlyPay = @newPay
				   WHERE EmployeeID = @EmployeeID
				   IF @@ERROR <> 0
				     BEGIN
					    PRINT 'Error In Updation of Table. Rollback the Transaction'
						 CLOSE MyCursor
                         DEALLOCATE MyCursor
		                 SET @output = 0
						 ROLLBACK TRAN
						 RETURN @output
					 END
			       PRINT 'The pay is updated for the Employee ' + @FirstName + ' ' + @LastName
				         + ' From ' + CAST(@Pay AS VARCHAR(10)) + ' to ' + CAST(@newPay AS VARCHAR(10)) 
				   FETCH NEXT FROM MyCursor INTO @EmployeeID, @FirstName, @LastName, @Pay, @JobID
			   END
		   CLOSE MyCursor
           DEALLOCATE MyCursor
		   SET @output = 1
		COMMIT TRAN
		   RETURN @output