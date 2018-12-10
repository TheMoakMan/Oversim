from datetime import datetime
from flask import session

import pypyodbc 

connection = pypyodbc.connect("DRIVER={SQL SERVER}; Server=DESKTOP-LUMDSEC; Trusted_Connection=True; DATABASE=Oversim")

def make_user(usrData):
    cursor = connection.cursor()
    cursor.execute("select * from Users where username = \'" + usrData[0] + "\';")
    user = cursor.fetchall()
    cursor.close()

    #Check if User is in database
    print(user)
    for row in user:
      if str(usrData[0]) in row:
          if str(usrData[1]) in row:
            return 

    #Make a new user
    cursor = connection.cursor()
    cursor.execute("INSERT INTO Users VALUES (\'" + usrData[0] + "\' , \'" + usrData[1] + "\' , 0);")
    connection.commit()
    cursor.close()


def user_validation(usrData):
    #Query to see if usr is in database
    cursor = connection.cursor()
    cursor.execute("select * from Users where username = \'" + usrData[0] + "\';")
    user = cursor.fetchall()
    cursor.close()

    print(user)
    for row in user:
      if str(usrData[0]) in row:
          if str(usrData[1]) in row:
            print("Login Success")
            session['curr_user'] = usrData[0]

def add_team(teamData):
    cursor = connection.cursor()
    cursor.execute("select MAX(ID) from Team")
    curr_maxID = cursor.fetchall()
    cursor.close()

    #Check if User is in database
    for n in curr_maxID:
      for m in n:
          numTeams = int(m)
     
    print(numTeams)  
    new_max_ID = numTeams + 1

    #Make a new team
    cursor = connection.cursor()
    cursor.execute("INSERT INTO Team (ID, city, mascot, OWNER) VALUES (" + str(new_max_ID) + ", \'" + teamData[0] + "\' , \'" + teamData[1] + "\' , \'" + getUsername() + "\');")
    connection.commit()
    cursor.close()

    cursor = connection.cursor()
    cursor.execute("select ID from Team where city = \'" + teamData[0]+ "\' AND mascot = \'" + teamData[1] + "\';")
    teamID = cursor.fetchall()
    cursor.close()

    return teamID[0]

  
def getUsername():
    tempUser = ""
    if session.get('curr_user') != None: 
      tempUser = session.get('curr_user')
    else:
      tempUser = 'User'

    return tempUser

def remove_team(id):
    cursor = connection.cursor()
    cursor.execute("delete from IS_ON where team_ID = " + id + ";")
    cursor.execute("delete from Team where ID = " + id + ";")
    connection.commit()
    cursor.close()



