/*------------------------Fill tables with initial data-----------------------*/
/*
Natalie Holl, Elise Schillinger, Evan Moak
Fall 2018 CS 2300 Section B
Moria Miners

Tables need to be initialized with data before a user can manipulate them.
Our example data will include a subset of the Overwatch esports teams and their players.
We include all heroes and their abilites.
*/

/*------------------------------------User------------------------------------*/
-- Insert users into the user table
INSERT INTO User VALUES ('admin', '1234', TRUE), ('user', '1234', FALSE);

/*------------------------------------Team------------------------------------*/
-- Insert professional teams into the team table
INSERT INTO Team VALUES
  (1, 'Los Angeles', 'Gladiators', 'https://bnetcmsus-a.akamaihd.net/cms/template_resource/CHTRRZCBEYGN1507822882862.svg', 0, 0, TRUE, 0, 'admin'),
  (2, 'London', 'Spitfire', 'https://bnetcmsus-a.akamaihd.net/cms/template_resource/HCS229B4DP021507822883016.svg', 0, 0, TRUE, 0, 'admin'),
  (3, 'Dallas', 'Fuel', 'https://bnetcmsus-a.akamaihd.net/cms/template_resource/YX6JZ6FR89LU1507822882865.svg', 0, 0, TRUE, 0, 'admin');
  --should num_players be calculated by joining is_on table and counting them? not sure how we'll increase the number ----------------------------------------?

/*------------------------------COMPETES_AGAINST------------------------------*/
-- No data initial data needed, only used when teams compete

/*-----------------------------------Player-----------------------------------*/
-- Insert players into the player table
INSERT INTO Player VALUES
  -- Los Angeles Gladiators players
  ('Surefour', 'd', 'https://bnetcmsus-a.akamaihd.net/cms/page_media/JQ2S2QRB0QCM1512769977581.png'),
  ('Void', 't', 'https://bnetcmsus-a.akamaihd.net/cms/page_media/LAKEA6GOSTXW1523496423868.png'),
  ('Bischu', 't', 'https://bnetcmsus-a.akamaihd.net/cms/page_media/02EPNXS6PRM71512769977245.png'),
  ('Shaz', 'h', 'https://bnetcmsus-a.akamaihd.net/cms/page_media/V4HSZKOHJGN21512769977468.png'),
  ('Hydration', 'd', 'https://bnetcmsus-a.akamaihd.net/cms/page_media/CGG5VB9U5MLQ1512769977402.png'),
  ('BigGoose', 'h', 'https://bnetcmsus-a.akamaihd.net/cms/page_media/1OSV4XRC5PTK1512769977242.png')
  -- London Spitfire players
  ('Gesture', 't', 'https://bnetcmsus-a.akamaihd.net/cms/page_media/SMHDMNUINHC51512776037290.png'),
  ('birdring', 'd', 'https://bnetcmsus-a.akamaihd.net/cms/page_media/1UDI0E8KITK81512776037063.png'),
  ('Bdosin', 'h', 'https://bnetcmsus-a.akamaihd.net/cms/page_media/PWW0ZPOV0DSV1515621286109.png'),
  ('NUS', 'h', 'https://bnetcmsus-a.akamaihd.net/cms/page_media/SMORW78G5YSJ1512776037577.png'),
  ('Fury', 't', 'https://bnetcmsus-a.akamaihd.net/cms/page_media/1XUP30CPRL2O1512776037295.png'),
  ('Profit', 'd', 'https://bnetcmsus-a.akamaihd.net/cms/page_media/Y3G5RS25UNEN1512776037593.png'),
  -- Dallas fuel players
  ('Mickie', 't', 'https://bnetcmsus-a.akamaihd.net/cms/page_media/TMOFUY1T8UKJ1512685113280.png'),
  ('OGE', 't', 'https://bnetcmsus-a.akamaihd.net/cms/page_media/KFCKZNCS448Z1523496423924.png'),
  ('HarryHook', 'h', 'https://bnetcmsus-a.akamaihd.net/cms/page_media/X4JKRJUUAKYH1512685113279.png'),
  ('Unkoe', 'h', 'https://bnetcmsus-a.akamaihd.net/cms/gallery/8P5PDHGFRTOP1522979540099.png'),
  ('Taimou', 'd', 'https://bnetcmsus-a.akamaihd.net/cms/page_media/J3ZGE7V0A88P1512685113545.png'),
  ('EFFECT', 'd', 'https://bnetcmsus-a.akamaihd.net/cms/page_media/BSOW4XNW20CS1512685113260.png');

/*------------------------------------IS_ON-----------------------------------*/
-- Insert player-is on-team relations into the is_on table
-- Los Angeles Gladiators players
INSERT INTO IS_ON VALUES
  ('Surefour', 1),
  ('Void', 1),
  ('Bischu', 1),
  ('Shaz', 1),
  ('Hydration', 1),
  ('BigGoose', 1);
  UPDATE Team SET num_players = 6 WHERE (ID == 1);
-- London Spitfire players
INSERT INTO IS_ON VALUES
  ('Gesture', 2),
  ('birdring', 2),
  ('Bdosin', 2),
  ('NUS', 2),
  ('Fury', 2),
  ('Profit', 2);
  UPDATE Team SET num_players = 6 WHERE (ID == 2);
-- Dallas Fuel players
INSERT INTO IS_ON VALUES
  ('Mickie', 3),
  ('OGE', 3),
  ('HarryHook', 3),
  ('Unkoe', 3),
  ('Taimou', 3),
  ('EFFECT', 3);
  UPDATE Team SET num_players = 6 WHERE (ID == 3);

/*------------------------------------Hero------------------------------------*/
-- Insert heroes into the hero table
-- Source: https://masteroverwatch.com/heroes/pc/global/mode/ranked
-- Not including 2 newest heroes (i.e. Wrecking Ball and Ashe), as they have no logged stats
-- NULL = N/A
INSERT INTO Hero VALUES
  -- Healers
  ('Ana', 0.452, 0.029, 'https://d1u1mce87gyfbn.cloudfront.net/hero/ana/hero-select-portrait.png', 'h', 7680, NULL, NULL),
  ('Brigitte', 0.547, 0.063, 'https://d1u1mce87gyfbn.cloudfront.net/hero/brigitte/hero-select-portrait.png', 'h', 6670, NULL, NULL),
  ('Lucio', 0.457, 0.037, 'https://d1u1mce87gyfbn.cloudfront.net/hero/lucio/hero-select-portrait.png', 'h', 7380, NULL, NULL), -- removed special u
  ('Mercy', 0.496, 0.103, 'https://d1u1mce87gyfbn.cloudfront.net/hero/mercy/hero-select-portrait.png', 'h', 10660, NULL, NULL),
  ('Moira', 0.485, 0.055, 'https://d1u1mce87gyfbn.cloudfront.net/hero/moira/hero-select-portrait.png', 'h', 10270, NULL, NULL),
  ('Zenyatta', 0.506, 0.068, 'https://d1u1mce87gyfbn.cloudfront.net/hero/zenyatta/hero-select-portrait.png', 'h', 6770, NULL, NULL),
  -- Damage dealers
  ('Bastion', 0.473, 0.009, 'https://d1u1mce87gyfbn.cloudfront.net/hero/bastion/hero-select-portrait.png', 'd', NULL, 19160, NULL),
  ('Doomfist', 0.499, 0.014, 'https://d1u1mce87gyfbn.cloudfront.net/hero/doomfist/hero-select-portrait.png', 'd', NULL, 8650, NULL),
  ('Genji', 0.498, 0.024, 'https://d1u1mce87gyfbn.cloudfront.net/hero/genji/hero-select-portrait.png', 'd', NULL, 12070, NULL),
  ('Hanzo', 0.512, 0.060, 'https://d1u1mce87gyfbn.cloudfront.net/hero/hanzo/hero-select-portrait.png', 'd', NULL, 16370, NULL),
  ('Junkrat', 0.493, 0.043, 'https://d1u1mce87gyfbn.cloudfront.net/hero/junkrat/hero-select-portrait.png', 'd', NULL, 16360, NULL),
  ('McCree', 0.471, 0.024, 'https://d1u1mce87gyfbn.cloudfront.net/hero/mccree/hero-select-portrait.png', 'd', NULL, 12500, NULL),
  ('Mei', 0.470, 0.010, 'https://d1u1mce87gyfbn.cloudfront.net/hero/mei/hero-select-portrait.png', 'd', NULL, 7700, NULL),
  ('Pharah', 0.508, 0.034, 'https://d1u1mce87gyfbn.cloudfront.net/hero/pharah/hero-select-portrait.png', 'd', NULL, 16260, NULL),
  ('Reaper', 0.468, 0.014, 'https://d1u1mce87gyfbn.cloudfront.net/hero/reaper/hero-select-portrait.png', 'd', NULL, 13010, NULL),
  ('Soldier: 76', 0.481, 0.028, 'https://d1u1mce87gyfbn.cloudfront.net/hero/soldier-76/hero-select-portrait.png', 'd', NULL, 14350, NULL),
  ('Sombra', 0.440, 0.010, 'https://d1u1mce87gyfbn.cloudfront.net/hero/sombra/hero-select-portrait.png', 'd', NULL, 8120, NULL),
  ('Symmetra', 0.553, 0.010, 'https://d1u1mce87gyfbn.cloudfront.net/hero/symmetra/hero-select-portrait.png', 'd', NULL, 9490, NULL),
  ('Torbjorn', 0.505, 0.011, 'https://d1u1mce87gyfbn.cloudfront.net/hero/torbjorn/hero-select-portrait.png', 'd', NULL, 14110, NULL), -- removed special o
  ('Tracer', 0.506, 0.029, 'https://d1u1mce87gyfbn.cloudfront.net/hero/tracer/hero-select-portrait.png', 'd', NULL, 10570, NULL),
  ('Widowmaker', 0.527, 0.047, 'https://d1u1mce87gyfbn.cloudfront.net/hero/widowmaker/hero-select-portrait.png', 'd', NULL, 9690, NULL),
  -- Tanks
  ('D.va', 0.498, 0.045, 'https://d1u1mce87gyfbn.cloudfront.net/hero/dva/hero-select-portrait.png', 't', NULL, NULL, 6260),
  ('Orisa', 0.512, 0.025, 'https://d1u1mce87gyfbn.cloudfront.net/hero/orisa/hero-select-portrait.png', 't', NULL, NULL, 23910),
  ('Reinhardt', 0.511, 0.092, 'https://d1u1mce87gyfbn.cloudfront.net/hero/reinhardt/hero-select-portrait.png', 't', NULL, NULL, 15970),
  ('Roadhog', 0.485, 0.026, 'https://d1u1mce87gyfbn.cloudfront.net/hero/roadhog/hero-select-portrait.png', 't', NULL, NULL, 0),
  ('Winston', 0.469, 0.024, 'https://d1u1mce87gyfbn.cloudfront.net/hero/winston/hero-select-portrait.png', 't', NULL, NULL, 10920),
  ('Zarya', 0.521, 0.083, 'https://d1u1mce87gyfbn.cloudfront.net/hero/zarya/hero-select-portrait.png', 't', NULL, NULL, 6360);

/*------------------------------------PLAYS-----------------------------------*/
-- Insert player-playing-hero relations into the plays table
-- distributed heroes across all players - not all represent actual data
-- tanks and healers: at least 2 players play all
-- damage dealers: 3 per damage dealer
-- Source: https://overwatchleague.com/en-us/teams
-- Los Angeles Gladiators players
INSERT INTO PLAYS VALUES
  ('Surefour', 'Widowmaker', 0.552, 17.5),
  ('Surefour', 'Sombra', 0.456, 14.6),
  ('Surefour', 'Tracer', 0.533, 15.9), --15.89 avg elims of player on all heroes for reference
  ('Void', 'D.va', 0.493, 18.1),
  ('Void', 'Zarya', 0.534, 16.4), -- 16.91
  ('Bischu', 'Orisa', 0.489, 16.5),
  ('Bischu', 'Roadhog', 0.445, 17.3), --17.12
  ('Shaz', 'Zenyatta', 0.552, 10.6),
  ('Shaz', 'Moira', 0.512, 12.8), --11.57
  ('Hydration', 'Genji', 0.531, 18.2),
  ('Hydration', 'Junkrat', 0.479, 15.7),
  ('Hydration', 'Bastion', 0.493, 16.3), --16.40
  ('BigGoose', 'Mercy', 0.528, 2.1),
  ('BigGoose', 'Lucio', 0.509, 4.8); --3.88
-- London Spitfire players
INSERT INTO PLAYS VALUES
  ('Gesture', 'Orisa', 0.493, 16.9),
  ('Gesture', 'Reinhardt', 0.547, 18.3), -- 17.81
  ('birdring', 'McCree', 0.505, 16.5),
  ('birdring', 'Soldier: 76', 0.543, 17.8),
  ('birdring', 'Doomfist', 0.458, 13.7), --16.53
  ('Bdosin', 'Brigitte', 0.578, 10.3),
  ('Bdosin', 'Moira', 0.511, 15.4), --13.31
  ('NUS', 'Ana', 0.500, 3.8),
  ('NUS', 'Lucio', 0.462, 4.1), --2.92
  ('Fury', 'Zarya', 0.519, 17.3),
  ('Fury', 'Winston', 0.495, 19.9), --18.92
  ('Profit', 'Tracer', 0.538, 20.2),
  ('Profit', 'Torbjorn', 0.469, 15.9),
  ('Profit', 'Widowmaker', 0.514, 17.3); --18.88
-- Dallas Fuel players
INSERT INTO PLAYS VALUES
  ('Mickie', 'D.va', 0.541, 16.4),
  ('Mickie', 'Roadhog', 0.528, 14.7), --15.26
  ('OGE', 'Winston', 0.469, 17.1),
  ('OGE', 'Reinhardt', 0.510, 14.5), --13.16
  ('HarryHook', 'Mercy', 0.484, 3.5),
  ('HarryHook', 'Ana', 0.527, 6.9), --5.05
  ('Unkoe', 'Zenyatta', 0.493, 8.8),
  ('Unkoe', 'Brigitte', 0.549, 12.9), --9.92
  ('Taimou', 'Pharah', 0.534, 19.8),
  ('Taimou', 'Hanzo', 0.506, 16.1),
  ('Taimou', 'Symmetra', 0.461, 8.0), --14.08
  ('EFFECT', 'Reaper', 0.514, 20.6),
  ('EFFECT', 'Mei', 0.483, 14.9),
  ('EFFECT', 'Genji', 0.531, 17.8); --17.80

/*-------------------------------PLAYS_IN_MATCH-------------------------------*/
-- No data initial data needed, only used when teams compete

/*-----------------------------------Ability----------------------------------*/
-- Insert hero abilities into the ability table
-- Healer abilities
INSERT INTO Ability VALUES
  -- Ana
  ('Ana', 'Biotic Rifle', 'Shoot to heal allies or damage enemies.'),
  ('Ana', 'Sleep Dart', 'Put an enemy to sleep.'),
  ('Ana', 'Biotic Grenade', 'Prevent enemy healing and increase ally healing.'),
  ('Ana', 'Nano Boost', 'Increase an ally\'s damage and decrease damage taken.'),
  --Brigitte
  ('Brigitte', 'Rocket Flail', 'Swing a mace to damage enemies.'),
  ('Brigitte', 'Repair Pack', 'Heal an ally, overhealing becomes armor.'),
  ('Brigitte', 'Whip Shot', 'Knock back an enemy.'),
  ('Brigitte', 'Barrier Shield', 'Deploy a small personal shield.'),
  ('Brigitte', 'Shield Bash', 'Dash forward with shield to stun enemies.'),
  ('Brigitte', 'Rally', 'Increase own speed and provide armor to nearby allies.'),
  --Lucio
  ('Lucio', 'Sonic Amplifier', 'Shoot projectiles or knock back enemies.'),
  ('Lucio', 'Crossfade', 'Switch between a healing or speed-increasing radius.'),
  ('Lucio', 'Amp It Up', 'Increase the affect of active radius.'),
  ('Lucio', 'Sound Barrier', 'Provide a large decaying shield to nearby allies.'),
  --Mercy
  ('Mercy', 'Caduceus Staff', 'Heal or increase the damage of an ally.'),
  ('Mercy', 'Caduceus Blaster', 'Shoot to deal damage to enemies.'),
  ('Mercy', 'Guardian Angel', 'Fly towards a targeted ally.'),
  ('Mercy', 'Resurrect', 'Allow a dead ally to come back to the fight.'),
  ('Mercy', 'Angelic Descent', 'Decrease own fall speed.'),
  ('Mercy', 'Valkyrie', 'Gain flight and increase affects of all abilities.'),
  --Moira
  ('Moira', 'Biotic Grasp', 'Heal with a spray or damage with a life-steal.'),
  ('Moira', 'Biotic Orb', 'Throw a healing or damaging orb that bounches.'),
  ('Moira', 'Fade', 'Disappear and teleport a short distance.'),
  ('Moira', 'Coalescence', 'Channel a long-range beam that heals or damages.'),
  -- Zenyatta
  ('Zenyatta', 'Orb of Destruction', 'Throw one or several orbs to deal damage.'),
  ('Zenyatta', 'Orb of Harmony', 'Place a healing orb on an ally.'),
  ('Zenyatta', 'Orb of Discord', 'Debuff an enemy to increase damage received.'),
  ('Zenyatta', 'Transcendence', 'Heal nearby allies in a radius over time.');

-- Damage dealer abilities
INSERT INTO Ability VALUES
  -- Bastion
  ('Bastion', 'Configuration: Recon', 'Mobile form with a submachine gun.'),
  ('Bastion', 'Configuration: Sentry', 'Stationary form with gatling gun.'),
  ('Bastion', 'Reconfigure', 'Transition between recon and sentry mode.'),
  ('Bastion', 'Self-repair', 'Restore own health but unable to deal damage.'),
  ('Bastion', 'Configuration: Tank', 'Transform into a tank and shoot explosives.'),
  -- Doomfist
  ('Doomfist', 'Hand Cannon', 'Shoot burst from fist.'),
  ('Doomfist', 'Seismic Slam', 'Slam forward to knock enemies toward self.'),
  ('Doomfist', 'Rising Uppercut', 'Knock enemies into the air.'),
  ('Doomfist', 'Rocket Punch', 'Charge up and launch forward to damage enemies hit.'),
  ('Doomfist', 'The Best Defense', 'Gain temporary shields when dealing damage.')
  ('Doomfist', 'Meteor Strike', 'Jump into the sky and choose a location to land, dealing damage.'),
  -- Genji
  ('Genji', 'Shuriken', 'Throw three throwing stars in succession or in a spread.'),
  ('Genji', 'Deflect', 'Reflect incoming projectiles.'),
  ('Genji', 'Swift Strike', 'Dash foward to deal damage.'),
  ('Genji', 'Dragonblade', 'Pull out a katana to slash and damage enemies.'),
  -- Hanzo
  ('Hanzo', 'Storm Bow', 'Pull back a bow to fire arrows.'),
  ('Hanzo', 'Sonic Arrow', 'Shoot an arrow to reveal enemy locations.'),
  ('Hanzo', 'Storm Arrows', 'Fire several arrows instantly.'),
  ('Hanzo', 'Lunge', 'Jump a short-distance.'),
  ('Hanzo', 'Dragonstrike', 'Fire a dragon arrow that damages enemies in its path.'),
  -- Junkrat
  ('Junkrat', 'Frag Launcher', 'Launch grenades that bounce.'),
  ('Junkrat', 'Concussion Mine', 'Set a mine that can be triggered to explode.'),
  ('Junkrat', 'Steel Trap', 'Set a trap that immobilizes enemies.'),
  ('Junkrat', 'Total Mayhem', 'Drop several explosives on death.'),
  ('Junkrat', 'Rip-Tire', 'Send out a remote controlled tire that can be triggered to explode.'),
  -- McCree
  ('McCree', 'Peacekeeper', 'Fire a round or fan the hammer to unload entire clip.'),
  ('McCree', 'Combat Roll', 'Roll in the direction moved.'),
  ('McCree', 'Flashbang', 'Throw a grenade that stuns enemies.'),
  ('McCree', 'Deadeye', 'Line up killing blows on enemies in line of sight.'),
  -- Mei
  ('Mei', 'Endothermic Blaster', 'Shoot a beam to immobilize enemies or shoot an icicle.'),
  ('Mei', 'Cryo-Freeze', 'Surround self in ice to heal, impervious to damage.'),
  ('Mei', 'Ice Wall', 'Construct a wall of ice to block enemies.'),
  ('Mei', 'Blizzard', 'Throw a drone that freezes enemies in a sphere.'),
  -- Pharah
  ('Pharah', 'Rocket Launcher', 'Fire rockets.'),
  ('Pharah', 'Jump Jet', 'Launch high into the air.'),
  ('Pharah', 'Concussive Blast', 'Shoot a rocket  that knocks back enemies.'),
  ('Pharah', 'Barrage', 'Fire a barrage of rockets to deal high damage.'),
  -- Reaper
  ('Reaper', 'Hellfire Shotguns', 'Shoot two shotguns with life-steal.'),
  ('Reaper', 'Wraith Form', 'Become a shadow and impervious to damage.'),
  ('Reaper', 'Shadow Step', 'Teleport to a targeted location.'),
  ('Reaper', 'Death Blossom', 'Twirl while shooting both shotguns to deal damage.'),
  -- Soldier: 76
  ('Soldier: 76', 'Heavy Pulse Rifle', 'Fire an automatic pulse rifle.'),
  ('Soldier: 76', 'Helix Rockets', 'Shoot spiraling rockets that explode on impact.'),
  ('Soldier: 76', 'Sprint', 'Gain speed.'),
  ('Soldier: 76', 'Biotic Field', 'Set down an emitter that heals in a radius.'),
  ('Soldier: 76', 'Tactical Visor', 'Lock on aim and automatically track an enemy.'),
  -- Sombra
  ('Sombra', 'Machine Pistol', 'Fire an automatic machine pistol.'),
  ('Sombra', 'Hack', 'Channel on an enemy to disable enemy abilities.'),
  ('Sombra', 'Stealth', 'Become invisible, breaks if use abilities or take damage.'),
  ('Sombra', 'Translocator', 'Set out a beacon to teleport back to.'),
  ('Sombra', 'EMP', 'Hack all enemies and destory shields in a radius.'),
  -- Symmetra
  ('Symmetra', 'Photon Projector', 'Channel a beam or fire an explosive energy ball.'),
  ('Symmetra', 'Sentry Turret', 'Throw a turret that channels a beam on an enemy.'),
  ('Symmetra', 'Teleporter', 'Place two teleporters that can be travelled between.'),
  ('Symmetra', 'Photon Barrier', 'Deploy a massive energy barrier to block damage.'),
  -- Torbjorn
  ('Torbjorn', 'Rivet Gun', 'Shoot rivets or shrapnel.'),
  ('Torbjorn', 'Forge Hammer', 'Swing a small hammer to damage enemies or repair turret.'),
  ('Torbjorn', 'Deploy Turret', 'Set out a turret that tracks and attackes enemies.'),
  ('Torbjorn', 'Overload', 'Gain armor, attack speed, and movement speed.'),
  ('Torbjorn', 'Molten Core', 'Launch molten lava to create pools of sustained damage.'),
  -- Tracer
  ('Tracer', 'Pulse Pistols', 'Rapidly shoot two pistols.'),
  ('Tracer', 'Blink', 'Dash forward quickly.'),
  ('Tracer', 'Recall', 'Rewind time to previous health, ammo, and position.'),
  ('Tracer', 'Pulse Bomb', 'Throw a sticky bomb that explodes after a short time.'),
  -- Widowmaker
  ('Widowmaker', 'Widow\'s Kiss', 'Fire a machine gun, scope-in to snipe.'),
  ('Widowmaker', 'Grappling Hook', 'Pull self toward a targeted location.'),
  ('Widowmaker', 'Venom Mine', 'Deploy a mine that deals damage over time when touched.'),
  ('Widowmaker', 'Infra-Sight', 'Reveal all enemies to self and allies.');

-- Tank abilities
INSERT INTO Ability VALUES
  -- D.va
  ('D.va', 'Fusion Cannons', 'Continuously shoot without reloading.'),
  ('D.va', 'Light Gun', 'Shoot a small blaster when outside of mech.'),
  ('D.va', 'Boosters', 'Fly forward with rockets, knock back enemies.'),
  ('D.va', 'Defense Matrix', 'Stop all incoming projectiles.'),
  ('D.va', 'Micro Missiles', 'Shoot a volley of rockets.'),
  ('D.va', 'Self-Destruct', 'Eject and explode mech, dealing damage to enemies.'),
  ('D.va', 'Call Mech', 'Call a new mech to enter.'),
  -- Orisa
  ('Orisa', 'Fusion Driver', 'Slow movement but shoot projectiles to deal damage.'),
  ('Orisa', 'Fortify', 'Reduce damage taken and grant immunity to crowd-control.'),
  ('Orisa', 'Halt!', 'Launch an orb that pulls enemies towards the center.'),
  ('Orisa', 'Protective Barrier', 'Throw down a stationary shield to block damage.'),
  ('Orisa', 'Supercharger', 'Increase ally damage near a centeral point.'),
  -- Reinhardt
  ('Reinhardt', 'Rocket Hammer', 'Swing a battle hammer to deal an arc of damage.'),
  ('Reinhardt', 'Barrier Field', 'Project a large rectangular barrier to block damage.'),
  ('Reinhardt', 'Charge', 'Charge forward to pin and knock back enemies.'),
  ('Reinhardt', 'Fire Strike', 'Throw a flaming projectile which pierces and damages.'),
  ('Reinhardt', 'Earthshatter', 'Slam hammer on ground to deal damage and stun.'),
  -- Roadhog
  ('Roadhog', 'Scrap Gun', 'Shoot shotgun or shrapnel ball.'),
  ('Roadhog', 'Take a Breather', 'Decrease damage taken and heal own health.'),
  ('Roadhog', 'Chain Hook', 'Throw a hook to pull an enemy into close range.'),
  ('Roadhog', 'Whole Hog', 'Channel shrapnel to damage and knock back enemies.'),
  -- Winston
  ('Winston', 'Tesla Cannon', 'Electrify a small area in front to damage enemies.'),
  ('Winston', 'Jump Pack', 'Leap through the air, stagger enemies on landing.'),
  ('Winston', 'Barrier Projector', 'Deploy a spherical barrier to block damage.'),
  ('Winston', 'Primal Rage', 'Boost health and damage, decrease cooldown of jump.'),
  -- Zarya
  ('Zarya', 'Particle Cannon', 'Channel a beam of energy or shoot energy grenades.'),
  ('Zarya', 'Particle Barrier', 'Emit a personal bubble barrier to absorb damage.'),
  ('Zarya', 'Projected Barrier', 'Project a personal bubble barrier to an ally.'),
  ('Zarya', 'Graviton Surge', 'Launch a bomb that pulls and constrains enemies to its center.');

/*----------------------------------COUNTERS----------------------------------*/
-- Insert hero counters into the counter table
-- One counter for each hero to limit storage
INSERT INTO COUNTERS VALUES
  -- Healers
  ('Ana', 'Winston'),
  ('Brigitte', 'Brigitte'),
  ('Lucio', 'Sombra'),
  ('Mercy', 'Widowmaker'),
  ('Moira', 'Roadhog'),
  ('Zenyatta', 'Sombra'),
  -- Damage dealers
  ('Bastion', 'Pharah'),
  ('Doomfist', 'Sombra'),
  ('Genji', 'Winston'),
  ('Hanzo', 'Tracer'),
  ('Junkrat', 'Zarya'),
  ('McCree', 'Reinhardt'),
  ('Mei', 'Zarya'),
  ('Pharah', 'Soldier: 76'),
  ('Reaper', 'McCree'),
  ('Soldier: 76', 'Orisa'),
  ('Sombra', 'Mei'),
  ('Symmetra', 'Winston'),
  ('Torbjorn', 'Roaghog'),
  ('Tracer', 'McCree'),
  ('Widowmaker', 'Genji'),
  -- Tanks
  ('D.va', 'Mei'),
  ('Orisa', 'Hanzo'),
  ('Reinhardt', 'Junkrat'),
  ('Roadhog', 'Reaper'),
  ('Winston', 'Reaper'),
  ('Zarya', 'Sombra');
