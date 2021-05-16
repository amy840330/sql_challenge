Create table departments(
	dept_no varchar not null primary key,
	dept_name varchar(30)
);

Create table dept_emp(
	emp_no int,
	dept_no varchar,
	primary key(emp_no,dept_no),
	foreign key(dept_no) REFERENCES departments(dept_no)
);

Create table dept_manager(
	dept_no varchar,
	emp_no int,
	primary key(dept_no, emp_no),
	foreign key(dept_no) REFERENCES departments(dept_no)
);

create table salaries(
	emp_no int,
	salary int
);

create table titles(
	title_id varchar,
	title varchar,
	primary key(title_id)
);

create table employees(
	emp_no int,
	emp_title_id varchar,
	birth_date varchar,
	first_name varchar,
	last_name varchar,
	sex varchar,
	hire_date varchar,
	primary key(emp_no,emp_title_id)
	foreign key emp_title_id references titles(title_id)
);

--1--
create view one as
select e.emp_no, e.first_name, e.last_name, e.sex, s.salary
from employees e
join salaries s
on e.emp_no=s.emp_no;

--2--
create view two as
select first_name, last_name, hire_date
from employees
where hire_date like '%1986';

--3--
create view three as
select e.emp_no, e.first_name, e.last_name, d.dept_no,d.dept_name
from employees e
join dept_manager m
on e.emp_no=m.emp_no
join departments d
on m.dept_no=d.dept_no;

--4--
create view four as
select e.emp_no, e.first_name, e.last_name, d.dept_name
from employees e
join dept_emp de
on e.emp_no=de.emp_no
join departments d
on de.dept_no=d.dept_no;

--5--
create view five as
select first_name, last_name, sex
from employees
where first_name='Hercules' and last_name like 'B%';

--6--
create view six as
select e.emp_no, e.first_name, e.last_name, d.dept_name
from employees e
join dept_emp de
on e.emp_no=de.emp_no
join departments d
on de.dept_no=d.dept_no
where d.dept_name = 'Sales';

--7--
create view seven as
select e.emp_no, e.first_name, e.last_name, d.dept_name
from employees e
join dept_emp de
on e.emp_no=de.emp_no
join departments d
on de.dept_no=d.dept_no
where d.dept_name in ('Sales','Development');

--8--
create view eight as
select last_name, count(last_name) as frequency
from employees
group by last_name
order by frequency DESC;




