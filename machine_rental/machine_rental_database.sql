DROP DATABASE IF EXISTS machine_rental;

CREATE DATABASE IF NOT EXISTS machine_rental;

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
		machine_type ENUM('Excavator', 'Truck'),
		manufacturer VARCHAR(15) NULL,
		driver_license ENUM('','L', 'C1', 'C'),
		repair_shop VARCHAR(25),
		daily_rate DECIMAL(5,2) NULL,
		km_rate DECIMAL(4,2) NULL,
		PRIMARY KEY(pk_type)
	)
ENGINE=InnoDB;

CREATE TABLE tbl_branch
	(
		pk_branch_identifier VARCHAR(30) NOT NULL,
		contact_person VARCHAR(30) NOT NULL,
		branch_city VARCHAR(25) NOT NULL,
		PRIMARY KEY (pk_branch_identifier)
	)
ENGINE=InnoDB;

CREATE TABLE tbl_machine
	(
		pk_machine_number VARCHAR(10) NOT NULL,
		fk_type VARCHAR(10) NOT NULL,
		license_plate VARCHAR(15) NULL,
		ready_for_use BOOLEAN NOT NULL,
		inspection_date DATE NOT NULL,
		purchase_date DATE NOT NULL,
		FOREIGN KEY (fk_type)
			REFERENCES tbl_machine_type(pk_type)
				ON UPDATE CASCADE
				ON DELETE RESTRICT,
		PRIMARY KEY(pk_machine_number)
	)
ENGINE=InnoDB;

CREATE TABLE tbl_rentals
	(
		fk_customer_id INT NOT NULL,
		fk_machine_number VARCHAR(10) NOT NULL,
		fk_branch VARCHAR(30) NOT NULL,
		rental_start DATE NOT NULL,
		rental_end DATE NULL,
		start_km INT NULL,
		end_km INT NULL,
		PRIMARY KEY(fk_machine_number, rental_start),
		FOREIGN KEY (fk_customer_id)
			REFERENCES tbl_customer(pk_id_customer)
				ON UPDATE RESTRICT
				ON DELETE RESTRICT,
		FOREIGN KEY (fk_machine_number)
			REFERENCES tbl_machine(pk_machine_number)
				ON UPDATE RESTRICT
				ON DELETE RESTRICT,
		FOREIGN KEY (fk_branch)
			REFERENCES tbl_branch(pk_branch_identifier)
				ON UPDATE RESTRICT
				ON DELETE RESTRICT
	)
ENGINE=InnoDB;
