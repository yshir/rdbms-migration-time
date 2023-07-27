# mysql80/r1m

- record count: 1,000,000
- column count: 15
- index count: 6

```sql
CREATE TABLE IF NOT EXISTS tbl (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `col_1` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `col_2` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `col_3` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `col_4` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `col_5` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `col_6` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `col_7` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `col_8` tinyint(1) NOT NULL DEFAULT '1',
  `col_9` int NOT NULL,
  `col_10` int DEFAULT NULL,
  `col_11` datetime NOT NULL,
  `col_12` datetime DEFAULT NULL,
  `col_13` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `col_14` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `col_15` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_1` (`col_1`,`col_2`,`col_3`),
  KEY `idx_2` (`col_1`,`col_3`),
  KEY `idx_3` (`col_1`,`col_4`),
  KEY `idx_4` (`col_1`,`col_5`),
  KEY `idx_5` (`col_1`,`col_6`),
  KEY `idx_6` (`col_14`)
);
```
