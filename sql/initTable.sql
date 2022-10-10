DROP TABLE IF EXISTS t_general;
CREATE TABLE IF NOT EXISTS t_general (
  `id` int(20) unsigned NOT NULL AUTO_INCREMENT,
  `incrId` int(20) unsigned NOT NULL DEFAULT '0',
  `unionIncrID` int unsigned NOT NULL DEFAULT '0',
  `serverStartTime` bigint(20) unsigned NOT NULL DEFAULT '0',

  PRIMARY KEY (`id`)
)ENGINE = INNODB DEFAULT CHARSET=utf8;

/*t_user t_guest表结构一样*/
DROP TABLE IF EXISTS t_user;
CREATE TABLE IF NOT EXISTS `t_user` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `acc` varchar(50) binary CHARSET utf8 NOT NULL DEFAULT '',
  `uid` int(20) unsigned NOT NULL DEFAULT '0',
  `roleData` mediumblob,
  
  PRIMARY KEY (`id`),
  UNIQUE KEY `INDEX_PALYER_GUID` (`uid`)
  
) ENGINE=InnoDB DEFAULT CHARSET=utf8;