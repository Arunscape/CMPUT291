#!/bin/fish
echo '.echo on' > a2-queries.sql
for x in (seq 10)
	cat $x.sql >> a2-queries.sql
end
sqlite3 a2.db < a2-queries.sql > a2-script.txt
