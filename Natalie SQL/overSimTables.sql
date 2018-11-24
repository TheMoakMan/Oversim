/*
Natalie Holl, Elise Schillinger, Evan Moak
Fall 2018 CS 2300 Section B
Moria Miners

Table Initializations for the OverSim database
*/

-- Create a constant for standard max and min string length
SET @MAX_CHAR = 20;
SET @MAX_FILE_PATH = 200;
SET @MIN_CHAR = 3;

/*------------------------------------User------------------------------------*/
-- Create a table to represent a user of the application with the following variables:
-- username: primary key, unique ID for each user, check length <= 20 & >= 5
-- password: not null, log in verification for users, , check length <= 20 & >= 5
-- is_admin: denote the user as an administrator or as a general user, admins given special privileges
CREATE TABLE User (
  username VARCHAR(@MAX_CHAR) check(username <= @MAX_CHAR AND username >= @MIN_CHAR),
  password VARCHAR(@MAX_CHAR) NOT NULL check(username <= @MAX_CHAR AND username >= @MIN_CHAR),
  is_admin BOOLEAN NOT NULL default(false),
  PRIMARY KEY(username)
);

/*------------------------------------OWNS------------------------------------*/
-- Relation originally for linking user to a team, changed to attribute on team

/*------------------------------------Team------------------------------------*/
-- Create a table to represent a competitive team in Overwatch with the following variables:
-- ID: backend identification to more easily identify teams than by the combo of two variables, reference easier
-- city: unique name in combination with mascot, check length <= 20 & >= 5
-- mascot: unique name in combination with city, check length <= 20 & >= 5
-- logo: filepath for image to represent the team, not required, default is Overwatch logo
-- num_wins: track number of wins a team accumulates, default 0, must be >= 0
-- num_losses: track number of losses a team accumulates, default 0, must be >= 0
-- is_pro: flag team as a pro team or as a fantasy team, default false
-- num_players: track number of players on a team, must be <= 6 and >= 0 -----might make it easier to track here-----don't know if better in a view??
-- OWNER: foreign key to primary key of user, indicates which user created the team
CREATE TABLE Team (
  ID INTEGER check(ID >= 0),
  city VARCHAR(@MAX_CHAR) NOT NULL check(username <= @MAX_CHAR AND username >= @MIN_CHAR),
  mascot VARCHAR(@MAX_CHAR) NOT NULL check(username <= @MAX_CHAR AND username >= @MIN_CHAR),
  logo VARCHAR(@MAX_FILE_PATH) default('https://wiki.gamedetectives.net/images/b/bf/Overwatch_logo.jpg'),
  num_wins INTEGER default(0) check(num_wins >= 0),
  num_losses INTEGER default(0) check(num_wins >= 0),
  is_pro BOOLEAN NOT NULL default(false),
  num_players INTEGER default(0) check(num_players <= 6 AND num_players >= 0),
  OWNER VARCHAR(@MAX_CHAR) REFERENCES User(username),
  PRIMARY KEY(ID),
  UNIQUE(city, mascot)
);

/*------------------------------COMPETES_AGAINST------------------------------*/
-- Create a table to represent two teams competing against each other with the following variables:
-- A_ID: foreign key to primary key of a team
-- B_ID: foreign key to primary key of another team
-- date_time: timestamp for when a competition was held, forms primary key in combination with team names
CREATE TABLE COMPETES_AGAINST (
  A_ID INTEGER REFERENCES Team(ID),
  B_ID INTEGER REFERENCES Team(ID),
  date_time TIMESTAMP,
  PRIMARY KEY(A_ID, B_ID, date_time)
);


/*-----------------------------------Player-----------------------------------*/
-- Create a table to represent a professional player in Overwatch with the following variables:
-- battletag: primary key for player, is a gaming ID given to players of Blizzard games (Overwatch creator)
-- role: marks the player as someone who prefers damage dealer ('d'), healer ('h'), or tank ('t')
-- photo: filepath for image to represent the player, not null, default value is blank profile picture
CREATE TABLE Player (
  battletag VARCHAR(@MAX_CHAR) check(battletag <= @MAX_CHAR AND battletag >= @MIN_CHAR),
  role CHAR(1) NOT NULL check(role == 'd' OR role == 'h' OR role == 't'),
  photo VARCHAR(@MAX_FILE_PATH) NOT NULL default('http://pm1.narvii.com/6737/db298b04acebf4d50363b36d92c9c8f50b67520cv2_00.jpg'),
  PRIMARY KEY(battletag)
);

/*------------------------------------IS_ON-----------------------------------*/
-- Create a table to reprsent a relationship between players and teams
-- Required because a player can be on many teams, but only one with team.is_pro = true
-- player_battletag: reference to a player
-- team_ID: reference to a team primary key
CREATE TABLE IS_ON (
  player_battletag VARCHAR(@MAX_CHAR) REFERENCES Player(battletag),
  team_ID INTEGER REFERENCES Team(ID),
  PRIMARY KEY(player_battletag, team_ID)
);

/*------------------------------------Hero------------------------------------*/
-- Create a table to represent a hero in Overwatch with the following variables:
-- name: primary key, name of a playable character from Overwatch
-- hero_win_rate: overall win rate across all players who play the hero (not calculated, for user info)
-- hero_pick_rate: how often a hero is picked in competitive games (not calculated, for user info)
-- photo: unique filepath for image to represent the hero, required
-- role: marks the hero as damage dealer ('d'), healer ('h'), or tank ('t')
-- healing: overall average healing a healer outputs per 10 minutes (not calculated, for user info)
-- damage: overall average damage a damage dealer outputs per 10 minutes (not calculated, for user info)
-- block: overall average damage a tank blocks per 10 minutes (not calculated, for user info)
-- Most values stored in hero are for the user's information
-- They can research stats and pick the best heroes for their players
CREATE TABLE Hero (
  name VARCHAR(@MAX_CHAR) check(name <= @MAX_CHAR AND name >= @MIN_CHAR),
  hero_win_rate FLOAT check(hero_win_rate <= 1 AND hero_win_rate >= 0),
  hero_pick_rate FLOAT check(hero_pick_rate <= 1 AND hero_pick_rate >= 0),
  photo VARCHAR(@MAX_FILE_PATH) UNIQUE NOT NULL,
  role CHAR(1) NOT NULL check(role == 'd' OR role == 'h' OR role == 't'),
  healing INTEGER check(healing >= 0),
  damage INTEGER check(damage >= 0),
  block INTEGER check(block >= 0),
  PRIMARY KEY(name)
);

/*------------------------------------PLAYS-----------------------------------*/
-- Create a table to reprsent a relationship between players playing heroes
-- These are heroes that players play often in the Overwatch esports league
-- player_battletag: reference to a player
-- hero_name: reference to a hero
-- player_win_rate: average player win rate on a specific hero (used for calculations)
-- avg_elims: average number of kills/assists a player gets on a specific hero (used for calculations)
CREATE TABLE PLAYS (
  player_battletag VARCHAR(@MAX_CHAR) REFERENCES Player(battletag),
  hero_name VARCHAR(@MAX_CHAR) REFERENCES Hero(name),
  player_win_rate FLOAT NOT NULL check(player_win_rate <= 1 AND player_win_rate >= 0),
  avg_elims FLOAT NOT NULL check(avg_elims >= 0),
  PRIMARY KEY(player_battletag, hero_name)
);

/*-------------------------------PLAYS_IN_MATCH-------------------------------*/
-- Create a table to reprsent a relationship between players playing heroes during matches
-- Needed to calculate counters, should be empty before and after a match
-- player_battletag: reference to a player
-- team_ID: reference to a team
-- hero_name: reference to a hero
CREATE TABLE PLAYS_IN_MATCH (
  player_battletag VARCHAR(@MAX_CHAR) REFERENCES Player(battletag),
  team_ID INTEGER REFERENCES Team(ID),
  hero_name VARCHAR(@MAX_CHAR) REFERENCES Hero(name),
  PRIMARY KEY(player_battletag, team_ID, hero_name)
);

/*-----------------------------------Ability----------------------------------*/
-- Create a table to represent a hero abilities with the following variables:
-- hero_name: reference to a hero
-- ability_name: primary key in combination with hero_name
-- ability_desc: brief description of ability
CREATE TABLE Ability (
  hero_name VARCHAR(@MAX_CHAR) REFERENCES Hero(name),
  ability_name VARCHAR(@MAX_CHAR),
  ability_desc VARCHAR(@MAX_FILE_PATH) default(''),
  PRIMARY KEY(hero_name, ability_name)
);

/*----------------------------------COUNTERS----------------------------------*/
-- Create a table to reprsent a relationship between heroes countering other heroes
-- hero_name: reference to a hero, hero being played
-- counter_name: reference to a hero, hero that is strong against/disadvantages another hero
CREATE TABLE COUNTERS (
  hero_name VARCHAR(@MAX_CHAR) REFERENCES Hero(name),
  counter_name VARCHAR(@MAX_CHAR) REFERENCES Hero(name),
  PRIMARY KEY(hero_name, counter_name)
);


/*
Create Views to easily access data.
*/

/*-----------------------------------Views------------------------------------*/

/*---------------------------------User+Team----------------------------------*/
-- Create a view with easily accessible owership information
-- username, password, is_admin
CREATE VIEW User_OWNS_Teams AS
  SELECT username, ID, city, mascot  --add more variables if needed -------------------------------------?
  FROM User, Team
  WHERE username = OWNER;

/*------------------------------Player+IS_ON+Team-----------------------------*/
-- Create a view to easily see which players are on a team, mostly to clean up and get rid of extra attributes
-- Player: battletag, role, photo
-- IS_ON: player_battletag, team_ID
-- Team: city, mascot, logo, num_wins, num_losses, is_pro, num_players, OWNER
-- Attributes needed:------------------------------------------------------------------------------------------?
-- needed? --------------------- might be better to calculate here and not store in team??

CREATE VIEW Players_ON_Teams AS
  SELECT battletag, ID, COUNT(*) as 'num_players'
  FROM Player, IS_ON, Team
  WHERE battletag = player_battletag AND ID = team_ID
  GROUP BY ID;

/*------------------------------Player+PLAYS+Hero-----------------------------*/
--
-- Player: battletag, role, photo
-- IS_ON: player_battletag, team_ID
-- PLAYS: player_battletag, hero_name, player_win_rate, avg_elims
-- Hero: name, hero_win_rate, hero_pick_rate, photo, role, healing, damage, block
-- Select team_IDs and the number of each role they have
CREATE VIEW Player_Hero_Roles AS
  SELECT team_ID, COUNT(Hero.role == 'h') as 'num_heal', COUNT(Hero.role == 'd') as 'num_dmg', COUNT(Hero.role == 't') as 'num_tank'
  FROM Player, IS_ON, PLAYS, Hero
  WHERE battletag = player_battletag AND hero_name = name
  GROUP BY team_ID;

/*-------------------------------MATCH-------------------------------*/
-- Player: battletag, role, photo
-- PLAYS: player_battletag, hero_name, player_win_rate, avg_elims
-- Hero: name, hero_win_rate, hero_pick_rate, photo, role, healing, damage, block
-- COUNTERS: hero_name, counter_name
-- PLAYS_IN_MATCH: player_battletag, team_name, hero_name
-- COMPETES_AGAINST: A_city, A_mascot, B_city, B_mascot

/*
CREATE VIEW Match AS
  SELECT team_ID
  FROM Player, IS_ON, PLAYS, COUNTERS, PLAYS_IN_MATCH, COMPETES_AGAINST
  WHERE
  HAVING
  GROUP BY team_ID;*/

/*
  win_percent = []
  for each team in match
    countD, countH, countT = 0
    win_percent[team] = average(all players on specific heroes win rates)
    for each player on team
      if player.hero has_counter in (select hero from plays_in_match where team != current team)
        win_percent[team] = win_percent[team] - 5%
      if player.role != player_plays_in_match.hero.role
        win_percent[team] = win_percent[team] - 1%
      if player.role == d, increase countD
      if player.role == h, increase countH
      if player.role == t, increase countT
    if countD != countH != countT
      win_percent[team] = win_percent[team] - 5%
  if win_percent[0] > win_percent[1]
    A_cit, mascot += 1 win
    B_cit, mascot += 1 loss
    return A_city, A_mascot
  else
    A_cit, mascot += 1 loss
    B_cit, mascot += 1 win
    return B_city, B_mascot
*/
