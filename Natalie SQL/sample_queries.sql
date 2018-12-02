---Gets All Players and teams they are on. 
select battletag,
       city,
	   mascot,
	   role 
 from
	(
	  select * from Player, IS_ON
	  where battletag = player_battletag
	)PlayerTeamID
,   Team
where team_ID = ID;

---Gets all teams and their players---
select concat(city, ' ', mascot) as Team
,	   player_battletag as Player
 from
	(
	  select MIN(ID) as id, city, mascot, player_battletag
	  from Team, IS_ON
	  where ID = team_ID
	  Group BY city, mascot, player_battletag
	)TeamsAlph;

---Player Mains---
select  battletag as Tag
,	    hero_name as Mains
,       player_win_rate as Win_Rate 

 from Player, PLAYS
where battletag = player_battletag;

---Shows all information about a hero---
select * from Hero, COUNTERS
where name = hero_name


select * from Ability,
(
  select name as h_name
  ,      hero_win_rate as Win_Rate
  ,      hero_pick_rate as Pick_Rate
  ,      photo
  ,      role as Role
  ,      healing as Healing
  ,      damage as Damage
  ,      block as Block
  ,      counter_name as Counter
  from Hero, COUNTERS
  where name = COUNTERS.hero_name
)HeroCounter
where hero_name = h_name

---Shows all players who play each hero---
select hero_name as Hero
,      player_battletag as Player
from PLAYS,
     (
     select hero_name as hero, player_battletag as player
	 from PLAYS
     )RPlays
	 where hero_name = hero

