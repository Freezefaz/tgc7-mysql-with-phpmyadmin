
from flask import Flask, render_template, request, redirect, url_for
import os


app = Flask(__name__)

@app.route("/books/create")
def create_book():
    return render_template("create_books.template.html")



# "magic code" -- boilerplate
if __name__ == '__main__':
    app.run(host=os.environ.get('IP'),
            port=int(os.environ.get('PORT')),
            debug=True)