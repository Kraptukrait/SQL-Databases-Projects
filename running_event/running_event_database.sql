DROP DATABASE IF EXISTS running_event;

CREATE DATABASE running_event;

USE running_event;

CREATE TABLE tbl_runner(
    pk_id_runner INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    runner_lastname VARCHAR(80) NOT NULL,
    runner_firstname VARCHAR(79) NOT NULL,
    runner_birthdate DATE NOT NULL,
    runner_street_number VARCHAR(100),
    runner_city_zip VARCHAR(100)
) ENGINE=InnoDB;

CREATE TABLE tbl_event(
    pk_id_event INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    event_name VARCHAR(100) NOT NULL,
    event_date DATE,
    event_distance VARCHAR(10) NOT NULL
) ENGINE=InnoDB;

CREATE TABLE tbl_participations(
    pk_id_participation INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    fk_runner INT NOT NULL,
    fk_event INT NOT NULL,
    FOREIGN KEY (fk_runner)
    REFERENCES tbl_runner (pk_id_runner)
    ON UPDATE CASCADE
    ON DELETE RESTRICT,

    FOREIGN KEY (fk_event)
    REFERENCES tbl_event (pk_id_event)
    ON UPDATE CASCADE
    ON DELETE RESTRICT
) ENGINE=InnoDB;
