create database HRMS;
use HRMS;
create table department (
    departmentid int primary key,
    departmentname varchar(100)
);

create table employee (
    employeeid int primary key,
    name varchar(100),
    address varchar(255),
    contact varchar(50),
    departmentid int,
    foreign key (departmentid) references department(departmentid)
);
create table job (
    jobid int primary key,
    jobtitle varchar(100),
    departmentid int,
    foreign key (departmentid) references department(departmentid)
);
create table salary (
    salaryid int primary key,
    employeeid int,
    salaryamount decimal(10,2),
    paydate date,
    foreign key (employeeid) references employee(employeeid)
);
create table performance_review (
    reviewid int primary key,
    employeeid int,
    reviewdate date,
    performancerating varchar(50),
    foreign key (employeeid) references employee(employeeid)
);
insert into department (departmentid, departmentname) values (1, 'human resources'), 
(2, 'engineering'), (3, 'marketing');

insert into job (jobid, jobtitle, departmentid) values (11, 'hr manager', 1), 
(22, 'recruiter', 1), (33, 'software developer', 2), (44, 'system architect', 2), 
(55, 'marketing coordinator', 3);

insert into employee (employeeid, name, address, contact, departmentid) values 
(111, 'Suresh Reddy', '111 st', '1234567890', 1), (222, 'manoj Rebbas', '222 st', '2345678901', 2),
 (333, 'Ravi teja', '333 st', '3456789012', 3);

insert into salary (salaryid, employeeid, salaryamount, paydate) values (1111, 111, 3000.00, '2024-04-05'),
 (2222, 222, 4000.00, '2024-04-05'), (3333, 333, 5000.00, '2024-04-05');

insert into performance_review (reviewid, employeeid, reviewdate, performancerating) values 
(101, 111, '2024-03-05', 'excellent'), (102, 222, '2024-03-05', 'good'), 
(103, 333, '2024-03-05', 'satisfactory');


create view employeedetails as
select e.employeeid, e.name, e.address, e.contact, d.departmentname
from employee e
join department d on e.departmentid = d.departmentid;


delimiter $$
create procedure addemployee (
    in _name varchar(100),
    in _address varchar(255),
    in _contact varchar(50),
    in _departmentid int
)
begin
    insert into employee (name, address, contact, departmentid)
    values (_name, _address, _contact, _departmentid);
end$$
delimiter ;

delimiter $$
create trigger checksalarybeforeupdate
before update on salary
for each row
begin
    if new.salaryamount < 1000 then
        signal sqlstate '45000' set message_text = 'error: salary amount cannot be less than $1000.';
    end if;
end$$
delimiter ;

alter table employee add constraint uc_employee_contact unique (contact);

update salary set salaryamount = 900 where salaryid = 1111;

insert into employee (employeeid, name, address, contact, departmentid) values 
(444, 'Raju', '444 st', '1234567890', 1);

insert into department (departmentid) values (4);

delete from department where departmentid = 4;

select employeeid, name, contact from employee;





