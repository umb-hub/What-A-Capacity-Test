-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Versione server:              latest
-- S.O. server:                  Debian Arm-64bit
-- --------------------------------------------------------


-- Dump database dbapp
CREATE DATABASE IF NOT EXISTS `dbapp` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `dbapp`;

-- Dump table dbapp.tblone
CREATE TABLE IF NOT EXISTS `tblone` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) DEFAULT NULL,
  `value` varchar(128) DEFAULT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

DELIMITER $$
CREATE PROCEDURE generate_data()
BEGIN
  DECLARE i INT DEFAULT 0;
  WHILE i < 1000 DO
    INSERT INTO `tblone` (`name`,`value`,`timestamp`) VALUES (
      MD5(RAND()),
      ROUND(RAND()*100,2),
      FROM_UNIXTIME(UNIX_TIMESTAMP('2014-01-01 01:00:00')+FLOOR(RAND()*31536000))
    );
    SET i = i + 1;
  END WHILE;
END$$
DELIMITER ;

CALL generate_data();

