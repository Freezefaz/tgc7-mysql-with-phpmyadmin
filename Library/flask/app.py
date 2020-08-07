
from flask import Flask, render_template, request, redirect, url_for
import os
import pymysql


conn = pymysql.connect(
    host = "localhost",
    user=os.environ.get("C9_USER"),
    password="",
    database="lib"
)

app = Flask(__name__)

@app.route("/books/create")
def create_book():
    return render_template("create_books.template.html")

@app.route("/books/create", methods=["POST"])
def process_create_books():
    cursor = conn.cursor(pymysql.cursors.DictCursor)

    sql = """ insert into books (title) values (%s) """

    cursor.execute(sql, [
        request.form.get("title")
    ])

    conn.commit()
    return "Book Created"


# "magic code" -- boilerplate
if __name__ == '__main__':
    app.run(host=os.environ.get('IP'),
            port=int(os.environ.get('PORT')),
            debug=True)