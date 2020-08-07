# boilerplate code
# pip install Flask paste at control terminal
# Target the folder by going to it and open in terminal
# Then python3 app.py to open the browser

from flask import Flask, render_template, request, redirect, url_for
import os
import pymysql
import random

conn = pymysql.connect(
    host = "localhost",
    user=os.environ.get("C9_USER"),
    password="",
    database="classicmodels"
)

app = Flask(__name__)

@app.route("/employees")
def show_employees():
    cursor = conn.cursor(pymysql.cursors.DictCursor)
    cursor.execute("select * from employees")
    return render_template("all_employees.template.html", cursor=cursor)

@app.route("/offices")
def show_offices():
    cursor = conn.cursor(pymysql.cursors.DictCursor)
    cursor.execute("select * from offices")
    return render_template("all_offices.template.html", cursor=cursor)

@app.route("/offices/create")
def show_create_office_form():
    return render_template("create_office.template.html")

@app.route("/offices/create", methods=["POST"])
def process_create_office():
    cursor = conn.cursor(pymysql.cursors.DictCursor)
    # generate random office number as there is none
    officeCode = random.randint(100000, 999999)

    # FOR TESTING USE NOTEPAD
    #insert into offices (officeCode, city, phone, addressLine, addressLine2,
    # state, country, postalCode, territory)
    # values (1201, "Singapore", "777777", "Changi Business Park", "Postal Code 121", 
    # "na", "Singapore", "120100", "SEA")

    sql = """ 
        insert into offices (officeCode, city, phone, addressLine1, 
        addressLine2,state, country, postalCode, territory)
        values (%s, %s, %s, %s, %s, %s, %s, %s, %s)
    """
    
    # make sure the name on form is the same as here
    cursor.execute(sql,[
        officeCode,
        request.form.get("city"),
        request.form.get("phone"),
        request.form.get("addressLine1"),
        request.form.get("addressLine2"),
        request.form.get("state"),
        request.form.get("country"),
        request.form.get("postalCode"),
        request.form.get("territory")
    ])

    # to make the changes permanent
    conn.commit()
    return "done"

@app.route("/products/create")
def create_product():
    return render_template("create_product.template.html")

@app.route("/products/create", methods=["POST"])
def process_create_product():
    cursor = conn.cursor(pymysql.cursors.DictCursor)

    sql = """
        insert into productlines (productLine, textDescription)
        values (%s, %s)
    """

    cursor.execute(sql, [
        request.form.get("productLine"),
        request.form.get("textDescription")
    ])

    conn.commit()
    return "New product added"

@app.route("/employees/create")
def show_create_employees():
    cursor = conn.cursor(pymysql.cursors.DictCursor)
    cursor.execute("select officeCode, city from offices")
    return render_template("create_employees.template.html")

# SELECT NOT WORKING
@app.route("/employees/create", methods=["POST"])
def process_show_create_employees():
    cursor = conn.cursor(pymysql.cursors.DictCursor)
    sql = """
        insert into employees (employeeNumber, firstName, lastName,
        extension, email, officeCode, jobtitle)
        values (%s, %s, %s, %s, %s, %s, %s)
    """

    employeeNumber = random.randint(100000, 999999)

    cursor.execute(sql, [
        officeCode,
        request.form.get("firstName"),
        request.form.get("lastName"),
        request.form.get("extension"),
        request.form.get("email"),
        request.form.get("officeCode"),
        request.form.get("jobtitle"),
    ])
    print(cursor._last_executed)

    conn.commit()
    return "New Employee added"

# CREATE HTML FOR THE REST
@app.route("/employeed/edit/<employeeNumber>")
def show_edit_employee_form(employeeNumber):
    cursor = conn.cursor(pymysql.cursors.DictCursor)
    cursor.execute("select * from employees where employeeNumber= %s", employeeNumber))
    employee = cursor.fetchone()
        

    officeCursor = conn.cursor(pymysql.cursors.DictCursor)
    ofiiceCursor.execute("select * from offices")

    return render_template("edit_employee.template.html",
        employee=employee, offices=officeCursor)


@app.route("/employees/edit/<employeeNumber>", methods=["POST"])
def process_edit_employee(employeeNumber):
    cursor = conn.cursor(pymysql.cursors.DictCursor)

    sql = """ 
        update employees set lastName=%s, firstName=%s, extension=%s, email=%s,
        officeCode=%s, jobTitle=%s where employeeNumber=%s
    """

     cursor.execute(sql, [
        request.form.get("firstName"),
        request.form.get("lastName"),
        request.form.get("extension"),
        request.form.get("email"),
        request.form.get("officeCode"),
        request.form.get("jobtitle"),
        employeeNumber
    ])

    conn.commit()
    return "Done"


    @app.route("/employees/delete/<employeeNumber>")
    def show_delete_employee_confirmation(employeeNumber):
        cursor = conn.cursor(pymysql.cursors.DictCusor)
        cursor.execute("select * from employees where employeeNumber = %s",
            employeeNumber)
        employee =cursor.fetchone()

        return render_template("delete_employee_confirmation.template.html",
            employee=employee)


    def create_cursor():
        return conn.cursor(pymysql.cursors.DictCusor)

    @app.route("/employees/delete/<employeeNumber>", methods=["POST"])
    def process_delete_employee(employeeNumber):
        cursor = conn.cursor(pymysql.cursors.DictCusor)
        cursor.execute("delete from employees where employeeNumber=%s",
                        employeeNumber)
        
        conn.commit()
        return "employee deleted"

# "magic code" -- boilerplate
if __name__ == '__main__':
    app.run(host=os.environ.get('IP'),
            port=int(os.environ.get('PORT')),
            debug=True)