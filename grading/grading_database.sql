DROP DATABASE IF EXISTS grading; 

CREATE DATABASE grading DEFAULT CHARSET=utf8;

USE grading;

CREATE TABLE tbl_teacher
	(
		pk_id_teacher INT AUTO_INCREMENT,
		teacher_lastname VARCHAR(45) NOT NULL, 
		teacher_firstname VARCHAR(45) NULL,
		PRIMARY KEY(pk_id_teacher) 
	)
ENGINE=InnoDB;

CREATE TABLE tbl_class
	(
		pk_classname CHAR(10) NOT NULL, 
		fk_class_teacher INT,
		FOREIGN KEY(fk_class_teacher)
			REFERENCES tbl_teacher(pk_id_teacher)
				ON UPDATE CASCADE 
				ON DELETE RESTRICT, 
		PRIMARY KEY(pk_classname)
	)
ENGINE=InnoDB;

CREATE TABLE tbl_subject
	(
		pk_subject VARCHAR(35) NOT NULL,
		PRIMARY KEY(pk_subject)
	)
ENGINE=InnoDB;

CREATE TABLE tbl_grading_type
	(
		pk_type VARCHAR(15) NOT NULL, 
		PRIMARY KEY(pk_type)
	)
ENGINE=InnoDB;

CREATE TABLE tbl_student
	(
		pk_id_student INT NOT NULL AUTO_INCREMENT,
		student_lastname VARCHAR(45) NOT NULL,
		student_firstname VARCHAR(45) NOT NULL,
		fk_class CHAR(10) NULL,
		gender CHAR(1) NOT NULL,
		birth_date DATE NOT NULL,
		PRIMARY KEY(pk_id_student),
		INDEX tbl_student_tbl_class(fk_class),
		FOREIGN KEY(fk_class)
			REFERENCES tbl_class(pk_classname)
				ON UPDATE CASCADE 
				ON DELETE SET NULL
	)
ENGINE=InnoDB;

CREATE TABLE tbl_grading
	(
		pk_id_grading INT AUTO_INCREMENT PRIMARY KEY,
		fk_subject VARCHAR(35) NOT NULL,
		fk_teacher INT NOT NULL,
		fk_student INT NOT NULL,
		grade ENUM('1','2','3','4','5','6') NOT NULL,
		date DATE NOT NULL,
		fk_type VARCHAR(15) NULL,
		INDEX tbl_grading_tbl_subject(fk_subject),
		INDEX tbl_grading_tbl_teacher(fk_teacher),
		INDEX tbl_grading_tbl_student(fk_student),
		INDEX tbl_grading_tbl_gradingtype(fk_type),
		FOREIGN KEY(fk_subject)
			REFERENCES tbl_subject(pk_subject)
				ON UPDATE CASCADE
				ON DELETE NO ACTION,
		FOREIGN KEY(fk_teacher)
			REFERENCES tbl_teacher(pk_id_teacher)
				ON UPDATE CASCADE
				ON DELETE NO ACTION,
		FOREIGN KEY(fk_student)
			REFERENCES tbl_student(pk_id_student)
				ON UPDATE CASCADE
				ON DELETE RESTRICT, 
		FOREIGN KEY(fk_type)
			REFERENCES tbl_grading_type(pk_type)
				ON UPDATE CASCADE
				ON DELETE SET NULL
	)
ENGINE=InnoDB;


-- Query 1
CREATE VIEW qry_overall_grade_... AS
SELECT tbl_student.student_lastname AS 'Student Name', ROUND(AVG(tbl_grading.grade), 3) AS 'Grade' 
FROM tbl_grading
JOIN tbl_student ON tbl_grading.fk_student = tbl_student.pk_id_student
WHERE tbl_student.student_lastname LIKE '...'
GROUP BY tbl_student.student_lastname;

-- Query 2
CREATE VIEW qry_overall_grade_class AS
SELECT tbl_class.pk_classname AS 'Class Name', ROUND(AVG(tbl_grading.grade), 3) AS 'Grade' 
FROM tbl_grading
JOIN tbl_student ON tbl_grading.fk_student = tbl_student.pk_id_student
JOIN tbl_class ON tbl_student.fk_class = tbl_class.pk_classname
GROUP BY tbl_class.pk_classname;

-- Query 3
CREATE VIEW qry_overall_grade_male AS
SELECT tbl_student.gender AS 'Gender', ROUND(AVG(tbl_grading.grade), 3) AS 'Overall Grade' 
FROM tbl_grading
JOIN tbl_student ON tbl_grading.fk_student = tbl_student.pk_id_student
WHERE tbl_student.gender LIKE 'm';

CREATE VIEW qry_overall_grade_female AS
SELECT tbl_student.gender AS 'Gender', ROUND(AVG(tbl_grading.grade)) AS 'Overall Grade' 
FROM tbl_grading
JOIN tbl_student ON tbl_grading.fk_student = tbl_student.pk_id_student
WHERE tbl_student.gender LIKE 'w';

-- Query 4
CREATE VIEW qry_number_of_students_class AS
SELECT tbl_student.fk_class AS 'Class', COUNT(tbl_student.student_lastname) AS 'Number of Students' 
FROM tbl_student
JOIN tbl_class ON tbl_student.fk_class = tbl_class.pk_classname
GROUP BY tbl_student.fk_class;

-- Query 5
CREATE VIEW qry_teacher_subjects AS
SELECT tbl_grading.fk_teacher_name AS 'Teacher', tbl_grading.fk_subject AS 'Subject' 
FROM tbl_grading
JOIN tbl_teacher ON tbl_teacher.pk_teacher_name = tbl_grading.fk_teacher_name
JOIN tbl_subject ON tbl_subject.pk_subject = tbl_grading.fk_subject
GROUP BY tbl_grading.fk_teacher_name;

-- Query 6
CREATE VIEW qry_teacher_overall_grade AS
SELECT tbl_grading.fk_teacher_name AS 'Teacher', AVG(tbl_grading.fk_grade) AS 'Overall Grade' 
FROM tbl_grading
JOIN tbl_teacher ON tbl_teacher.pk_teacher_name = tbl_grading.fk_teacher_name
JOIN tbl_grade ON tbl_grading.fk_grade = tbl_grade.pk_grade 
GROUP BY tbl_grading.fk_teacher_name;

-- Query 7
CREATE VIEW qry_class_math_overall_grade AS
SELECT tbl_class.pk_classname AS 'Class', AVG(tbl_grading.fk_grade) AS 'Overall Grade' 
FROM tbl_grading
JOIN tbl_student ON tbl_student.pk_id_student = tbl_grading.fk_student
JOIN tbl_class ON tbl_class.pk_classname = tbl_student.fk_class
JOIN tbl_subject ON tbl_grading.fk_subject = tbl_subject.pk_subject
WHERE tbl_subject.pk_subject LIKE 'Mathematics'
GROUP BY tbl_class.pk_classname;

-- Query 8
CREATE VIEW qry_students_grade_5_and_6 AS
SELECT tbl_grading.fk_student AS 'Student', tbl_grading.fk_grade AS 'Grade' 
FROM tbl_grading
JOIN tbl_student ON tbl_grading.fk_student = tbl_student.pk_id_student
JOIN tbl_grade ON tbl_grading.fk_grade = tbl_grade.pk_grade
WHERE tbl_grading.fk_grade IN ('5', '6') -- Use of IN for multiple conditions
GROUP BY tbl_grading.fk_student;
