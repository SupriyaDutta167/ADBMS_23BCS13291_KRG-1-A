--EXP 3
--Q1 (Easy level)

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

--Q2 (medium level)
CREATE TABLE department (
    id INT PRIMARY KEY,
    dept_name VARCHAR(50)
);

-- Create Employee Table
CREATE TABLE employeee (
    id INT,
    name VARCHAR(50),
    salary INT,
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES department(id)
);

-- Insert into Department Table
INSERT INTO department (id, dept_name) VALUES
(1, 'IT'),
(2, 'SALES');

-- Insert into Employee Table
INSERT INTO employeee (id, name, salary, department_id) VALUES
(1, 'JOE', 70000, 1),
(2, 'JIM', 90000, 1),
(3, 'HENRY', 80000, 2),
(4, 'SAM', 60000, 2),
(5, 'MAX', 90000, 1);

--max salary dept wise

--approach 1:
SELECT d.dept_name, e.name, e.salary
FROM employeee e
JOIN 
department d 
ON 
e.department_id = d.id
WHERE e.salary = (
    SELECT MAX(salary)
    FROM employeee
    WHERE department_id = e.department_id
);

--approach 2
SELECT d.dept_name, e.name, e.salary, d.id
FROM employeee as e
inner JOIN 
department as d 
ON 
e.department_id = d.id
WHERE e.salary in (
    SELECT MAX(E2.salary)
    FROM Employeee as E2
    group by E2.department_id
);



--q3(hard level)

create table TableA(
    Emp_id int,
    Ename varchar(50),
    salary int
)
create table TableB(
    Emp_id int,
    Ename varchar(50),
    salary int
)

INSERT into TableA(Emp_id, Ename, salary) values
(1, 'AA', 1000),
(2, 'BB', 300);

INSERT into TableB(Emp_id, Ename, salary) values
(2, 'BB', 400),
(3, 'CC', 100);

--return each empid with their lowest salary and corrsponding ename

select Emp_id ,Ename, min(salary) as min_salary
from
(
    select emp_id, ename, salary from TableA
    union all
    select emp_id, ename, salary from TableB
) 
TableA
group by
Emp_id, Ename;
