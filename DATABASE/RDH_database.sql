/*
SQLyog Community v8.71 
MySQL - 5.5.30 : Database - vtjim07_25
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`vtjim07_25` /*!40100 DEFAULT CHARACTER SET latin1 */;

USE `vtjim07_25`;

/*Table structure for table `master_key_requests` */

DROP TABLE IF EXISTS `master_key_requests`;

CREATE TABLE `master_key_requests` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(100) NOT NULL,
  `status` varchar(255) DEFAULT NULL,
  `request_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

/*Data for the table `master_key_requests` */

insert  into `master_key_requests`(`id`,`username`,`status`,`request_time`) values (1,'userk',NULL,'2025-10-23 16:47:11'),(2,'userk','approved: c2VlZDpjODVhYzRlYjZlMGZkMGNl','2025-10-23 16:49:30');

/*Table structure for table `rdh_files` */

DROP TABLE IF EXISTS `rdh_files`;

CREATE TABLE `rdh_files` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uploader` varchar(100) NOT NULL,
  `receiver` varchar(100) NOT NULL,
  `original_filename` varchar(255) DEFAULT NULL,
  `enc_filename` varchar(255) DEFAULT NULL,
  `stego_filename` varchar(255) DEFAULT NULL,
  `master_key` varchar(128) DEFAULT NULL,
  `hidden_text` text,
  `shared_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `rdh_files` */

/*Table structure for table `shared_images` */

DROP TABLE IF EXISTS `shared_images`;

CREATE TABLE `shared_images` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sender_id` int(11) NOT NULL,
  `receiver_id` int(11) NOT NULL,
  `image_data` longblob NOT NULL,
  `filename` varchar(100) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `sender_id` (`sender_id`),
  KEY `receiver_id` (`receiver_id`),
  CONSTRAINT `shared_images_ibfk_1` FOREIGN KEY (`sender_id`) REFERENCES `users` (`id`),
  CONSTRAINT `shared_images_ibfk_2` FOREIGN KEY (`receiver_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `shared_images` */

/*Table structure for table `users` */

DROP TABLE IF EXISTS `users`;

CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(100) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

/*Data for the table `users` */

insert  into `users`(`id`,`username`,`password_hash`) values (1,'userk','e0bf050bf0c57007b4d5394d131e3612ce0dc1b3a26352f9b30a15577110f843'),(2,'userq','3d95bdc56c1f3c518cd34702a21682dd56265fb734478f7e2f90531c74fb6139');

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
