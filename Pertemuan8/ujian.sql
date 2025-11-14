CREATE DATABASE DB_MARKETJKT
go;

/*creata table categories, products, customers, orders, orderdetails*/
CREATE TABLE Categories (
	categoryID INT PRIMARY KEY IDENTITY (1,1),
	categoryName VARCHAR (50) NOT NULL
);

CREATE TABLE Products (
	productID INT PRIMARY KEY IDENTITY (1,1),
	productName VARCHAR (100) NOT NULL,
	price DECIMAL (10,2) NOT NULL,
	stock INT DEFAULT 100,
	categoryID INT FOREIGN KEY REFERENCES Categories(categoryID)
);

CREATE TABLE Customers (
	customerID INT PRIMARY KEY IDENTITY (1,1),
	fullName VARCHAR (100) NOT NULL,
	no_HP VARCHAR (15) UNIQUE NOT NULL,
);

CREATE TABLE Orders (
	orderID INT PRIMARY KEY IDENTITY (1,1),
	orderDate DATE,
	total DECIMAL (10,2),
	customerID INT FOREIGN KEY REFERENCES Customers(customerID)
);

CREATE TABLE OrderDetails (
	orderDetailID INT PRIMARY KEY IDENTITY (1,1),
	quantity INT,
	productPrice DECIMAL (10,2),
	orderID INT FOREIGN KEY REFERENCES Orders(orderID),
	productID INT FOREIGN KEY REFERENCES Products(productID)
);

/*Insert sample data into tables*/
INSERT INTO Categories (categoryName) VALUES
('Elektronik'),   
('Pakaian'),
('Makanan & Minuman'),
('Aksesoris');

INSERT INTO Customers (fullName, no_HP) VALUES
('Ahmad Rizky', '081234567890'),
('Citra Dewi', '087812345678'), 
('Eko Prasetyo', '085798765432'), 
('Fitriani', '081355554444'), 
('Gani Hartono', '089622228888'), 
('Hana Wijaya', '082177770000'), 
('Ivan Darmawan', '085211119999'), 
('Julia Sari', '081960603030'), 
('Kemal Syahputra', '087745671234'), 
('Linda Olivia', '081180802020');

INSERT INTO Products (CategoryID, productName, Price, stock) VALUES
(1, 'Kamera', 12500000.00, 5),   
(1, 'Kabel Data Charger', 55000.00, 250),
(2, 'T-Shirt Hitam', 110000.00, 120), 
(2, 'Celana Jeans', 390000.00, 45),
(3, 'Cokelat', 35000.00, 24),        
(3, 'Kopi', 120000.00, 80),
(4, 'Lampu Meja', 225000.00, 15),
(4, 'Lemari', 4000000.00, 3), 
(1, 'Power Bank', 185000.00, 60),
(3, 'Air Mineral Dus', 21000.00, 100),    
(2, 'Kemeja Polos', 210000.00, 18),
(4, 'Koyo Cabe', 25000.00, 50),
(1, 'Monitor PC 24', 2500000.00, 10),
(3, 'Teh Hijau Celup (Box)', 45000.00, 70),
(4, 'Mouse Pad Gaming XXL', 95000.00, 10),
(4, 'Kondom', 50000.00, 50);

INSERT INTO Orders (customerID, orderDate, Total) VALUES
(1, '2023-11-10', 1100000.00), 
(2, '2023-11-11', 280000.00),  
(3, '2023-11-12', 12500000.00),
(4, '2023-11-12', 190000.00),  
(5, '2023-11-13', 430000.00);

INSERT INTO OrderDetails (orderID, productID, Quantity, productPrice) VALUES
(1, 3, 10, 110000.00),  
(2, 10, 40, 7000.00),   
(2, 6, 1, 120000.00),   
(3, 1, 1, 12500000.00), 
(4, 9, 1, 95000.00), 
(4, 15, 1, 95000.00), 
(5, 12, 2, 25000.00),
(5, 7, 1, 225000.00),
(5, 4, 1, 390000.00);


/*Create a stored procedure to process transactions*/
CREATE PROCEDURE SP_Proccess_Trans

@customerID INT,
@productID INT,
@quantity INT,
@productPrice DECIMAL (10,2)

AS
BEGIN
	/*Deklarasi variable */
	DECLARE @NewOrderID INT;
	DECLARE @CurrentStock INT;
	DECLARE @Total DECIMAL (10,2)

	/*buat total transaksi*/
	SET @Total = @quantity * @productPrice;

	/*cek stok dengan IF ELSE */
	SELECT 
		@CurrentStock = stock
	FROM Products
	WHERE productID = @productID;

	/* blok IF ELSE disini */
	IF @CurrentStock >= @quantity
	BEGIN
		/*insert ke table Orders*/
		INSERT INTO Orders (customerID, orderDate, total)
		VALUES (@customerID, GETDATE(), @total);

		SET @NewOrderID = SCOPE_IDENTITY();

		/*Insert ke table OrderDetails*/
		INSERT INTO OrderDetails (orderID, productID, quantity, productPrice)
		VALUES (@NewOrderID, @productID, @quantity, @productPrice);

		UPDATE Products
		SET stock = stock - @quantity
		WHERE productID = @productID;

		/*output dengan 3 field (NewOrderID, Result dan Status Transaksi*/
		SELECT
			@NewOrderID AS NewOrderID,
			'SUCCESS' AS Result,
			CASE
				WHEN @CurrentStock - @quantity = 0 THEN 'Stok habis abis pembelian'
				WHEN @CurrentStock - @quantity <= 5 THEN 'Tinggal sedikit, butuh stock baru'
				ELSE 'Transaksi berhasil'
			END AS TransactionStatus;
		END
		ELSE
		BEGIN
			
			SELECT
				NULL AS NewOrderID,
				'FAILED' AS Result,
				'Stok abis' + CAST(@productID AS VARCHAR)  AS TransactionStatus;
		END
	END

/*Create a trigger to check stock before inserting into OrderDetails*/
CREATE TRIGGER TR_CheckStock
ON OrderDetails
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;
    IF EXISTS (
        SELECT 1
        FROM inserted I
        JOIN Products P ON I.productID = P.productID
        WHERE P.stock < I.quantity
    )
    BEGIN
        RAISERROR('Stok Product Kurang', 16,1);
    END
    
    UPDATE P
    SET stock = P.stock - I.quantity
    FROM Products P
    JOIN inserted I ON P.ProductID = I.productID
    WHERE P.stock >= I.quantity
END

/*Create a view to show best selling products based on quantity sold*/
CREATE VIEW VW_best_selling_product AS
SELECT
	p.productName,
	categoryName,
	SUM(quantity) AS TotalQuantity,
	SUM(quantity * productPrice) AS Total
	FROM Products P
	INNER JOIN OrderDetails OD ON P.productID = OD.productID
	INNER JOIN Categories C ON P.categoryID = C.categoryID
	GROUP BY
	P.productName,
	C.categoryName
go

SELECT 
    * FROM 
    VW_best_selling_product
ORDER BY
TotalQuantity DESC;

/*Report a view to show daily sales report*/
SELECT
    O.OrderDate,
    SUM(O.orderID) AS TotalOrder,
    SUM(O.customerID) AS TotalCustomer,
    SUM(OD.quantity) AS TotalSold,
    SUM(OD.quantity * OD.productPrice) AS TotalRevenue
FROM
    Orders O
INNER JOIN OrderDetails OD ON O.orderID = OD.orderID
INNER JOIN Customers C ON O.customerID = C.customerID
GROUP BY
    O.orderDate
ORDER BY
    O.orderDate DESC;

/*backup database to local disk*/
BACKUP DATABASE DB_MARKETJKT
TO DISK = 'C:\BackupLocal\DB_MARKETJKT.bak'
WITH FORMAT,
     MEDIANAME = 'BackupDB_MARKETJKT',
     NAME = 'Full Backup of DB_MARKETJKT';

/*restore database from backup file*/
RESTORE DATABASE DB_MARKETJKT_Restore
FROM DISK = 'C:\BackupLocal\DB_MARKETJKT.bak'
WITH MOVE 'DB_MARKETJKT' TO 'C:\SQLData\DB_MARKETJKT_Restore.mdf',
     MOVE 'DB_MARKETJKT_log' TO 'C:\SQLData\DB_MARKETJKT_Restore.ldf';
