"""
Routes and views for the flask application.
"""

from datetime import datetime
from flask import Flask, render_template
app = Flask(__name__)

#Get current user from login table at somepoint from website
curr_user = "Doug"


@app.route('/')
@app.route('/home.html')
def home():
    """Renders the home page."""
    return render_template(
           "home.html",
           username = curr_user
        )

