#!/usr/bin/python3

import sqlite3

db = sqlite3.connect(':memory:')

cursor = db.cursor()

cursor.execute('''
        DROP TABLE *
        ''')
db.commit()

db.close()
