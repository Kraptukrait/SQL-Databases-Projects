DROP DATABASE IF EXISTS employee;

CREATE DATABASE employee;

USE employee;

CREATE TABLE tbl_department(
    pk_id_dept INT AUTO_INCREMENT PRIMARY KEY,
    designation VARCHAR(100)
) ENGINE = InnoDB;

CREATE TABLE tbl_employee(
    pk_emp_id CHAR(4) PRIMARY KEY NOT NULL,
    emp_lastname VARCHAR(50) NOT NULL,
    emp_firstname VARCHAR(50) NOT NULL,
    fk_dept INT,
    FOREIGN KEY (fk_dept)
    REFERENCES tbl_department (pk_id_dept)
    ON UPDATE CASCADE
    ON DELETE RESTRICT
) ENGINE = InnoDB;

CREATE TABLE tbl_branch_location(
    pk_branch VARCHAR(60) PRIMARY KEY NOT NULL,
    branch_street_number VARCHAR(100) NOT NULL,
    branch_postcode_city VARCHAR(30) NOT NULL,
    branch_phone VARCHAR(20),
    branch_contact_person VARCHAR(40)
) ENGINE = InnoDB;

CREATE TABLE tbl_dept_branch(
    fk_dept INT,
    fk_branch VARCHAR(60),
    FOREIGN KEY (fk_dept)
    REFERENCES tbl_department (pk_id_dept)
    ON UPDATE CASCADE
    ON DELETE RESTRICT,

    FOREIGN KEY (fk_branch)
    REFERENCES tbl_branch_location (pk_branch)
    ON UPDATE CASCADE
    ON DELETE RESTRICT
) ENGINE = InnoDB;
