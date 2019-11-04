import sqlite3

connection = sqlite3.connect("idk.db")                                     
cursor = connection.cursor()                                                    
cursor.execute("PRAGMA foreign_keys=ON;")                                       
connection.commit() 


# tids of all tenants who have a tenant in that suite
# during the year 1999-2002 (inclusive)

suit_id = input("Enter the suit id: ")

cursor.execute("""
           SELECT name, tID, yearOfOccup, unitNumber 
           FROM Tenants
           JOIN Suits USING(sID)
           WHERE yearOfOccup >= 1999 AND yearOfOccup <= 2002
           AND sID = ?
           ORDER BY name ASC
        """, (suit_id,))
result = cursor.fetchall()


for x in result:
    print(x)
