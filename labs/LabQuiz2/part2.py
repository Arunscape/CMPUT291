import sqlite3

connection = sqlite3.connect("idk.db")                                     
cursor = connection.cursor()                                                    
cursor.execute("PRAGMA foreign_keys=ON;")                                       
connection.commit() 


# tids of all tenants who have a tenant in that suite
# during the year 1999-2002 (inclusive)

budget = input("Enter the budget amount: ")
suit_type = input("Enter the suit type: ")

cursor.execute("DROP TABLE IF EXISTS selected_suits")
cursor.execute("SELECT * FROM Suits")

col_tuples = cursor.description

#def dictionary_factory (cursor, row): #Always takes these two arguments.
#    dict = {}
#    for i, col in enumerate(cursor.description):
#    dict[col[0]] = row[i]
#    return dict

cols = ()

for c in col_tuples:
    cols += (c[0],)

#print(cols)
#('sID', 'type', 'unitNumber', 'price', 'aID')

idk = ""
for c in cols:
    idk += f"{c} TEXT,"

idk = idk[:-1]
#print(idk)


cursor.execute(f"""
        CREATE TABLE IF NOT EXISTS selected_suits(
            {idk}
            )
            """)


print(f"budget {budget}")
print(f"type {suit_type}")

print(f"""
        INSERT INTO selected_suits
        SELECT * FROM Suits
        WHERE price <= {budget}
        AND type LIKE '{type}'
        """)


cursor.execute(f"""
        INSERT INTO selected_suits
        SELECT * FROM Suits
        WHERE price <= {budget}
        AND type LIKE '{suit_type}'
        """
        )
connection.commit()
cursor.execute("SELECT * FROM selected_suits")

result = cursor.fetchall()

for x in result:
    print(x)
