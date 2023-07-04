SET ANSI_NULLS ON;
SET QUOTED_IDENTIFIER ON;
GO

-- Database: hcu_food

-- Table structure for table 'customers'
CREATE TABLE [customers] (
  [id] int IDENTITY(1,1) NOT NULL,
  [username] varchar(255) NOT NULL,
  [email] varchar(255) NOT NULL,
  [password] varchar(255) NOT NULL,
  [user_type] varchar(10) NOT NULL DEFAULT 'customer',
  [created_at] datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Dumping data for table 'customers'
INSERT INTO [customers] ([username], [email], [password], [user_type], [created_at]) VALUES
('22mcmc34', 'priyanka@gmail.com', '123456', 'admin', '2023-02-13 07:34:00'),
('22mcmc37', 'shivani@gmail.com', '123456', 'admin', '2023-02-13 07:35:48');

-- (rest of the data)

-- Table structure for table 'order'
CREATE TABLE [order] (
  [id] int IDENTITY(1,1) NOT NULL,
  [user_name] varchar(49) NOT NULL,
  [pizza_quantity] int NOT NULL,
  [burger_quantity] int NOT NULL,
  [sandwich_quantity] int NOT NULL,
  [drinks_quantity] int NOT NULL,
  [total_amt] int NOT NULL
);

-- Dumping data for table 'order'
INSERT INTO [order] ([user_name], [pizza_quantity], [burger_quantity], [sandwich_quantity], [drinks_quantity], [total_amt]) VALUES
('22mcmc14', 4, 4, 6, 8, 118),
('22mcmc06', 5, 4, 3, 2, 87);


-- (rest of the data)

-- Indexes for dumped tables

-- Indexes for table 'customers'
ALTER TABLE [customers]
  ADD PRIMARY KEY ([id]);

-- First, update the existing duplicate value to NULL
UPDATE [customers] SET [username] = 'new_username' WHERE [username] = '22mcmc34';

-- Then, add the UNIQUE constraint allowing NULL values
-- Identify the duplicates (if any)
SELECT [username], COUNT(*) as [DuplicateCount]
FROM [customers]
GROUP BY [username]
HAVING COUNT(*) > 1;

-- Once you have identified the duplicates, you can delete them or update them to make them unique.
-- For example, to delete duplicates and keep only one record with the same username:
WITH CTE AS (
    SELECT *,
           ROW_NUMBER() OVER (PARTITION BY [username] ORDER BY [id]) AS [RowNum]
    FROM [customers]
)
DELETE FROM CTE WHERE [RowNum] > 1;

-- Add the UNIQUE constraint to the 'username' column
ALTER TABLE [customers] ADD CONSTRAINT UQ_Username UNIQUE ([username]);



ALTER TABLE [customers]
  ADD UNIQUE ([email]);

-- Indexes for table 'order'
ALTER TABLE [order]
  ADD PRIMARY KEY ([id]);
