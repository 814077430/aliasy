DROP TABLE IF EXISTS t_general;
CREATE TABLE IF NOT EXISTS t_general (
  `id` int(20) unsigned NOT NULL AUTO_INCREMENT,
  `playerIncrId` int(20) unsigned NOT NULL DEFAULT '0',
  `unionIncrId` int(20) unsigned NOT NULL DEFAULT '0',
  `serverStartTime` bigint(20) unsigned NOT NULL DEFAULT '0',
  `serverStopTime` bigint(20) unsigned NOT NULL DEFAULT '0',

  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

DROP TABLE IF EXISTS t_user;
CREATE TABLE IF NOT EXISTS `t_user` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `account` varchar(50) binary CHARSET utf8 NOT NULL DEFAULT '',
  `uid` int(20) unsigned NOT NULL DEFAULT '0',
  `roleData` mediumblob,
  
  PRIMARY KEY (`id`),
  UNIQUE KEY `INDEX_PALYER_GUID` (`uid`)
  
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

DROP TABLE IF EXISTS t_union;
CREATE TABLE IF NOT EXISTS `t_union` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `unid` int(20) unsigned NOT NULL DEFAULT '0',
  `baseData` mediumblob,
  
  PRIMARY KEY (`id`),
  UNIQUE KEY `INDEX_UNION_GUID` (`unid`)
  
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;