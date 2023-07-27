#!/bin/bash

set -euo pipefail

DB_USER="root"
DB_PASSWORD="root"
DB_DATABASE="test"
DB_HOST="127.0.0.1"
DB_PORT="3306"

ROW_COUNT=1000000
CHUNK_SIZE=1000

# Drop table
mysql --defaults-file=.my.cnf -e "DROP TABLE IF EXISTS tbl;"

# Create table
mysql --defaults-file=.my.cnf -e "
CREATE TABLE IF NOT EXISTS tbl (
  \`id\` bigint unsigned NOT NULL AUTO_INCREMENT,
  \`col_1\` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  \`col_2\` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  \`col_3\` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  \`col_4\` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  \`col_5\` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  \`col_6\` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  \`col_7\` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  \`col_8\` tinyint(1) NOT NULL DEFAULT '1',
  \`col_9\` int NOT NULL,
  \`col_10\` int DEFAULT NULL,
  \`col_11\` datetime NOT NULL,
  \`col_12\` datetime DEFAULT NULL,
  \`col_13\` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  \`col_14\` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  \`col_15\` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (\`id\`),
  KEY \`idx_1\` (\`col_1\`,\`col_2\`,\`col_3\`),
  KEY \`idx_2\` (\`col_1\`,\`col_3\`),
  KEY \`idx_3\` (\`col_1\`,\`col_4\`),
  KEY \`idx_4\` (\`col_1\`,\`col_5\`),
  KEY \`idx_5\` (\`col_1\`,\`col_6\`),
  KEY \`idx_6\` (\`col_14\`)
)
"

for ((i=1; i<=$ROW_COUNT; i+=$CHUNK_SIZE))
do
  INSERT_QUERY="INSERT INTO tbl (
    col_1,
    col_2,
    col_3,
    col_4,
    col_5,
    col_6,
    col_7,
    col_8,
    col_9,
    col_10,
    col_11,
    col_12,
    col_15
  ) VALUES "
  for ((j=1; j<=$CHUNK_SIZE; j++))
  do
    INSERT_QUERY+="
      (
        'dummy_$i',
        'dummy_$i',
        'dummy_$i',
        'dummy_$i',
        'dummy_$i',
        'dummy_$i',
        'dummy_$i',
        1,
        $i,
        $i,
        NOW(),
        NOW(),
        NULL
      )
    "
    if [ $j -ne $CHUNK_SIZE ]; then
      INSERT_QUERY+=","
    fi
  done
  mysql --defaults-file=.my.cnf -e "$INSERT_QUERY;"
  echo "Inserted rows: $(( $i+$CHUNK_SIZE-1 ))"
done

echo "Done."
