"""
Routes and views for the flask application.
"""

from datetime import datetime
from flask import Flask, render_template
app = Flask(__name__)

import pyodbc

Create Connection Object for SQL Server Connection
connection = pyodbc.connect("Server=tcp:oversim.database.windows.net,1433;Initial Catalog=OverSim;Persist Security Info=False;User ID=jaden2555@yahoo.com;Password=*TheMoakMan2014;MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;") 

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

@app.route('/teams.html')
def team():
    #Select all pro teams
    cursor = connection.cursor()
    cursor.execute("select * from Team where is_pro = 1;")
    results = cursor.fetchall()
    cursor.close()

    #Get players on those teams
    cursor = connection.cursor()
    cursor.execute("select ID, Player, Role, PlayerPhoto from Teams_All_Players where PRO = 1;")
    teams_Players = cursor.fetchall()
    cursor.close()

    """Renders the team page."""
    return render_template(
          "teams.html",
          username = curr_user,
          teamTable = results,
          teamPlayers = teams_Players
        )

@app.route('/heroes.html')
def heroes():
    cursor = connection.cursor()
    cursor.execute("select * from Hero")
    h_results = cursor.fetchall()
    cursor.close()

    """Renders the heroes page."""
    return render_template(
          "heroes.html",
          username = curr_user,
          heroTable = h_results,
          )

@app.route('/play.html')
def play_main_page():
    """Renders the play page."""
    return render_template(
          "play.html",
          username = curr_user
          )


@app.route('/players.html')
def players():
   #Select all players
    cursor = connection.cursor()
    cursor.execute("select * from All_Players_ON_Teams;")
    results = cursor.fetchall()
    cursor.close()

    """Renders the myteams page."""
    return render_template(
          "players.html",
          username = curr_user,
          playerTable = results
         )


@app.route('/myteam.html')
def myteams():
    #Select all users teams
    cursor = connection.cursor()
    cursor.execute("select * from Team where is_pro = 0 AND OWNER = \'" + curr_user + "\';")
    results = cursor.fetchall()
    cursor.close()

    #Get players on those teams
    cursor = connection.cursor()
    cursor.execute("""select ID, Player, Role, PlayerPhoto 
                      from Teams_All_Players where PRO = 0 AND OWNER = \'""" + curr_user + "\';")
    teams_Players = cursor.fetchall()
    cursor.close()

    """Renders the myteams page."""
    return render_template(
          "myteam.html",
          username = curr_user,
          teamTable = results,
          teamPlayers = teams_Players
         )

@app.route('/account.html')
def account():
    """Renders the account page."""
    return render_template(
          "account.html",
          username = curr_user
          )


