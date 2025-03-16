DROP DATABASE IF EXISTS machine_rental;
CREATE DATABASE IF NOT EXISTS machine_rental DEFAULT CHARSET=UTF8;

USE machine_rental;

CREATE TABLE tbl_customer
(
    pk_id_customer INT AUTO_INCREMENT NOT NULL,
    customer_name VARCHAR(30) NOT NULL,
    customer_city VARCHAR(25) NOT NULL,
    customer_type VARCHAR(15) NULL,
    PRIMARY KEY (pk_id_customer)
)
ENGINE=InnoDB;

CREATE TABLE tbl_machine_type
(
    pk_type VARCHAR(10) NOT NULL,
    machine_category ENUM('Excavator', 'Truck', 'Large Forklift', 'Forklift', 'Wheel Loader'),
    manufacturer VARCHAR(15) NULL,
    license_required ENUM('', 'Forklift License', 'L', 'C1', 'C', 'L and Forklift License'),
    workshop VARCHAR(25),
    rate_per_day DECIMAL(5,2) NULL,
    rate_per_km DECIMAL(4,2) NULL,
    PRIMARY KEY(pk_type)
)
ENGINE=InnoDB;

CREATE TABLE tbl_branch
(
    pk_branch_id VARCHAR(30) NOT NULL,
    contact_person VARCHAR(30) NOT NULL,
    branch_city VARCHAR(25) NOT NULL,
    PRIMARY KEY (pk_branch_id)
)
ENGINE=InnoDB;

CREATE TABLE tbl_machine
(
    pk_machine_id VARCHAR(10) NOT NULL,
    fk_type VARCHAR(10) NOT NULL,
    license_plate VARCHAR(15) NULL,
    operational BOOLEAN NOT NULL,
    inspection_date DATE NOT NULL,
    purchase_date DATE NOT NULL,
    FOREIGN KEY (fk_type)
        REFERENCES tbl_machine_type(pk_type)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    PRIMARY KEY(pk_machine_id)
)
ENGINE=InnoDB;

CREATE TABLE tbl_rental
(
    fk_customer_id INT NOT NULL,
    fk_machine_id VARCHAR(10) NOT NULL,
    fk_branch_id VARCHAR(30) NOT NULL,
    rental_start DATE NOT NULL,
    rental_end DATE NULL,
    start_km INT NULL,
    end_km INT NULL,
    PRIMARY KEY(fk_machine_id, rental_start),
    FOREIGN KEY (fk_customer_id)
        REFERENCES tbl_customer(pk_id_customer)
        ON UPDATE RESTRICT
        ON DELETE RESTRICT,
    FOREIGN KEY (fk_machine_id)
        REFERENCES tbl_machine(pk_machine_id)
        ON UPDATE RESTRICT
        ON DELETE RESTRICT,
    FOREIGN KEY (fk_branch_id)
        REFERENCES tbl_branch(pk_branch_id)
        ON UPDATE RESTRICT
        ON DELETE RESTRICT
)
ENGINE=InnoDB;

CREATE TABLE tbl_city(
    pk_city_id INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    city_zip CHAR(5) NOT NULL,
    city_name VARCHAR(100) NOT NULL
)ENGINE=InnoDB;

CREATE TABLE tbl_staff(
    pk_staff_id INT AUTO_INCREMENT PRIMARY KEY,
    staff_last_name VARCHAR(100) NOT NULL,
    staff_first_name VARCHAR(100) NOT NULL,
    staff_birth_date DATE NULL,
    fk_branch VARCHAR(30) NULL,
    fk_city INT NOT NULL,
    FOREIGN KEY (fk_city)
        REFERENCES tbl_city (pk_city_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    FOREIGN KEY (fk_branch)
        REFERENCES tbl_branch (pk_branch_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE
)ENGINE=InnoDB;

CREATE TABLE tbl_qualification(
    pk_qualification VARCHAR(100) PRIMARY KEY NOT NULL,
    attended_courses VARCHAR(500) NULL
)ENGINE=InnoDB;

CREATE TABLE tbl_technician(
    fk_technician_id INT PRIMARY KEY NOT NULL,
    salutation VARCHAR(50) NOT NULL,
    fk_qualification VARCHAR(100) NOT NULL,
    FOREIGN KEY(fk_technician_id)
        REFERENCES tbl_staff(pk_staff_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    FOREIGN KEY(fk_qualification)
        REFERENCES tbl_qualification(pk_qualification)
        ON UPDATE CASCADE
        ON DELETE CASCADE
)ENGINE=InnoDB;

CREATE TABLE tbl_admin(
    fk_admin_id INT PRIMARY KEY NOT NULL,
    salutation VARCHAR(50) NOT NULL,
    admin_position VARCHAR(100) NOT NULL,
    FOREIGN KEY (fk_admin_id)
        REFERENCES tbl_staff(pk_staff_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE
)ENGINE=InnoDB;
