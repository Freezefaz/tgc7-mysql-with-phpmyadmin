import pymysql
import os
#  pip3 install pymysql ***FIRST INSTALL THIS BEFORE ANYTHING ***


# get connection
# used throughout application only connect once
conn = pymysql.connect(
    host = "localhost",
    user=os.environ.get("C9_USER"),
    password="",
    database="classicmodels"
)

# create the cursor
# which is the mysql in the terminal
# from the database connection, create the cursor
cursor = conn.cursor(pymysql.cursors.DictCursor)

# store the sql statement in a variable for ease if use
officeCode = input("Which office code?: ")
# make sure its formatted string
sql = f"select * from employees where officecode = '{officeCode}'"

# execute the sql
cursor.execute(sql)

for each_employee in cursor:
    # """ """ allows special characters
    print(f"""Employee": {each_employee["employeeNumber"]}
        {each_employee["lastName"]}{each_employee["firstName"]}""")

