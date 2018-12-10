"""
Routes and views for the flask application.
"""

from datetime import datetime
from flask import render_template, request, redirect, session

from FlaskWebProject1 import app
from FlaskWebProject1 import functions

import pypyodbc 

connection = pypyodbc.connect("DRIVER={SQL SERVER}; Server=DESKTOP-LUMDSEC; Trusted_Connection=True; DATABASE=Oversim")

@app.route('/')
@app.route('/home.html')
def home():
    cursor = connection.cursor()
    cursor.execute("SELECT MAX(win_rate), city, mascot, logo, OWNER FROM Team_Win_Rate Group By city, mascot, logo, OWNER;")
    team = cursor.fetchall()
    cursor.close()

    #Find Player name with highest average elims and winrate between all heroes
    cursor = connection.cursor()
    cursor.execute("SELECT MAX(score), battletag, player_avg_elims, overall_win_rate FROM Avg_Player_Stats Group by battletag, player_avg_elims, overall_win_rate;")
    player = cursor.fetchall()
    cursor.close()

    #Find the Hero with the highest popularity
    cursor = connection.cursor()
    cursor.execute("SELECT MAX(hero_pick_rate), name, photo FROM Hero Group by name, photo;")
    hero = cursor.fetchall()
    cursor.close()

    for n in team:
      bestTeam = n

    for n in player:
        bestPlayer = n

    for n in hero:
        bestHero = n
    print(bestHero)

   
    return render_template(
           "home.html",
           username = functions.getUsername(),
           bestTeam = team, 
           bestPlayer = player, 
           mostPopularHero = hero
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
          username = functions.getUsername(),
          teamTable = results,
          teamPlayers = teams_Players
        )

@app.route('/heroes.html')
def heroes():
    cursor = connection.cursor()
    cursor.execute("select * from Hero")
    hTable = cursor.fetchall()
    cursor.close()
    
    cursor = connection.cursor()
    cursor.execute("select hero_name, ability_name, ability_desc from All_Hero_Info;")
    aTable = cursor.fetchall()
    cursor.close()

    """Renders the heroes page."""
    return render_template(
          "heroes.html",
          username = functions.getUsername(),
          heroTable = hTable,
          abilityTable = aTable
          )

@app.route('/play.html')
def play_main_page():
    """Renders the play page."""
    return render_template(
          "play.html",
          username =functions.getUsername()
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
          username = functions.getUsername(),
          playerTable = results
         )


@app.route('/myteam.html')
def myteams():
    #Select all users teams
    cursor = connection.cursor()
    cursor.execute("select * from Team where is_pro = 0 AND OWNER = \'" + functions.getUsername() + "\';")
    results = cursor.fetchall()
    cursor.close()

    #Get players on those teams
    cursor = connection.cursor()
    cursor.execute("""select ID, Player, Role, PlayerPhoto 
                      from Teams_All_Players where PRO = 0 AND OWNER = \'""" + functions.getUsername() + "\';")
    teams_Players = cursor.fetchall()
    cursor.close()

    """Renders the myteams page."""
    return render_template(
          "myteam.html",
          username = functions.getUsername(),
          teamTable = results,
          teamPlayers = teams_Players 
         )

@app.route('/deleteTeam.html', methods=['GET'])
def rmvTeam():
    id = request.args.get('id')
    
    functions.remove_team(id)

    return redirect("myteam.html") 


@app.route('/editTeam.html', methods=['GET'])
def edtTeam():
    id = request.args.get('id')
    session['curr_team'] = id

    #Get all players
    cursor = connection.cursor()
    cursor.execute("select battletag from Player")
    allPlayers = cursor.fetchall()
    cursor.close()

    #Query up team info for teamID = ID
    cursor = connection.cursor()
    cursor.execute("select ID, Team, Player, PlayerPhoto from Teams_All_Players where ID = " + id + ";")
    playerTable = cursor.fetchall()
    cursor.close()
     
    #Query up team info for teamID = ID
    cursor = connection.cursor()
    cursor.execute("select city, mascot from Team where ID = " + id)
    teamName = cursor.fetchall()
    cursor.close()

    if len(playerTable) == 0:
        return redirect("/addplayers.html")

    #Show players on team and allow editing of each player.
    print(teamName)
    tName = teamName[0][0] + " " + teamName[0][1]

    return render_template("editTeam.html", 
                           username = functions.getUsername(),
                           allPlayers = allPlayers,
                           playerTable = playerTable,
                           teamname = tName
                           )

@app.route('/deletePlayer.html', methods=['GET'])
def rmvPlayer():
    id = request.args.get('id')
    tag = request.args.get('tag')


    #Remove said player
    print("FROM DELETE PLAYER")
    
    print([tag, id])


    print("delete from IS_ON where team_ID = " + id + " and player_battletag = \'" + tag + "\';")

    cursor= connection.cursor()
    cursor.execute("delete from IS_ON where team_ID = " + id + " and player_battletag = \'" + tag + "\';")
    connection.commit()
    cursor.close()


    return redirect("myteam.html")

@app.route('/replacePlayer.html', methods=['GET'])
def rplcPlayer():
    teamID = session.get('curr_team')

    oTag = request.args.get('oldTag')
    nTag = request.args.get('newTag')

    print([oTag, nTag])

    #Remove the older player and add the new player
    cursor= connection.cursor()
    cursor.execute("delete from IS_ON where team_ID = " + teamID + " and player_battletag = \'" + oTag + "\';")
    cursor.execute("insert into IS_ON values (\'" + nTag + "\', " + teamID + ";)")
    connection.commit()
    cursor.close()

    return redirect("/myteam.html")


@app.route('/login.html')
def login():
    """Renders the account page."""
    return render_template(
          "login.html",
          username = functions.getUsername()
          )

@app.route('/login.html', methods=['POST'])
def login_process():
  
    usrname = request.form['user']
    pssword = request.form['pass']

    usrData = (usrname, pssword)
    
    functions.user_validation(usrData)

    return redirect ("/home.html")

@app.route('/signup.html')
def signupPage():
    """Renders the account page."""
    return render_template(
          "signup.html",
          username = functions.getUsername()
          )

@app.route('/signup.html', methods=['POST'])
def signup():
    """Renders the account page."""
    usrname = request.form['user']
    pssword = request.form['pass']

    usrData = (usrname, pssword)
    functions.make_user(usrData) 

    return redirect ("/home.html")

@app.route('/addplayers.html')
def addPage():
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

    #Get all players
    cursor = connection.cursor()
    cursor.execute("select battletag from Player")
    allPlayers = cursor.fetchall()
    cursor.close()

    return render_template(
          "addplayers.html",
          username = functions.getUsername(),
          allPlayers = allPlayers,
          teamTable = results,
          teamPlayers = teams_Players
        )

@app.route('/addplayers.html', methods=['POST'])
def getPlayers():
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

    #Check if adding players to an existing team
    if session.get('curr_team') != None: 
        teamNO = session.get('curr_team')
        session.pop('curr_team')
    else:
        #Get ID for the newest team
        cursor = connection.cursor()
        cursor.execute("select MAX(ID) from Team;")
        teamID = cursor.fetchall()
        cursor.close()

        for n in teamID:
          for m in n:
            teamNO = m

        teamNO = str(teamNO)

    print(teamNO)

    #Populate Team with Players
    playerNames = []
    for i in range(0,6):
        p = 'p' + str(i)
        playerNames.append(request.form[p])
        
    print(playerNames)

    for i in range(0,6):
        cursor = connection.cursor()
        cursor.execute("insert into IS_ON values (\'" + playerNames[i] + "\', " + teamNO + ");")
        connection.commit()
        cursor.close()
  

    return redirect("/myteam.html")

@app.route('/createteams.html')
def makeTeamName():

    return render_template(
          "createteams.html",
          username = functions.getUsername()
        )

@app.route('/createteams.html', methods=['POST'])
def getTeamName():
  
    newCity = request.form['city']
    newMascot = request.form['mascot']

    teamName = (newCity, newMascot)
    
    #Add new team to database 
    teamID = functions.add_team(teamName)

    return redirect("addplayers.html")

@app.route('/addToTeam.html', methods=['POST'])
def addPlayerToTeam():
    
    player = request.form['selectPlayer']
    print(player)

    return redirect("editTeam.html")



