#!/bin/bash

set -euo pipefail

info() {
  printf "\e[32m%s\e[0m\n" "$1"
}

echo "Start."

mysql --defaults-file=.my.cnf -e "SELECT COUNT(*) FROM tbl;"

starttime=$(perl -MTime::HiRes -e 'printf("%.9f\n", Time::HiRes::time)')

# Add column
mysql --defaults-file=.my.cnf -e "ALTER TABLE tbl ADD COLUMN col_test BIGINT UNSIGNED AFTER col_2;"

endtime=$(perl -MTime::HiRes -e 'printf("%.9f\n", Time::HiRes::time)')
exectime=$(perl -e "printf('%.3f', ${endtime} - ${starttime})")

info "Execution time: ${exectime}s"

mysql --defaults-file=.my.cnf -e "SHOW COLUMNS FROM tbl;"

echo "Cleanup..."

mysql --defaults-file=.my.cnf -e "
  ALTER TABLE tbl DROP COLUMN col_test;
"

echo "Done."
