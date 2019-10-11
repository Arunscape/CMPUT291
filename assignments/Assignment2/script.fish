#!/bin/fish
rm -f a2.db
sqlite3 a2.db < a2-tables.txt
sqlite3 a2.db < a2-data.sql

echo '.echo on' > a2-queries.sql
for x in (seq 10)
	cat $x.sql >> a2-queries.sql
end
sqlite3 a2.db < a2-queries.sql > a2-script.txt
