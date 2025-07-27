
thirty sql interview question;

1. sql query to update dateofjoining to 15-jul-2012 for empid=1
ans:
--  select * from employee;
update employee set dateofjoining =  '15-jul-2012' where empid =1;
-- select * from employee (this give the update dateofjoining)

2.sql query to select all student name where age is greater than 22;
ans:
select * from student where age>22;

3.sql query to find all employee with salary between 40000 and 800000;

ans:
-- select * from employee;

select * from employee where salary between 40000 and 80000;
and
select* from employee where salary >40000 and salary <80000;

4.sql query to find name of employee beginnig with s.

ans:
select * from employee where firstname like 's%';
in the above code s% start with s and where %s s end with s.

5.sql query to display full name.
ans:
-- select * from employee;
select firstname || '' || lastname from employee;
--  (|| this is our pipe operator)

6. write a query to fetch details of employee whose EMPLOYEES firstname ends with an alphabet 'A' and contains 4 albhabets.

ans:
select * from employee where firstname like '____A';
this give the firstname like NANDA and DISHA.

AND select * from employee where firstname like (N___A)
this give the firstname like NANDA;

7. write a query to fetch details of all employee excluding the employee with first names,
'ANUSHKA' and 'SOMNATH' from the employee table.

ans:
select * from employee table where firstname not in ('ANUSHKA','Somnath')

8.sql query to display the current date?

ans: select sysdate, current date, systimestamp from dual.
here,
sysdate give = 19-jun-25
current date = 19-jun-25
systimestamp = 19-jun-25 12.45.33.456789 PM +05:30

9. select query to get day of the last day of the previous month?

ans:
-- select sysdate from dual
-- select add_months(sysdate,-1) from dual, this give me the previous month
-- select last_day (add_months(sysdate,-1)) from dual; this give me the last day of the previous month
select to_char(last_day (add_months(sysdate,-1))'day') from dual; this give me the last day of the month (monday)

10. write a sql query to fetch the employee first names and replace the A with @.
ans:
select replace (firstname, 'A','@')FROM EMPLOYEES;
 output is like  disha = dish@

11.write an sql query to fetch the domain from an email address?
ans:

-- select emailid from employee 
select instr (emailid,'@') from employee this is showing the @ position(place) of the @ code.

select substr(emailid, instr(email,'@')+1) from employee;

12. write an sql query to update the employee names by removing leading and trailing spaces.

ans:
update employee set firstname =rtrim(ltrim(firstname)); it remove the left space and right space.

13.write an sql query to fetch all the employee details from employee table who joined in the year 2020.
ans:
select * from employee where dateofjoining bitween '1-jan-2020' AND '31-dec-2020';

or 
select * from employee where to_char (dateofjoining,'yyyy')=2020;
(to_char converts the date to a string of the year only)

14.write an sql query to fetch only odd/even rows from the table?
ans:
-- select * from employee
select * from employee where mod(empid,2)=0; even number
select * from employee where mod (empid,2)!=0; odd number

15. write an sql query to create a new table with data and structure copied another table.
ans :
-- select * from employee;
create table emp as (select * from employee);
this give the same recored of employee table with employee table data.

16.if we dont want to create data then use this.

create table emp1 as(select * from employee where 1=2); this query is can not create the data.
select * from emp1; 

17. write an sql query to fetch the top 3 highest salary?

ans: select * from (select distinct salary from employee order by salary desc) where rownum <4;

18. find the first employee and last employee from employee table?
ans:
select * from employee where empid=(select min (empid) from employee);  for first employee 
select * from employee where empid=(select max (empid) from employee);  for last employee


19.list the ways to get the count of records in a table?
ans:
select count(*) from employee;
select count(column) from employee;

20. write a query to fetch the departmant-wise count of employees shorted by departments count in ascending order?

ans:
select dept, count (*)from employee group by dept;
in the above case when we use group by then use aggrigate function like count, sum,etc.

21. write a query to retrieve departmant who have less then 4 employee working in it.
ans:
select dept, count (*) from employee group by dept having count(*)<4;

22. write a query to retrieve departmant wise maxium salary.
ans:
select dept,max(salary) from employee group by dept;

23.write a query to employee earning maxium salary in his departmant?
ans:
select * from employee e1 join
(select dept ,max(salary )salary from employee group by dept) e2
on e1.dept = e2.dept and e1.salary=e2.salray;

24. write an sql query to fetch the first 50% records from a table.
ans:
select * from employee where rownum <= (select count (*) from employee)/2;

25.query to fetch details employee not having coumputer.
ans:
select * from employee where compid is not null.

26.query to fetch employee details along with the computer details who have been assigned with a computer. 
ans:
select * from employee e join coumputer c on e.compid = c.compid
this combine the all details of the employee and computer table.

27.fetch all employee details along with the computer name assigned to them.

ans: select firstname, nvl(c.brand, 'not assigned')
in the above query nvl use to if column value have null value then replace this by not aaigned;
from employee e left join computer c.on e.compid=c.compid;(left join)

28.fetch all computer details along with employee name using it.
ans:
select * from employee e right join computer c on e.compid = c.compid;(right join)

29.delete duplicate records from a table.
ans:
delete from duplicate where empid in (
select d1.empid from duplicate d1 on duplicate d2 on d1.firstname =d2.firstname
and d1.lastname=d2.lastname and d1.salaray=d2.salary
and d1.managerid =d2.managerid and d1.dateofjoining = d2.dateofjoining 
and d1.empid > d2.empid)

30.find nth highest salaray.
ans:
-- select * from employee
select e1.salaray,count( distinct e2.salaray) from employee e1 join employee e2 
on e1.salaray <= e2.salaray groupby e1.salaray having count(distinct e2.salary)=1;












