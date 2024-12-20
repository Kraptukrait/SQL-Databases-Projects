DROP DATABASE IF EXISTS internship;
CREATE DATABASE internship;
USE internship;

CREATE TABLE tbl_company(
    pk_company_name VARCHAR(50) NOT NULL PRIMARY KEY,
    company_street_number VARCHAR(100) NOT NULL,
    company_postal_location VARCHAR(30) NOT NULL,
    company_phone VARCHAR(40),
    company_contact_person VARCHAR(50)
) ENGINE=InnoDB;

CREATE TABLE tbl_supervisor(
    pk_id_supervisor INT AUTO_INCREMENT PRIMARY KEY,
    supervisor_name VARCHAR(50) NOT NULL,
    supervisor_phone VARCHAR(40),
    supervisor_email VARCHAR(70),
    fk_company VARCHAR(50) NOT NULL,
    FOREIGN KEY(fk_company)
        REFERENCES tbl_company(pk_company_name)
        ON UPDATE CASCADE
        ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE tbl_teacher(
    pk_id_teacher INT AUTO_INCREMENT PRIMARY KEY,
    teacher_lastname VARCHAR(50) NOT NULL,
    teacher_firstname VARCHAR(50) NOT NULL
) ENGINE=InnoDB;

CREATE TABLE tbl_class(
    pk_class_name VARCHAR(10) NOT NULL PRIMARY KEY,
    fk_class_teacher INT,
    FOREIGN KEY(fk_class_teacher)
        REFERENCES tbl_teacher(pk_id_teacher)
        ON UPDATE CASCADE
        ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE tbl_student(
    pk_id_student INT AUTO_INCREMENT PRIMARY KEY,
    student_lastname VARCHAR(50),
    student_firstname VARCHAR(50),
    student_email VARCHAR(70),
    fk_class VARCHAR(10),
    FOREIGN KEY(fk_class)
        REFERENCES tbl_class(pk_class_name)
        ON UPDATE CASCADE
        ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE tbl_internship(
    pk_id_internship INT AUTO_INCREMENT PRIMARY KEY,
    fk_teacher INT,
    fk_student INT,
    fk_supervisor INT,
    internship_start DATE,
    internship_end DATE,
    internship_grade INT(10),
    presentation_grade INT(10),
    FOREIGN KEY(fk_teacher)
        REFERENCES tbl_teacher(pk_id_teacher)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    FOREIGN KEY(fk_student)
        REFERENCES tbl_student(pk_id_student)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    FOREIGN KEY(fk_supervisor)
        REFERENCES tbl_supervisor(pk_id_supervisor)
        ON UPDATE CASCADE
        ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE tbl_report(
    pk_id_report INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    report_date DATE,
    report_grade INT(10),
    fk_internship INT,
    FOREIGN KEY(fk_internship)
        REFERENCES tbl_internship(pk_id_internship)
        ON UPDATE CASCADE
        ON DELETE CASCADE
) ENGINE=InnoDB;
