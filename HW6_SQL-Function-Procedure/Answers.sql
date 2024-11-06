-- Question 1
CREATE FUNCTION dbo.CalculateTotalSalary (@employee_id INT)
RETURNS DECIMAL(10, 2)
AS
BEGIN
    DECLARE @TotalSalary DECIMAL(10, 2)
    SELECT @TotalSalary = base_salary + bonus + allowance
    FROM Employee
    WHERE employee_id = @employee_id;

    RETURN @TotalSalary;
END;
GO

-- Question 2
CREATE FUNCTION dbo.ValidateProduct (@product_id INT)
RETURNS INT
AS
BEGIN
    IF EXISTS (SELECT 1 FROM Product WHERE product_id = @product_id)
        RETURN 1;
    
    RETURN 0;
END;
GO

-- Question 3
CREATE FUNCTION dbo.GetAverageProductRating (@product_id INT)
RETURNS DECIMAL(6, 2)
AS
BEGIN
    DECLARE @AverageRating DECIMAL(6, 2)
    SELECT @AverageRating = AVG(rating)
    FROM Review
    WHERE product_id = @product_id
    RETURN @AverageRating;
END;
GO

-- Question 4
CREATE FUNCTION dbo.CheckDiscountEligibility (@customer_id INT)
RETURNS INT
AS
BEGIN
    DECLARE @TotalAmount DECIMAL(10, 2)
    SELECT @TotalAmount = SUM(total_amount)
    FROM [Order]
    WHERE customer_id = @customer_id

    IF @TotalAmount > 500
        RETURN 1;
    RETURN 0;
END;
GO

-- Question 5
CREATE FUNCTION dbo.CheckProductAvailability (@product_id INT)
RETURNS INT
AS
BEGIN
    DECLARE @TotalStock INT
    SELECT @TotalStock = SUM(stock_quantity)
    FROM Product P
    JOIN Warehouse_stock WS ON WS.product_id = P.product_id
    WHERE P.product_id = @product_id;
    RETURN @TotalStock;
END;
GO

-- Question 6