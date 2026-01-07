CREATE DATABASE SQL_Practice;
GO

USE SQL_Practice;
GO

CREATE TABLE departments (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(50)
);

CREATE TABLE employees(
      emp_id INT PRIMARY KEY,
	  emp_name VARCHAR(50),
	  dept_id INT,
	  salary INT,
	  city VARCHAR(50),
	  join_date DATE,
	  FOREIGN KEY (dept_id) REFERENCES departments(dept_id)
	  );

CREATE TABLE sales(
    sale_id INT PRIMARY KEY,
	emp_id INT,
	sale_amount INT,
	sale_date DATE,
	FOREIGN KEY (emp_id)REFERENCES employees(emp_id)
	);

INSERT INTO departments (dept_id, dept_name) VALUES
(10, 'IT'),
(20, 'HR'),
(30, 'Finance');


INSERT INTO employees (emp_id, emp_name, dept_id, salary, city, join_date) VALUES
(1, 'Rahul', 10, 50000, 'Indore', '2021-01-10'),
(2, 'Ankit', 20, 60000, 'Pune', '2020-03-15'),
(3, 'Neha', 10, 55000, 'Indore', '2022-06-01'),
(4, 'Priya', 30, 70000, 'Bangalore', '2019-09-20'),
(5, 'Rohan', 20, 45000, 'Pune', '2021-12-05'),
(6, 'Amit', 10, 40000, 'Indore', '2023-01-01'),
(7, 'Sneha', 30, 80000, 'Bangalore', '2018-04-12'),
(8, 'Karan', 20, 65000, 'Mumbai', '2020-11-30');



INSERT INTO sales (sale_id, emp_id, sale_amount, sale_date) VALUES
(101, 1, 20000, '2023-01-10'),
(102, 2, 15000, '2023-01-12'),
(103, 1, 30000, '2023-02-01'),
(104, 4, 50000, '2023-02-15'),
(105, 7, 60000, '2023-03-01'),
(106, 3, 25000, '2023-03-10'),
(107, 8, 40000, '2023-03-20');


SELECT * FROM departments;
SELECT * FROM employees;
SELECT * FROM sales;




-- Q1 Write a query to display all employees from the employees table.
select * 
from employees

--Q2 Find employees who work in Indore city.
select * 
from employees
where city='Indore'

--Q3  Display emp_name and salary of employees whose salary is greater than 55,000.
select emp_name ,salary 
From employees
where salary >55000

--Q4 Find employees who joined after 1st Jan 2021.
SELECT *
FROM employees
WHERE join_date >'2021-01-01'

--Q5 Display employees who belong to HR department (dept_id = 20).
SELECT * 
FROM employees
where dept_id=20

--Q6 Find the average salary of each department.
select dept_id ,avg(salary) as avg_salary
from employees
group by dept_id

--Q7 Find the number of employees in each city.
select city,count(emp_id)
from employees
group by city

--Q8 Find the maximum salary in each department.
select dept_id, max(salary)
from employees
group by dept_id

--Q9 Find the total salary paid in each department.
select dept_id ,sum(salary) as total_salary
from employees
group by dept_id

--Q10 Find the count of employees in each department.
select dept_id, count(emp_id)
from employees
group by dept_id

--HAVING (Q11–Q15)
--Q11  Find departments where average salary is greater than 55,000.
select dept_id , avg(salary) as avg_salary
from employees
group by dept_id
having avg(salary) > 55000

--Q12 Find cities where more than 2 employees work.
select city , count(emp_id) as total_employ
from employees
group by city
having count(emp_id)>2

--Q13 Find departments where total salary is more than 1,00,000.
select dept_id , sum(salary) as total_salary
from employees
group by dept_id
having sum(salary)>100000

--Q14 Find departments having at least 2 employees.
select dept_id, count(emp_id) as total_employ
from employees
group by dept_id
having count(emp_id)>=2

--Q15 Find cities where average salary is less than 60,000.
select city ,avg(salary) as avg_salary
from employees
group by city
having avg(salary) <60000

--ORDER BY (Q16–Q20)
--Q16 Display employees ordered by salary (highest to lowest).
select * 
from employees
order by salary desc

--Q17 Display employees ordered by join_date (oldest first).
select * 
from employees
order by join_date 

--Q18 Find employees from Indore, ordered by salary descending.
select * 
from employees
where city= 'indore'
order by salary desc

--Q19 Find departments ordered by average salary (highest first).
select dept_id , avg(salary) as avg_salary
from employees
group by dept_id
order by avg_salary desc
 
--Q20 Find departments where average salary > 50,000,
--and display them ordered by average salary descending.
select dept_id , avg(salary) as avg_salary
from employees
group by dept_id
having avg(salary) >50000
order by avg_salary desc


--1: JOIN QUESTIONS
--Q1 Display employee name and department name for all employees.
select e. emp_name , d.dept_name
from employees e
inner join 
departments d
on (e.dept_id=d.dept_id)

--Q2 Display employee name, department name, and salary.
select e.emp_name ,e.salary,d.dept_name
from employees e
inner join 
departments d
on (e.dept_id=d.dept_id)

--Q3 Find employees who do not belong to any department.
select e.* ,d.dept_name
from employees e
left join 
departments d
on(e.dept_id=d.dept_id)

--Q4 Display department name and number of employees in each department.
select d.dept_name,count(e.emp_id) as total_employ 
from employees e
inner join
departments d
on (e.dept_id=d.dept_id)
group by d.dept_name

--Q5 Display all departments, even those with no employees.
select d.dept_name,e.* 
from employees e
left join
departments d
on (e.dept_id=d.dept_id)

--Q6 Find employees along with their total sales amount.
select e.emp_id ,e.emp_name,sum(s.sale_amount )
from employees e
inner join
sales s
on (e.emp_id=s.emp_id)
group by e.emp_id,emp_name

--Q7 Display employee name and sales amount.
--Include employees who have not made any sales.
select e.emp_name,s.sale_amount
from employees e 
left join 
sales s
on (e.emp_id=s.emp_id)

-- Q8 Find departments where no employees are working.
select d.dept_name ,e.emp_name 
from employees e
left join
departments d
on (e.dept_id=d.dept_id)


--PART 2: SUBQUERY QUESTIONS 
--Q9 Find employees whose salary is greater than the average salary.
SELECT  * 
from employees 
where salary >(select avg(salary) from employees)

--Q10 Find employees who earn maximum salary in their department.
SELECT emp_id, emp_name, dept_id, salary
FROM employees e
WHERE salary = (
    SELECT MAX(salary)
    FROM employees
    WHERE dept_id = e.dept_id
);

--Q11Find employees who never made any sales.
select e.emp_name ,s.sale_amount
FROM employees e
left join 
sales s 
on (e.emp_id=s.emp_id)
where s.sale_amount is null


--Q12 Find the second highest salary from the employees table.
select  max(salary)  from employees
WHERE salary <(select MAX(salary)  from employees)




--Q12 Find the second highest salary from the employees table.
select top(1)salary ,emp_name from employees

--Q13 Find departments where average salary is greater than overall average salary.
SELECT dept_id
FROM employees
GROUP BY dept_id
HAVING AVG(salary) > (
    SELECT AVG(salary)
    FROM employees
);


--PART 3: CASE WHEN QUESTIONS 
--Q14 Display employee name, salary, and salary category:
-- High → salary ≥ 70,000
-- Medium → salary between 50,000 and 69,999
-- Low → salary < 50,000
SELECT emp_name, salary ,
 case
   when salary>=70000 then 'High'
   when salary  between 50000 and 69999 then 'Medium'
   else 'low'
  end as salary_category
from employees


--Q15 Display employee name and a column:
 -- Experienced → joined before 2021
 -- Fresher → joined in or after 2021
 select emp_name ,salary,join_date,
 case 
    when join_date <'2021' then 'Experienced'
	else 'Fresher'
	end as expreiance_of_employ
from employees


--Q16 Display employee name and bonus eligibility:
-- Eligible → salary ≥ 60,000
-- Not Eligible → otherwise
select emp_name ,
case 
   when salary >60000 then 'Eligible'
   else 'Not Eligible'
   end as bonus_eligibility
from employees

--Q17 Display department name and a column:
-- Large Team → employee count ≥ 3
-- Small Team → otherwise
select d.dept_name ,count(e.emp_id) as emp_count,
case 
  when COUNT(e.emp_id) >=3  then 'Large'
  else 'small team'
 end as team_size
from employees e
inner join 
departments d
on (e.dept_id=d.dept_id)
group by d.dept_name

--Q18  Display employee name, total sales, and sales performance:
-- Excellent → total sales ≥ 50,000
-- Good → 30,000–49,999
-- Poor → < 30,000
   
select  e.emp_name , sum(s.sale_amount) as total_salary,
case
   when sum(s.sale_amount) >=50000 then 'Excellent'
   when sum(s.sale_amount)  between 30000 and 49999 then 'Good'
   else 'Poor'
   end as perfomance 
from employees e
inner join 
sales s
on (e.emp_id=s.emp_id)
group by emp_name


--Q19 Display employee name and department name.
--If department is NULL, show "Not Assigned".
select e.emp_name ,
case 
   when d.dept_name is null then 'Not assigned'
   else d.dept_name
end as dept_name
from employees e
left join 
departments d
on (e.dept_id=d.dept_id)

--Q20 Display employee name, salary, and:
-- Above Avg → salary > department average
-- Below Avg → otherwise   
select emp_name,salary,
case 
   when salary >
(select avg(salary) from employees e2
where e2.dept_id=e1.dept_id) then 'Above avg'
else 'below avg'
end as avg_col
from employees e1;

--Q1 Assign a row number to each employee based on salary (highest first).

select * ,
row_number() over(order by salary desc) as row_number
from employees

--Q2 Assign row numbers department-wise based on salary (highest first).
select * ,
ROW_NUMBER()over(partition by dept_id order by salary desc) as dept_number
from employees

--Q3 Find the highest-paid employee in each department
select *
from (select *,
DENSE_RANK() over(partition by dept_id order by salary desc) as rn
from employees
)t
where rn=1

--Q4 Find the latest joined employee in each department.
select *
from (
select *,
DENSE_RANK()over (partition by dept_id order by join_date desc)as jd
from employees ) t
where jd=1


--Q5 Remove duplicate salaries and keep only one row per salary.
select *
from (select *,
row_number() over (partition by salary order by emp_id) rn
from employees)t
where rn=1

--PART 2: RANK vs DENSE_RANK 
--Q6 Rank employees based on salary (highest first).
select *,
DENSE_RANK() over (order by salary desc) as rnk
from employees

--Q7 Rank employees within each department based on salary.
select *,
dense_rank()over(partition by dept_id order by salary desc) as rnk
from employees

--Q8 Find employees who have the 2nd highest salary overall
select *
from (select *,
     DENSE_RANK()over(order by salary desc) as rnk
	 from employees)t
where rnk =2

--Q9 Find employees who have the 2nd highest salary in each department.
select *
from (select *,
    DENSE_RANK()over(partition by dept_id order by salary desc) rnk
    from employees)t
where rnk=2

--Q10 (VERY IMPORTANT ⭐)
--Show the difference between RANK() and DENSE_RANK() on salary.
select *,
ROW_NUMBER()over(order by salary desc) ron,
dense_rank()over(order by salary desc)rnk
from employees


--PART 3: PARTITION BY (Q11–Q15)
--Q11 Show employee name, salary, and department average salary.
select emp_name ,salary,
AVG(salary) OVER (PARTITION BY dept_id) AS dept_avg_salary
from employees	

--Q12 Show employee name, salary, and salary difference from department average.
  select emp_name,salary,
  salary- avg( salary) over (partition by dept_id) as salary_diff
  from employees

--Q13 Find employees whose salary is above their department average.
select emp_name, salary ,dept_id
from (
     select 
	 emp_name,salary ,dept_id,
	 avg(salary)over (partition by dept_id) as dept_avg_salary
	from employees)t
where salary >dept_avg_salary

--Q14 Show employee name and total sales done by that employee
select distinct e.emp_name,
                sum(s.sale_amount)over (partition by e.emp_id)as total_sales
from employees e
left join
sales s 
on e.emp_id=s.emp_id

--Q15 For each department, show:
--employee name ,salary
-- rank within department
-- department average salary

select emp_name,salary,
DENSE_RANK() over (partition by dept_id order by salary desc)as dept_rank,
avg(salary)over (partition by dept_id)as dept_avg_salary
from employees




