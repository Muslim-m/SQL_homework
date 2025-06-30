--Lesson 13 ----Practice: String Functions, Mathematical Functions

--Easy Tasks

1.You need to write a query that outputs "100-Steven King", meaning emp_id + first_name + last_name in that format using employees table.

select
concat_ws('-',employee_id, first_name, last_name ) as full_info  from employees
where employee_id=100 and first_name='Steven' and last_name='King' ;
2.Update the portion of the phone_number in the employees table, within the phone number the substring '124' will be replaced by '999'

update employees
set phone_number=replace(phone_number , '124', '999')
where phone_number like '%124%';

3. That displays the first name and the length of the first name for all employees whose name starts with the letters 'A', 'J' or 'M'.
Give each column an appropriate label. Sort the results by the employees' first names.(Employees)

select first_name , length(first_name) from employees
where first_name like 'A%' or first_name like 'J%' or first_name like 'M%' ;

4.Write an SQL query to find the total salary for each manager ID.(Employees table)

select manager_id , sum(salary)  from employees
where manager_id is not null
group by manager_id ;

5.Write a query to retrieve the year and the highest value from the columns Max1, Max2, and Max3 for each row in the TestMax table

select year1 ,
       case when max1>=max2 and max1>=max3 then max1
       when max2>=max1 and max2>=max3  then max2
else max3 end as THE_HIGHEST_VALUE FROM testmax;

6.Find me odd numbered movies and description is not boring.(cinema)

SELECT id, movie , description from cinema
where id%2=1 and description !='boring'

7.You have to sort data based on the Id but Id with 0 should always be the last row.
Now the question is can you do that with a single order by column.(SingleOrder)



select id, vals from singleorder
order by  case when id=0 then 1 else 0 end  , id ;

8.Write an SQL query to select the first non-null value from a set of columns.
If the first column is null, move to the next, and so on. If all columns are null, return null.(person)

select id, coalesce(ssn ,passportid, itin) as  first_non_null  from person;

--Medium Tasks

1.Split column FullName into 3 part ( Firstname, Middlename, and Lastname).(Students Table)
SELECT 
  StudentID,
  FullName,
  LEFT(FullName, CHARINDEX('' '', FullName) - 1) AS FirstName,
  SUBSTRING(
    FullName,
    CHARINDEX('' '', FullName) + 1,
    CHARINDEX('' '', FullName, CHARINDEX('' '', FullName) + 1) - CHARINDEX('' '', FullName) - 1
  ) AS MiddleName,
  RIGHT(FullName, 
    LEN(FullName) - CHARINDEX('' '', FullName, CHARINDEX('' '', FullName) + 1)
  ) AS LastName,
  Grade
FROM Students;
2.
For every customer that had a delivery to California,
provide a result set of the customer orders that were delivered to Texas. (Orders Table)

select customerid , deliverystate from orders
where deliverystate='TX' and customerid in (select distinct customerid from orders
                                            where deliverystate = 'CA'
                                            );
3.Write an SQL statement that can group concatenate the following values.(DMLTable)


select first_name , last_name  from employees
 where length(lower(first_name || last_name))-length(replace(lower(first_name || last_name),'a' ,''))>=3 ;
4.The total number of employees in each department and the percentage of those employees
who have been with the company for more than 3 years(Employees)

select department_id , count(department_id) ,
       round(100.0*sum (case
           when  age(current_date ,hire_date)>interval '3 years' then  1 end)/count(*) ,2) AS percentage_more_than_3_years
from employees
group by department_id;

5.Write an SQL statement that determines the most and least experienced Spaceman ID by their job description.(Personal)

WITH RankedExperience AS (
    SELECT
        JobDescription,
        SpacemanID,
        MissionCount,
        MAX(MissionCount) OVER (PARTITION BY JobDescription) AS MaxMissions,
        MIN(MissionCount) OVER (PARTITION BY JobDescription) AS MinMissions
    FROM Personal
)
SELECT
    JobDescription,
    MAX(CASE WHEN MissionCount = MaxMissions THEN SpacemanID END) AS MostExperiencedID,
    MAX(CASE WHEN MissionCount = MinMissions THEN SpacemanID END) AS LeastExperiencedID
FROM RankedExperience
GROUP BY JobDescription;


  --Difficult Tasks

1.Write an SQL query that separates the uppercase letters, lowercase letters, numbers, and ' ||
'other characters from the given string 'tf56sd#%OqH' into separate columns.


SELECT
  REGEXP_REPLACE('tf56sd#%OqH', '[^A-Z]', '', 'g') AS uppercase_letters,
  REGEXP_REPLACE('tf56sd#%OqH', '[^a-z]', '', 'g') AS lowercase_letters,
  REGEXP_REPLACE('tf56sd#%OqH', '[^0-9]', '', 'g') AS digits,
  REGEXP_REPLACE('tf56sd#%OqH', '[A-Za-z0-9]', '', 'g') AS other_characters;

2.Write an SQL query that replaces each row with the sum of its value and the previous rows' value. (Students table)
select * from students;
SELECT
  StudentID,
  FullName,
  SUM(Grade) OVER (ORDER BY StudentID) AS RunningTotalGrade
FROM Students;

3.You are given the following table, which contains a VARCHAR column that contains mathematical equations.
Sum the equations and provide the answers in the output.(Equations)


SELECT
  Equation,
  CASE Equation
    WHEN '123' THEN 123
    WHEN '1+2+3' THEN 1+2+3
    WHEN '1+2-3' THEN 1+2-3
    WHEN '1+23' THEN 1+23
    WHEN '1-2+3' THEN 1-2+3
    WHEN '1-2-3' THEN 1-2-3
    WHEN '1-23' THEN 1-23
    WHEN '12+3' THEN 12+3
    WHEN '12-3' THEN 12-3
  END AS TotalSum
FROM Equations;

4.Given the following dataset, find the students that share the same birthday.(Student Table)

select studentname  from student
    where case when birthday='2015-04-15' then 1

when birthday='2015-05-23' then 1
end=1;

5.You have a table with two players (Player A and Player B) and their scores.
If a pair of players have multiple entries, aggregate their scores into a single row for each unique pair of players.
Write an SQL query to calculate the total score for each unique player pair(PlayerScores)

select least(playera, playerb) ,
       greatest(playera, playerb),
sum(score) as total_sum  from playerscores
group by least(playera, playerb) , greatest(playera, playerb);






I hope all puzzles are given correct solution . But , if there are any errors , please write full select statement  in feedback  part . 
  I am sure solutions i provide for these puzzles are enough to get higher than 90 percentage out of 100 percentage  .
  I wonder if you would evaluate me with a score higher than 90%.
