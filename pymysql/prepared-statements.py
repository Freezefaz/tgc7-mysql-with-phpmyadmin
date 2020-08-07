# Prepared statement is meant to make it harder to do sql injection as the data has been defined for 1 data type

# Need tjhe following dependencies
#  pip3 install pymysql

import pymysql
import os

# 1. create connection
conn = pymysql.connect(
    host=os.environ.get("IP"),
    user=os.environ.get("C9_USER"),
    password="",
    database="classicmodels"
)

# 2. create the cursor
cursor = conn.cursor(pymysql.cursors.DictCursor)

# 3. write the sql query
country = input("Which country?: ")
credit_limit = input("Minimal credit limit: ")
sql = "select * from customers where country like %s and creditLimit >= %s"

# 4. execute the query
cursor.execute(sql, [country, credit_limit])

for customer in cursor:
    print(customer["customerName"])

# 5. resuse the cursor
cursor.execute("select * from offices where country=%s", country)
print("")
print("Office: ")
for each_office in cursor:
    print(each_office["addressLine1"],
        each_office["addressLine2"], each_office["city"])
