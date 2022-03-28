-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Versione server:              10.1.31-MariaDB - mariadb.org binary distribution
-- S.O. server:                  Win32
-- HeidiSQL Versione:            10.2.0.5599
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


-- Dump database dbapp
CREATE DATABASE IF NOT EXISTS `dbapp` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `dbapp`;

-- Dump table dbapp.tblone
CREATE TABLE IF NOT EXISTS `tblone` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) DEFAULT NULL,
  `description` varchar(128) DEFAULT NULL,
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

-- Dump table dbapp.tbltwo
CREATE TABLE IF NOT EXISTS `tbltwo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `oneId` int(11) NOT NULL,
  `val` varchar(64) DEFAULT NULL,
  `unixtime` int(11) NOT NULL,
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

