-- Create the Inventory table
CREATE TABLE Inventory (
    ProductID INT PRIMARY KEY,
    Quantity INT NOT NULL CHECK (Quantity >= 0) -- Ensures quantity is non-negative
);

-- Create the Orders table
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY, -- Unique identifier for each order
    UserID INT NOT NULL, -- User placing the order
    ProductID INT NOT NULL, -- Product being ordered
    Quantity INT NOT NULL CHECK (Quantity > 0), -- Ensures positive quantity
    OrderDate DATETIME NOT NULL,
    OrderStatus VARCHAR(9) CHECK(OrderStatus IN ('Confirmed', 'Canceled')) NOT NULL, -- Restricted to specific values
    FOREIGN KEY (ProductID) REFERENCES Inventory(ProductID) ON DELETE CASCADE
);

-- Create the Payments table
CREATE TABLE Payments (
    PaymentID INT PRIMARY KEY,
    OrderID INT NOT NULL,
    UserID INT NOT NULL,
    Amount DECIMAL(10, 2) NOT NULL CHECK (Amount >= 0),
    PaymentStatus VARCHAR(9) CHECK(PaymentStatus IN ('Pending', 'Completed', 'Failed')) NOT NULL,
    PaymentDate DATETIME NOT NULL,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID) ON DELETE CASCADE
);