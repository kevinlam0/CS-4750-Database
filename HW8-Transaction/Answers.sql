-- Question 1 Given variables ProductID, Quantity, OrderID, Amount, UserID, write a transaction which will cover following steps
BEGIN TRANSACTION

DECLARE @ProductId INT;
DECLARE @Quantity INT;
DECLARE @OrderId INT;
DECLARE @Amount DECIMAL(10, 2);
DECLARE @UserId INT;
-- Part 1
UPDATE Inventory
SET Quantity = Quantity - @Quantity
WHERE ProductID = @ProductId;

IF @@ROWCOUNT = 0
BEGIN
    ROLLBACK;
    PRINT 'Inventory update failed: ProductID not found or insufficient quantity.';
    RETURN;
END

-- Part 2
INSERT INTO Payments (OrderID, UserID, Amount, PaymentStatus, PaymentDate) 
VALUES (@OrderId, @UserId, @Amount, 'Pending', GETDATE());

IF @@ROWCOUNT = 0
BEGIN
    ROLLBACK;
    PRINT 'Payment insertion failed.';
    RETURN;
END

-- Part 3
INSERT INTO Orders (OrderID, UserID, ProductID, Quantity, OrderDate, OrderStatus) 
VALUES (@OrderId, @UserId, @ProductId, @Quantity, GETDATE(), 'Confirmed');

IF @@ROWCOUNT = 0
BEGIN
    ROLLBACK;
    PRINT 'Order insertion failed.';
    RETURN;
END

COMMIT;

-- Question 2
