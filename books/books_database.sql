DROP DATABASE IF EXISTS books;
CREATE DATABASE books;
USE books;

CREATE TABLE tbl_publisher(
    pk_publisher VARCHAR(50) PRIMARY KEY
) ENGINE=InnoDB;

CREATE TABLE tbl_areas(
    pk_area VARCHAR(50) PRIMARY KEY,
    room VARCHAR(45)
) ENGINE=InnoDB;

CREATE TABLE tbl_books(
    pk_book_number INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(40),
    fk_area VARCHAR(50),
    isbn VARCHAR(40),
    fk_publisher VARCHAR(50),
    FOREIGN KEY(fk_area) 
        REFERENCES tbl_areas(pk_area) 
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    FOREIGN KEY(fk_publisher) 
        REFERENCES tbl_publisher(pk_publisher) 
        ON UPDATE CASCADE
        ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE tbl_reminder(
    pk_reminder_level VARCHAR(20) PRIMARY KEY,
    fee DECIMAL(10,2),
    reminder_level_info VARCHAR(60)
) ENGINE=InnoDB;

CREATE TABLE tbl_customer(
    pk_id_customer INT AUTO_INCREMENT PRIMARY KEY,
    customer_lastname VARCHAR(55),
    customer_firstname VARCHAR(55),
    iban VARCHAR(100),
    street_number VARCHAR(80),
    postal_location VARCHAR(66)
) ENGINE=InnoDB;

CREATE TABLE tbl_loan(
    pk_id_loan INT AUTO_INCREMENT PRIMARY KEY,
    loan_date DATE,
    return_due_date DATE,
    return_date DATE,
    fk_reminder_level VARCHAR(20),
    fk_customer INT,
    fk_book_number INT,
    FOREIGN KEY(fk_reminder_level) 
        REFERENCES tbl_reminder(pk_reminder_level) 
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    FOREIGN KEY(fk_customer) 
        REFERENCES tbl_customer(pk_id_customer) 
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    FOREIGN KEY(fk_book_number) 
        REFERENCES tbl_books(pk_book_number) 
        ON UPDATE CASCADE
        ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE tbl_event(
    pk_id_event INT AUTO_INCREMENT PRIMARY KEY,
    event_name VARCHAR(77),
    date DATE,
    topic VARCHAR(60)
) ENGINE=InnoDB;

CREATE TABLE tbl_author(
    pk_id_author INT AUTO_INCREMENT PRIMARY KEY,
    author_lastname VARCHAR(50),
    firstname VARCHAR(50),
    email VARCHAR(50)
) ENGINE=InnoDB;

CREATE TABLE tbl_event_detail(
    fk_author INT,
    fk_event INT,
    FOREIGN KEY(fk_author) 
        REFERENCES tbl_author(pk_id_author) 
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    FOREIGN KEY(fk_event) 
        REFERENCES tbl_event(pk_id_event) 
        ON UPDATE CASCADE
        ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE tbl_book_detail(
    fk_author INT,
    fk_number INT,
    FOREIGN KEY(fk_author) 
        REFERENCES tbl_author(pk_id_author) 
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    FOREIGN KEY(fk_number) 
        REFERENCES tbl_books(pk_book_number) 
        ON UPDATE CASCADE
        ON DELETE CASCADE
) ENGINE=InnoDB;
