SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";

DROP TABLE IF EXISTS `borrow_book`;
DROP TABLE IF EXISTS `return_book`;
DROP TABLE IF EXISTS `report`;
DROP TABLE IF EXISTS `user_log`;
DROP TABLE IF EXISTS `penalty`;
DROP TABLE IF EXISTS `allowed_days`;
DROP TABLE IF EXISTS `allowed_book`;
DROP TABLE IF EXISTS `barcode`;
DROP TABLE IF EXISTS `book`;
DROP TABLE IF EXISTS `user`;
DROP TABLE IF EXISTS `admin`;

CREATE TABLE `admin` (
  `admin_id` int NOT NULL AUTO_INCREMENT,
  `firstname` varchar(100) NOT NULL,
  `middlename` varchar(100),
  `lastname` varchar(100) NOT NULL,
  `email_id` varchar(100),
  `contact` varchar(15),
  `username` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `confirm_password` varchar(255) NOT NULL,
  `admin_image` varchar(255),
  `admin_type` varchar(20) DEFAULT 'Admin',
  `admin_added` datetime NOT NULL,
  PRIMARY KEY (`admin_id`)
);

INSERT INTO `admin` VALUES
(1,'Noor',NULL,'alrowaiei','noor.alrowaiei00@gmail.com',NULL,'admin','admin123','admin123',NULL,'Admin','2025-11-26 10:00:00');

CREATE TABLE `allowed_book` (
  `allowed_book_id` int NOT NULL AUTO_INCREMENT,
  `qntty_books` int NOT NULL,
  PRIMARY KEY (`allowed_book_id`)
);

INSERT INTO `allowed_book` VALUES (1,3);

CREATE TABLE `allowed_days` (
  `allowed_days_id` int NOT NULL AUTO_INCREMENT,
  `no_of_days` int NOT NULL,
  PRIMARY KEY (`allowed_days_id`)
);

INSERT INTO `allowed_days` VALUES (1,7);

CREATE TABLE `barcode` (
  `barcode_id` int NOT NULL AUTO_INCREMENT,
  `pre_barcode` varchar(20),
  `mid_barcode` int,
  `suf_barcode` varchar(20),
  PRIMARY KEY (`barcode_id`)
);

INSERT INTO `barcode` VALUES
(1,'KIT',1000,'VNS'),
(2,'KIT',1001,'VNS'),
(3,'KIT',1002,'VNS'),
(4,'KIT',1003,'VNS'),
(5,'KIT',1004,'VNS');

CREATE TABLE `book` (
  `book_id` int NOT NULL AUTO_INCREMENT,
  `book_title` varchar(255) NOT NULL,
  `category` varchar(100),
  `author` varchar(255),
  `author_2` varchar(255),
  `author_3` varchar(255),
  `author_4` varchar(255),
  `author_5` varchar(255),
  `book_pub` varchar(255),
  `publisher_name` varchar(255),
  `isbn` varchar(50),
  `copyright_year` varchar(10),
  `status` varchar(20),
  `book_barcode` varchar(100) NOT NULL,
  `book_image` varchar(255),
  `date_added` datetime NOT NULL,
  `remarks` varchar(100),
  PRIMARY KEY (`book_id`)
);

INSERT INTO `book` VALUES
(1,'The C Programming Language','School of ICT','Brian W. Kernighan','Dennis M. Ritchie',NULL,NULL,NULL,'Prentice Hall','Prentice Hall PTR','978-0131103627','1988','New','KIT1001VNS','ANSI.jpg','2025-11-28 09:00:00','Available'),
(2,'Introduction to Algorithms','School of ICT','Thomas H. Cormen','Charles E. Leiserson','Ronald L. Rivest','Clifford Stein',NULL,'MIT Press','The MIT Press','978-0262033848','2009','New','KIT1002VNS','Digital-Design.jpg','2025-11-28 09:05:00','Available'),
(3,'Mechanical Engineering Design','School of Engineering','Joseph E. Shigley','Charles R. Mischke',NULL,NULL,NULL,'McGraw-Hill','McGraw-Hill Education','978-0073398204','2014','New','KIT1003VNS','9788131762318.jpg','2025-11-28 09:10:00','Not Available');

CREATE TABLE `user` (
  `user_id` int NOT NULL AUTO_INCREMENT,
  `roll_number` varchar(50) NOT NULL,
  `firstname` varchar(100) NOT NULL,
  `middlename` varchar(100),
  `lastname` varchar(100) NOT NULL,
  `contact` varchar(15),
  `gender` varchar(10),
  `type` varchar(20),
  `branch` varchar(50),
  `user_added` datetime NOT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE (`roll_number`),
  UNIQUE (`contact`)
);

INSERT INTO `user` VALUES
(1,'ICT001','Ahmed',NULL,'Muhammad','8877665544','Male','Student','School of ICT','2025-11-27 11:00:00'),
(2,'ENG001','Zahra',NULL,'Hassan','8877665533','Female','Student','School of Engineering','2025-11-27 11:02:00');

CREATE TABLE `borrow_book` (
  `borrow_book_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `book_id` int NOT NULL,
  `date_borrowed` datetime NOT NULL,
  `due_date` datetime NOT NULL,
  `date_returned` datetime,
  `borrowed_status` varchar(20),
  `book_penalty` varchar(100),
  PRIMARY KEY (`borrow_book_id`),
  FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`),
  FOREIGN KEY (`book_id`) REFERENCES `book` (`book_id`)
);

INSERT INTO `borrow_book` VALUES
(1,1,3,'2025-11-01 14:00:00','2025-11-08 14:00:00',NULL,'borrowed','0');

CREATE TABLE `penalty` (
  `penalty_id` int NOT NULL AUTO_INCREMENT,
  `penalty_amount` decimal(10,2) NOT NULL,
  PRIMARY KEY (`penalty_id`)
);

INSERT INTO `penalty` VALUES (1,5.00);

CREATE TABLE `report` (
  `report_id` int NOT NULL AUTO_INCREMENT,
  `book_id` int NOT NULL,
  `user_id` int NOT NULL,
  `admin_name` varchar(255) NOT NULL,
  `detail_action` varchar(100) NOT NULL,
  `date_transaction` datetime NOT NULL,
  PRIMARY KEY (`report_id`)
);

INSERT INTO `report` VALUES
(1,1,2,'Noor alrowaiei','Borrowed Book','2025-11-01 10:00:00'),
(2,1,2,'Noor alrowaiei','Returned Book','2025-11-04 12:00:00'),
(3,3,1,'Noor alrowaiei','Borrowed Book','2025-11-01 14:00:00');

CREATE TABLE `return_book` (
  `return_book_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `book_id` int NOT NULL,
  `date_borrowed` datetime NOT NULL,
  `due_date` datetime NOT NULL,
  `date_returned` datetime NOT NULL,
  `book_penalty` varchar(100),
  PRIMARY KEY (`return_book_id`)
);

INSERT INTO `return_book` VALUES
(1,2,1,'2025-11-01 10:00:00','2025-11-05 10:00:00','2025-11-04 12:00:00','0');

CREATE TABLE `user_log` (
  `user_log_id` int NOT NULL AUTO_INCREMENT,
  `firstname` varchar(100),
  `middlename` varchar(100),
  `lastname` varchar(100),
  `admin_type` varchar(20),
  `date_log` datetime NOT NULL,
  PRIMARY KEY (`user_log_id`)
);

INSERT INTO `user_log` VALUES
(1,'Noor',NULL,'alrowaiei','Admin','2025-11-01 09:00:00'),
(2,'Noor',NULL,'alrowaiei','Admin','2025-11-03 01:10:18');

COMMIT;
