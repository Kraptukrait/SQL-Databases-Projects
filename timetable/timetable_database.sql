DROP DATABASE IF EXISTS timetable;

CREATE DATABASE timetable DEFAULT CHARSET=utf8;

USE timetable;

CREATE TABLE tbl_teacher
	(
		pk_id_teacher INT NOT NULL AUTO_INCREMENT,
		teacher_lastname VARCHAR(45) NULL,
		teacher_firstname VARCHAR(45) NOT NULL,
		teacher_birth_date DATE NULL,
		PRIMARY KEY(pk_id_teacher)
	)
ENGINE=InnoDB;

CREATE TABLE tbl_class
	(
		pk_class CHAR(10) NOT NULL,
		fk_class_teacher INT,
		PRIMARY KEY(pk_class),
		FOREIGN KEY(fk_class_teacher) 
			REFERENCES tbl_teacher(pk_id_teacher)
				ON UPDATE CASCADE
				ON DELETE NO ACTION
	)
ENGINE=InnoDB;

CREATE TABLE tbl_subject
	(
		subject VARCHAR(35) NOT NULL,
		PRIMARY KEY(subject)
	)
ENGINE=InnoDB;

CREATE TABLE tbl_hour
	(
		class_hour CHAR(9) NOT NULL,
		PRIMARY KEY(class_hour)
	)
ENGINE=InnoDB;

CREATE TABLE tbl_student
	(
		pk_id_student INT NOT NULL AUTO_INCREMENT,
		student_lastname VARCHAR(45) NOT NULL,
		student_firstname VARCHAR(45) NOT NULL,
		birth_date DATE NOT NULL,
		gender CHAR(1),
		fk_class CHAR(10),
		PRIMARY KEY(pk_id_student),
		INDEX tbl_student_fk_class(fk_class),
		FOREIGN KEY(fk_class)
			REFERENCES tbl_class(pk_class)
				ON UPDATE CASCADE
				ON DELETE SET NULL
	)
ENGINE=InnoDB;

CREATE TABLE tbl_lesson
	(
		fk_teacher INT NOT NULL,
		fk_subject VARCHAR(35) NOT NULL,
		fk_class CHAR(10) NOT NULL,
		fk_hour CHAR(9),
		PRIMARY KEY(fk_class, fk_hour),
		UNIQUE INDEX(fk_teacher, fk_hour),
		FOREIGN KEY(fk_teacher)
			REFERENCES tbl_teacher(pk_id_teacher)
				ON UPDATE CASCADE
				ON DELETE NO ACTION,
		FOREIGN KEY(fk_subject)
			REFERENCES tbl_subject(subject)
				ON UPDATE CASCADE
				ON DELETE NO ACTION,      
		FOREIGN KEY(fk_class)
			REFERENCES tbl_class(pk_class)
				ON UPDATE CASCADE
				ON DELETE RESTRICT,
		FOREIGN KEY(fk_hour)
			REFERENCES tbl_hour(class_hour)
				ON UPDATE CASCADE
				ON DELETE NO ACTION
	)
ENGINE=InnoDB;
