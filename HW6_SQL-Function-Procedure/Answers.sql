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

-- Question 4 (Assumption: we are checking the total amount spent by a customer and not just of a single order)
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

-- Question 5 (Assumption: we are checking the total stock quantity of a product and not just if the product has any stock)
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
CREATE PROCEDURE AddNewEmployee
    @employee_id INT,
    @first_name VARCHAR(100),
    @last_name VARCHAR(100),
    @base_salary DECIMAL(6, 2),
    @bonus DECIMAL(6, 2),
    @allowance DECIMAL(6, 2),
    @department_id INT
AS
BEGIN
    INSERT INTO Employee (employee_id, first_name, last_name, base_salary, bonus, allowance, department_id)
    VALUES (@employee_id, @first_name, @last_name, @base_salary, @bonus, @allowance, @department_id);
END;
GO

-- Question 7 (Do error handling | Assumption: we are only updating a single product based on the product id)
CREATE PROCEDURE UpdateProductPrice
    @product_id INT,
    @new_price DECIMAL(6, 2)
AS
BEGIN
    UPDATE Product
    SET price = @new_price
    WHERE product_id = @product_id;
END;
GO

-- Question 8 (Assumption: we are archiving orders older than a certain date and deleting the data from the original table)
CREATE PROCEDURE ArchiveOldOrders
    @archive_date DATE
AS
BEGIN
    INSERT INTO order_history (order_id, customer_id, order_date, total_amount)
    SELECT order_id, customer_id, order_date, total_amount
    FROM [Order]
    WHERE order_date < @archive_date;

    DELETE FROM [Order]
    WHERE order_date < @archive_date;
END;
GO

-- Question 9 (Do error handling)
CREATE PROCEDURE ResetCustomerPassword
    @customer_id INT,
    @new_password VARCHAR(100)
AS
BEGIN
    UPDATE Customer
    SET password = @new_password
    WHERE customer_id = @customer_id;
END;
GO

-- Question 10 (Do error handling)
CREATE PROCEDURE DeleteEmployee
    @employee_id INT
AS
BEGIN
    DELETE FROM Employee
    WHERE employee_id = @employee_id;
END;
