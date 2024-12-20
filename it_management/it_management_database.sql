DROP DATABASE IF EXISTS it_management;
CREATE DATABASE it_management;
USE it_management;

CREATE TABLE tbl_teacher
(
    pk_id_teacher INT AUTO_INCREMENT NOT NULL,   
    teacher_lastname VARCHAR(25) NOT NULL,  
    teacher_firstname VARCHAR(25) NOT NULL, 
    PRIMARY KEY(pk_id_teacher)
)
ENGINE=InnoDB;

CREATE TABLE tbl_class
(
    pk_id_classname CHAR(10) PRIMARY KEY,
    fk_class_teacher INT NOT NULL,
    FOREIGN KEY(fk_class_teacher)
		REFERENCES tbl_teacher(pk_id_teacher)
			ON UPDATE CASCADE 
			ON DELETE RESTRICT 
)
ENGINE=InnoDB;

CREATE TABLE tbl_student(
    pk_id_student INT AUTO_INCREMENT NOT NULL,
    student_lastname VARCHAR(25) NOT NULL,    
    student_firstname VARCHAR(25) NULL, 
    birth_date DATE NOT NULL,
    gender CHAR(1), 
    fk_class CHAR(10) NOT NULL, 
        PRIMARY KEY(pk_id_student),
    FOREIGN KEY(fk_class)
		REFERENCES tbl_class(pk_id_classname)
			ON UPDATE CASCADE 
			ON DELETE RESTRICT 
)
ENGINE=InnoDB;


-- Get Last Names of All Students
SELECT student_lastname FROM tbl_student;

-- Get Last Name of Student "...":
SELECT student_lastname FROM tbl_student
WHERE student_lastname = "...";

-- Get All Distinct Classes:
SELECT DISTINCT fk_class FROM tbl_student;

-- Get Last Names of Students in Class "...." in Block Format:
SELECT student_lastname, fk_class FROM tbl_student
WHERE fk_class = "..."\G;

-- Get Last Names of Students in Classes Ending with "..._":
SELECT student_lastname, fk_class FROM tbl_student
WHERE fk_class LIKE "%..._";

-- Get First and Last Names of Male and Female Students:
SELECT student_firstname, student_lastname, gender FROM tbl_student
WHERE gender IN ('w', 'm');

-- Get Male Students:
SELECT student_firstname, student_lastname, birth_date FROM tbl_student
WHERE gender = "m";

-- Get Female Students:
SELECT student_firstname, student_lastname, birth_date FROM tbl_student
WHERE gender = "w";

-- Count Female Students per Class:
SELECT fk_class, COUNT(gender) AS "Female Students", gender
FROM tbl_student
WHERE gender = "w"
GROUP BY fk_class;

-- Count Students in Classes Ending with "..._":
SELECT COUNT(student_lastname) AS "Number of Students", fk_class AS "Class"
FROM tbl_student
WHERE fk_class LIKE "%..._"
GROUP BY fk_class;

-- Count Students per Class:
SELECT COUNT(student_lastname) AS "Number of Students", fk_class AS "Class"
FROM tbl_student
GROUP BY fk_class;

-- Regular Query (without JOIN) for Student Last Names and Class Names:
SELECT tbl_student.student_lastname, tbl_class.pk_id_classname
FROM tbl_student, tbl_class
WHERE tbl_student.fk_class = tbl_class.pk_id_classname;

-- Using JOIN for Student Last Names and Class Names:
SELECT tbl_student.student_lastname, tbl_class.pk_id_classname
FROM tbl_class
INNER JOIN tbl_student ON tbl_class.pk_id_classname = tbl_student.fk_class;

-- Get Teacher Last Names and Their Assigned Classes:
SELECT tbl_teacher.teacher_lastname, tbl_class.pk_id_classname
FROM tbl_teacher
LEFT JOIN tbl_class ON tbl_teacher.pk_id_teacher = tbl_class.fk_class_teacher;

-- Get Teachers Without Classes Assigned:
SELECT tbl_teacher.teacher_lastname, tbl_class.pk_id_classname
FROM tbl_teacher
LEFT JOIN tbl_class ON tbl_teacher.pk_id_teacher = tbl_class.fk_class_teacher
WHERE tbl_class.pk_id_classname IS NULL;

-- Age Calculation Queries:
SELECT student_lastname, student_firstname 
FROM tbl_student
WHERE DATEDIFF(CURDATE(), birth_date) >= 6570;

-- Get Students Over 18 Years Old (Using DATE_ADD):
SELECT student_lastname, student_firstname 
FROM tbl_student
WHERE DATE_ADD(birth_date, INTERVAL 18 YEAR) <= CURDATE();

-- Get Students Born Before May 17, 1999:
SELECT student_lastname, student_firstname
FROM tbl_student
WHERE birth_date < "1999-05-17";
