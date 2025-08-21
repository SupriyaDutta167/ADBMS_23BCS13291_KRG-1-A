
CREATE TABLE Employee(
	EMP_ID INT
)

INSERT into Employee(EMP_ID) values (2)
INSERT into Employee(EMP_ID) values (4)
INSERT into Employee(EMP_ID) values (4)
INSERT into Employee(EMP_ID) values (6)
INSERT into Employee(EMP_ID) values (6)
INSERT into Employee(EMP_ID) values (7)
INSERT into Employee(EMP_ID) values (8)
INSERT into Employee(EMP_ID) values (8)

-- return the max empid exlcuding the duplicates using subqueries e.g in this case 7

SELECT Max(EMP_ID) from Employee
where EMP_ID IN
(
	select EMP_ID from Employee
	group by EMP_ID
	having count(*)=1
)

--Q2
CREATE TABLE TBL_PRODUCTS
(
	ID INT PRIMARY KEY IDENTITY,
	[NAME] NVARCHAR(50),
	[DESCRIPTION] NVARCHAR(250) 
)

CREATE TABLE TBL_PRODUCTSALES
(
	ID INT PRIMARY KEY IDENTITY,
	PRODUCTID INT FOREIGN KEY REFERENCES TBL_PRODUCTS(ID),
	UNITPRICE INT,
	QUALTITYSOLD INT
)

INSERT INTO TBL_PRODUCTS VALUES ('TV','52 INCH BLACK COLOR LCD TV')
INSERT INTO TBL_PRODUCTS VALUES ('LAPTOP','VERY THIIN BLACK COLOR ACER LAPTOP')
INSERT INTO TBL_PRODUCTS VALUES ('DESKTOP','HP HIGH PERFORMANCE DESKTOP')


INSERT INTO TBL_PRODUCTSALES VALUES (3,450,5)
INSERT INTO TBL_PRODUCTSALES VALUES (2,250,7)
INSERT INTO TBL_PRODUCTSALES VALUES (3,450,4)
INSERT INTO TBL_PRODUCTSALES VALUES (3,450,9)


SELECT *FROM TBL_PRODUCTS
SELECT *FROM TBL_PRODUCTSALES

--Task : Find the id , name , description of product which has not been sold for once
--output: id, name, description

SELECT p.ID, p.NAME, p.DESCRIPTION
FROM TBL_PRODUCTS p
WHERE p.ID NOT IN (
    SELECT PRODUCTID
    FROM TBL_PRODUCTSALES
);

--Task 2: Find the total quantity sold for w=each respective products
--output: name Qty_Sold(SUM)
--You will use subquery in select clause

SELECT 
    p.NAME,
    (
        SELECT SUM(s.QUALTITYSOLD)
        FROM 
		TBL_PRODUCTSALES s
        WHERE 
		s.PRODUCTID = p.ID
    ) AS QTY_SOLD
FROM TBL_PRODUCTS p;




