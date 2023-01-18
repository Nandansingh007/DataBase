-- sql assignment2 part 1 


/* Q.1) Create a university database that consists of tables such as the schema diagram above
-- (SQL data definition and tuples of some tables as shown above) */

-- creating the university database
CREATE DATABASE  db_university;

-- using the university database
USE db_university;


-- 1
CREATE TABLE tb_department(
	dept_name VARCHAR(20) NOT NULL,
	building VARCHAR(15),
	budget NUMERIC(12,2),
	PRIMARY KEY(dept_name)
);


-- 2
CREATE TABLE tb_instructor(
    instructor_id VARCHAR(5) NOT NULL,
    instructor_name VARCHAR(20) NOT NULL,
    dept_name VARCHAR(20),
    salary NUMERIC (8,2),
    PRIMARY KEY(instructor_id),
    FOREIGN KEY (dept_name) REFERENCES tb_department(dept_name)
);

-- 3
CREATE TABLE tb_classroom(
	building VARCHAR(15) NOT NULL,
    room_number VARCHAR(7) NOT NULL,
    capacity INT,
    PRIMARY KEY (building,room_number)
);


-- 4
CREATE TABLE tb_course(
    course_id VARCHAR(20) NOT NULL,
    title VARCHAR(50),
    dept_name VARCHAR(20),
    credits NUMERIC(2,0),
    PRIMARY KEY(course_id),
    FOREIGN KEY (dept_name) REFERENCES tb_department(dept_name)
);


-- 5
CREATE TABLE tb_time_slot(
	time_slot_id VARCHAR(4) NOT NULL,
    dayy VARCHAR(15) NOT NULL,
    start_time VARCHAR(15) NOT NULL,
    end_time VARCHAR(15),
    PRIMARY KEY(time_slot_id,dayy,start_time)
);



-- 6
CREATE TABLE tb_section(
    course_id VARCHAR(20) NOT NULL,
    sec_id VARCHAR(8) NOT NULL,
    semester VARCHAR(6) NOT NULL,
    years NUMERIC(4,0) NOT NULL,
    building VARCHAR(15),
    room_number VARCHAR(7),
    time_slot_id VARCHAR(4),
    PRIMARY KEY(course_id,sec_id,semester,years),
    FOREIGN KEY (course_id) REFERENCES tb_course(course_id),
    FOREIGN KEY(building,room_number) REFERENCES tb_classroom(building,room_number),
	FOREIGN KEY(time_slot_id) REFERENCES tb_time_slot(time_slot_id)
);


-- 7
CREATE TABLE tb_teaches(
    instructor_id VARCHAR(5),
    course_id VARCHAR(20),
    sec_id VARCHAR(8),
    semester VARCHAR(6),
    years NUMERIC(4,0),
    PRIMARY KEY(course_id,sec_id,semester,years),
    FOREIGN KEY (course_id,sec_id,semester,years) REFERENCES tb_section(course_id,sec_id,semester,years),
    FOREIGN KEY (instructor_id) REFERENCES tb_instructor(instructor_id)
);


-- 8
CREATE TABLE tb_student(
    student_id INT NOT NULL,
    student_name VARCHAR(20),
    dept_name VARCHAR(20),
    tot_cred INT,
    PRIMARY KEY (student_id),
    FOREIGN KEY (dept_name) REFERENCES tb_department(dept_name)
);


-- 9
CREATE TABLE tb_advisor(
	student_id INT NOT NULL,
    instructor_id VARCHAR(5),
    PRIMARY KEY(student_id),
    FOREIGN KEY (student_id) REFERENCES tb_student(student_id),
    FOREIGN KEY (instructor_id) REFERENCES tb_instructor(instructor_id)
);


-- 10
CREATE TABLE tb_takes(
	student_id INT NOT NULL,
	course_id VARCHAR(20) NOT NULL,
    sec_id VARCHAR(8) NOT NULL,
    semester VARCHAR(6) NOT NULL,
    years NUMERIC(4,0) NOT NULL,
    grade VARCHAR(4),
    PRIMARY KEY(student_id,course_id,sec_id,semester,years),
    FOREIGN KEY (course_id,sec_id,semester,years) REFERENCES tb_section(course_id,sec_id,semester,years),
    FOREIGN KEY (student_id) REFERENCES tb_student(student_id)
);


-- 11
CREATE TABLE tb_prereq(
	course_id VARCHAR(20) NOT NULL,
    prereq_id VARCHAR(8) NOT NULL,
    PRIMARY KEY(course_id,prereq_id),
    FOREIGN KEY (course_id) REFERENCES tb_course(course_id)
);





-- Q.3) Fillthe tuple of each table at least 10 tuples

-- 1
INSERT INTO tb_department(dept_name, building, budget)
VALUES ('biology','block b',80000),
	('bct','block e',70000),
	('bce','block a',40000),
	('arch','block e',35000),
	('history','block e',45000),
	('music','block c',90000),
	('physics','block d',200000);
 

-- 2
INSERT INTO tb_instructor(instructor_id, instructor_name, dept_name, salary)
VALUES ('101','brandit','bct',35000),
	('102','mozart','music',50000),
	('103','einstein','physics',100000),
	('104','newton','physics',95000),
	('105','crick','biology',40000),
	('106','singh','bce',20000),
	('107','costanza','arch',30000),
	('108','Califeri','history',42000),
	('109','babbage', 'bct',25000);


-- 3
INSERT INTO tb_classroom(building, room_number, capacity)
VALUES ('block a','25',250),
    ('block b','35',270),
    ('block c','45',290),
    ('block d','55',310),
    ('block e','65',100),
    ('block e','66',200),
    ('block e','67',300);
    


-- 4
INSERT INTO tb_course(course_id, title, dept_name, credits)
VALUES ('bct-101','game design','bct',10),
	('music-101','chords','music',10),
	('physics-101','relativity','physics',7),
	('physics-102','gravity','physics',7),
	('bio-101','frog','biology',6),
	('bio-102','lizard','biology',5),
	('bce-101','hydraulics','bce',10),
	('arch-101','opera house','arch',9),
	('history-101','ww1','history',8);


-- 5
INSERT INTO tb_time_slot(time_slot_id,dayy,start_time,end_time )
VALUES ('a','sunday','10:00','1:00'),
	('b','sunday','1:00','3:00'),
    ('c','monday','11:00','1:00'),
    ('d','tuesday','1:00','3:00'),
    ('e','tuesday','3:00','4:00'),
    ('f','wednesday','12:00','2:00'),
    ('g','thursday','11:00','2:00'),
    ('h','thursday','2:00','4:00');



-- 6
INSERT INTO tb_section(course_id, sec_id, semester, years, building, room_number, time_slot_id) 
VALUES ('bio-101','1','fall',2009,'block b','35','a'),
	('bio-102','1','spring',2010,'block b','35','h'),
	('bct-101','1','fall',2009,'block e','65','b'),
	('bct-101','2','fall',2009,'block e','66','e'),
	('bce-101','1','spring',2010,'block a','25','c'),
	('arch-101','1','summer',2009,'block e','67','d'),
	('history-101','1','spring',2010,'block e','66','e'),
	('music-101','1','spring',2010,'block c','45','f'),
	('physics-101','1','fall',2009,'block d','55','g'),
	('physics-102','1','fall',2010,'block d','55','b');



-- 7
INSERT INTO tb_teaches(instructor_id, course_id, sec_id, semester, years)
VALUES  ('101','bct-101','1','fall',2009),
	('102','music-101','1','spring',2010),
	('103','physics-101','1','fall',2009),
	('104','physics-102','1','fall',2010),
	('105','bio-101','1','fall',2009),
    ('105','bio-102','1','spring',2010),
	('106','bce-101','1','spring',2010),
	('107','arch-101','1','summer',2009),
	('108','history-101','1','spring', 2010),
	('109','bct-101','2','fall',2009);


-- 8
INSERT INTO tb_student(student_id, student_name, dept_name, tot_cred)
VALUES (1,'mishan','bct',500),
	(2,'ayush','bce',450),
	(3,'ankit','arch',300),
    (4,'prabin','history',350),
    (5,'nishant','physics',250),
    (6,'nikhil','music',345),
    (7,'nista','bct',455),
    (8,'prinsa','bce',298),
    (9,'samman','arch',308),
    (10,'bikrant','history',420),
    (11,'dipesh','physics',368),
    (12,'arahant','music',399),
    (13,'raj','bct',405),
    (14,'amit','biology',333);	


-- 9
INSERT INTO tb_advisor(student_id,instructor_id)
VALUES (1,'101'),
	(2,'106'),
	(3,'107'),
	(5,'103'),
    (6,'102'),
	(7,'101'),
	(8,'106'),
	(9,'107'),
	(10,'108'),
    (11,'104'),
    (13,'109'),
	(14,'105');


-- 10  
INSERT INTO tb_takes(student_id, course_id, sec_id, semester, years, grade)
VALUES  (1,'bct-101','1','fall',2009,'3.6'),
	(2,'bce-101','1','spring',2010,'3.3'),
	(3,'arch-101','1','summer',2009,'2.6'),
	(4,'history-101','1','spring',2010,'2.7'),
	(5,'physics-101','1','fall',2009,'2.8'),
    (6,'music-101','1','spring',2010,'2.9'),
	(7,'bct-101','1','fall',2009,'3.2'),
	(8,'bce-101','1','spring',2010,'3.2'),
	(9,'arch-101','1','summer',2009,'3.0'),
	(10,'history-101','1','spring',2010,'3.1'),
    (11,'physics-102','1','fall',2010,'3.2'),
	(12,'music-101','1','spring',2010,'3.3'),
	(13,'bct-101','2','fall',2009,'3.4'),
	(14,'bio-101','1','fall',2009,'3.3');
        
        


-- 11
INSERT INTO tb_prereq(course_id,prereq_id)
VALUES ('bct-101',4455),
	('music-101',6677),
	('physics-101',8899),
	('physics-102',1122),
	('bio-101',3344),
	('bio-102',5544),
	('bce-101',4433),
	('arch-101',2288),
	('history-101',6611);



-------------------------------------------------------------------------------------------------

-- Q.4) Write the following queries in Relational Algebra and SQL :

-- Q.4.1) Findsthe names of all instructors in the History department

SELECT instructor_name
FROM tb_instructor 
WHERE dept_name='history';

-- ----------------------------------------------------------------------
/* Q.4.2) Findsthe instructor ID and department name of all instructors associated with a
department with budget of greater than $95,000 */
-- using join 
SELECT tb_instructor.instructor_id, tb_instructor.dept_Name 
FROM tb_instructor 
INNER JOIN 
tb_department ON tb_instructor.dept_name=tb_department.dept_name 
WHERE budget>95000;


--using subquery
SELECT * FROM tb_instructor;
SELECT instructor_id , dept_name 
FROM tb_instructor i 
WHERE dept_Name IN (
					SELECT dept_name FROM tb_department 
                    WHERE budget>95000);


-- ----------------------------------------------------------------------
/* Q.4.3)Finds the names of all instructors in the Comp. Sci. department together with the
course titles of all the courses that the instructors teach */

--department computer scie. is BCT in this database

SELECT tb_instructor.instructor_name,tb_course.title
FROM tb_instructor
INNER JOIN tb_teaches ON tb_instructor.instructor_id = tb_teaches.instructor_id
INNER JOIN tb_course ON tb_teaches.course_id = tb_course.course_id
WHERE tb_instructor.dept_name = 'bct';



-- ----------------------------------------------------------------------
-- Q.4.4) Find the names of all students who have taken the course title of “Game Design”.


SELECT tb_student.student_name
FROM tb_student
INNER JOIN tb_takes ON tb_student.student_id = tb_takes.student_id
INNER JOIN tb_course ON tb_takes.course_id = tb_course.course_id
WHERE tb_course.title = 'Game Design';


-- ---------------------------------------------------------
-- Q.4.5) For each department, find the maximum salary of instructors in that department. You
-- may assume that every department has at least one instructor.

SELECT tb_instructor.dept_name, MAX(salary)
FROM tb_instructor
GROUP BY dept_Name;


-- ------------------------------------------------------------------

/* Q.4.6) Find the lowest, across all departments, of the per-department maximum salary
computed by the preceding query. */

SELECT MIN(maximum_per_dept_salary)
FROM (	SELECT tb_instructor.dept_name, MAX(salary) AS maximum_per_dept_salary
		FROM tb_instructor
		GROUP BY dept_name
		) AS min_table;
        
-- ----------------------------------------------------------------------        

-- Q.4.7) Find the ID and names of all students who do not have an advisor.

SELECT student_id, student_name
FROM tb_student 
WHERE student_id NOT IN(
					SELECT student_id 
                    FROM tb_advisor);