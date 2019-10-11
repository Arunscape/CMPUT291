tar: 
	tar -czf a2.tgz README.txt a2-data.sql a2-script.txt 1.sql 2.sql 3.sql 4.sql 5.sql 6.sql 7.sql 8.sql 9.sql 10.sql

clean: script
	rm -f a2.tgz a2.db
	sqlite3 a2.db < a2-tables.sql
	sqlite3 a2.db < a2-data.sql
	sqlite3 a2.db < a2-queries.sql > a2-script.txt
script:
	echo '.echo on' > a2-queries.sql
	bash -c 'for f in 1.sql 2.sql 3.sql 4.sql 5.sql 6.sql 7.sql 8.sql 9.sql 10.sql;
	do \
		cat f >> a2-queries.sql; \
		echo "\n" >> a2-queries.sql; \
	done'
