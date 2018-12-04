"""
Routes and views for the flask application.
"""

from datetime import datetime
from flask import render_template
from FlaskWebProject1 import app

import pypyodbc

#Create Connection Object for SQL Server Connection
connection = pypyodbc.connect("DRIVER={SQL SERVER}; Server=DESKTOP-LVNF7SR\Evan; Trusted_Connection=True; DATABASE=Oversim") 
cursor = connection.cursor()

hero_selection = "'Ana'"
cursor.execute("select * from Hero where name = \'Ana\';")

def get_username():
    

results = cursor.fetchall()

table = "|"
for tuple in results:
    for attribute in tuple:
        table += str(attribute) + "|"

print(table)

@app.route('/')
@app.route('/home.html')
def home():
    """Renders the home page."""
    return render_template(
           "home.html",
           username = "BIGGOOSE"
        )

@app.route('/teams.html')
def team():
    """Renders the team page."""
    return render_template(
          "teams.html",
          username = "10kGeese",
          team_0_city = "Dallas",
          team_0_mascot = "Fuel",
          team_1_city = "London",
          team_1_mascot = "Spitfire",
          info = "Pro Team"
        )

@app.route('/heroes.html')
def heroes():
    """Renders the heroes page."""
    return render_template(
          "heroes.html",
          username = "10kGeese"
          )

@app.route('/play.html')
def play_main_page():
    """Renders the play page."""
    return render_template(
          "play.html",
          username = "10kGeese"
          )


@app.route('/players.html')
def players():
    """Renders the players page."""
    return render_template(
          "players.html",
          username = "10kGeese"
          )


@app.route('/myteam.html')
def myteams():
    """Renders the myteams page."""
    return render_template(
          "myteam.html",
          username = "10kGeese"
         )

@app.route('/account.html')
def account():
    """Renders the account page."""
    return render_template(
          "account.html",
          username = "10kGeese"
          )


