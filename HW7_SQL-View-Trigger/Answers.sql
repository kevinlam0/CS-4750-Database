-- Question 1
CREATE VIEW ListTotalSales AS
SELECT p.product_id, p.product_name, SUM(o.quantity * p.price) AS total_sales
FROM Product p
INNER JOIN Orders o ON p.product_id = o.product_id
GROUP BY p.product_id, p.product_name;
GO

-- Question 2
CREATE VIEW TotalNumberProductsPerCategory AS
SELECT c.category_id, c.category_name, SUM(ISNULL(o.quantity, 0)) AS total_number
FROM Category c
LEFT OUTER JOIN Product p ON p.category_id = c.category_id
LEFT OUTER JOIN Orders o ON o.product_id = p.product_id
GROUP BY c.category_id, c.category_name;
GO

-- Question 3
CREATE TRIGGER UpdateNewPrice
ON Product
AFTER UPDATE
AS
BEGIN
    IF (UPDATE (price))
    BEGIN
        INSERT INTO PriceHistory (product_id, old_price, new_price, change_date)
        SELECT 
            i.product_id,
            d.price AS old_price,
            i.price AS new_price,
            GETDATE() AS change_date
        FROM inserted i
        JOIN deleted d ON d.product_id = i.product_id
        WHERE i.price <> d.price;
    END;
END;

-- Question 4
SELECT p.product_name, SUM(o.quantity) AS total_number_sold, SUM(o.quantity * p.price) AS total_revenue
FROM Product p
LEFT JOIN Orders o ON o.product_id = p.product_id
GROUP BY p.product_name
ORDER BY total_revenue DESC;