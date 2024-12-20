DROP DATABASE IF EXISTS training_company;

CREATE DATABASE training_company;

USE training_company;

CREATE TABLE tbl_instructors(
    pk_abbreviation VARCHAR(30) PRIMARY KEY NOT NULL,
    instructor_lastname VARCHAR(100) NOT NULL,
    instructor_firstname VARCHAR(100) NOT NULL,
    employment_type ENUM('Permanent', 'Freelancer') NOT NULL
) ENGINE = InnoDB;

CREATE TABLE tbl_room(
    pk_room_number VARCHAR(20) PRIMARY KEY NOT NULL,
    max_seat_count VARCHAR(10) NOT NULL
) ENGINE = InnoDB;

CREATE TABLE tbl_course(
    pk_course_name VARCHAR(80) PRIMARY KEY NOT NULL,
    number_of_days VARCHAR(10) NOT NULL,
    cost_per_day VARCHAR(20) NOT NULL,
    fk_instructor_abbreviation VARCHAR(30) NOT NULL,
    fk_room VARCHAR(20) NOT NULL,
    FOREIGN KEY (fk_instructor_abbreviation)
    REFERENCES tbl_instructors (pk_abbreviation)
    ON UPDATE CASCADE
    ON DELETE RESTRICT,

    FOREIGN KEY (fk_room)
    REFERENCES tbl_room (pk_room_number)
    ON UPDATE CASCADE
    ON DELETE RESTRICT
) ENGINE = InnoDB;
