create schema if not exists company_constraints;
use company_constraints;

select * from information_schema.table_constraints
	where constraint_schema = 'company_constraints';


create table employee(
	Fname varchar(15) NOT NULL,
    Mint char,
    Lname varchar(15) NOT NULL,
    Ssn char(9) NOT NULL,
    Bdate DATE,
    Address varchar(30),
    Sex char,
    Salary decimal(10,2),
    Super_ssn char(9),
    Dno int NOT NULL,
    constraint chk_salary_employee check (Salary>2000.0),
    constraint pk_employee primary key (Ssn)
);

desc employee;

alter table employee
	add constraint fk_employee
		foreign key(super_ssn) references employee(Ssn)
		on delete set null
        on update cascade;

create table departament(
	Dname varchar(15) NOT NULL,
	Dnumber int not null,
    Mgr_ssn char(9),
    Mgr_start_date date,
    Dept_create_date date,
    constraint chk_date_dpt check (Dept_create_date < Mgr_start_date),
    constraint chk_dept primary key(Dnumber),
    constraint unique_name_dept unique (Dname),
    foreign key (Mgr_ssn) references employee(Ssn)
);

alter table departament drop constraint departament_ibfk_1;
alter table departament 
	add constraint fk_dept foreign key(Mgr_ssn) references employee(Ssn)
    on update cascade;
    
desc departament;

create table dept_locations(
	Dnumber int not null,
    Dlocation varchar(15) not null,
    constraint pk_dept_locations primary key (Dnumber, Dlocation),
    constraint fk_dept_locations foreign key (Dnumber) references departament (Dnumber)
);

alter table dept_locations drop constraint fk_dept_locations;

alter table dept_locations 
	add constraint fk_dept_locations foreign key (Dnumber) references departament(Dnumber)
    on delete cascade
    on update cascade;

create table project(
	Pname varchar(15) not null,
    Pnumber int not null,
    Plocation varchar (15),
    Dnum int not null,
    primary key (Pnumber),
	constraint unique_project unique  (Pname),
    constraint fk_project foreign key (Dnum) references departament(Dnumber) 
);

desc project;

create table works_on(
	Essn char(9) not null,
    Pno int not null,
    Hours decimal(3,1) not null,
    Primary key (Essn, Pno),
    constraint fk_employee_works_on foreign key (Essn) references employee(Ssn),
    constraint fk_project_works_on foreign key (Pno) references project(Pnumber)
);

desc works_on;

drop table dependent;
create table dependent(
	Essn char(9) not null,
    Dependent_name varchar(15) not null,
    Sex char,
    Bdate date,
    Relationship varchar(8),
    primary key(Essn, Dependent_name),
    constraint fk_dependent foreign Key(Essn) references employee(Ssn)
);

desc dependent;
	
show tables;
desc dependent;

	 