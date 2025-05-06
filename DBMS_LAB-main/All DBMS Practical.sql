-- All DBMS Practicals: Football Management System

-- 1. Table Creation (MySQL)

CREATE TABLE arenas (
  arena_id VARCHAR(255) PRIMARY KEY,
  arena_name VARCHAR(255) NOT NULL,
  address VARCHAR(255),
  city VARCHAR(255),
  state VARCHAR(255),
  zip_code VARCHAR(20),
  capacity INT
);

CREATE TABLE teams (
  team_id VARCHAR(255) PRIMARY KEY,
  team_name VARCHAR(255) NOT NULL,
  formation_date DATE,
  arena_id VARCHAR(255),
  coach_name VARCHAR(255),
  FOREIGN KEY (arena_id) REFERENCES arenas(arena_id) ON DELETE SET NULL ON UPDATE CASCADE
);

CREATE TABLE players (
  player_id VARCHAR(255) PRIMARY KEY,
  first_name VARCHAR(255) NOT NULL,
  last_name VARCHAR(255) NOT NULL,
  team_id VARCHAR(255),
  draft_status VARCHAR(255),
  injury_status VARCHAR(255),
  position VARCHAR(255),
  FOREIGN KEY (team_id) REFERENCES teams(team_id) ON DELETE SET NULL ON UPDATE CASCADE
);

CREATE TABLE users (
  username VARCHAR(255) PRIMARY KEY,
  first_name VARCHAR(255) NOT NULL,
  last_name VARCHAR(255) NOT NULL,
  birthday DATE,
  age INT,
  favorite_position VARCHAR(255)
);

CREATE TABLE leagues (
  league_id VARCHAR(255) PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  country VARCHAR(255),
  season VARCHAR(255)
);

CREATE TABLE matches (
  match_id VARCHAR(255) PRIMARY KEY,
  league_id VARCHAR(255),
  date DATE,
  home_team_id VARCHAR(255),
  away_team_id VARCHAR(255),
  score_home INT,
  score_away INT,
  FOREIGN KEY (league_id) REFERENCES leagues(league_id) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (home_team_id) REFERENCES teams(team_id) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (away_team_id) REFERENCES teams(team_id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE match_stats (
  match_id VARCHAR(255),
  player_id VARCHAR(255),
  goals INT DEFAULT 0,
  assists INT DEFAULT 0,
  yellow_cards INT DEFAULT 0,
  red_cards INT DEFAULT 0,
  minutes_played INT,
  PRIMARY KEY (match_id, player_id),
  FOREIGN KEY (match_id) REFERENCES matches(match_id) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (player_id) REFERENCES players(player_id) ON DELETE CASCADE ON UPDATE CASCADE
);

-- 2. Subqueries

SELECT * FROM players WHERE team_id IN (SELECT team_id FROM teams WHERE team_name = 'Warriors');
SELECT * FROM teams WHERE arena_id IN (SELECT arena_id FROM arenas WHERE capacity > 50000);
SELECT * FROM matches WHERE score_home = (SELECT MAX(score_home) FROM matches);

-- 3. Joins

-- INNER JOIN
SELECT players.first_name, players.last_name, teams.team_name 
FROM players 
INNER JOIN teams ON players.team_id = teams.team_id;

-- LEFT JOIN
SELECT teams.team_name, arenas.arena_name 
FROM teams 
LEFT JOIN arenas ON teams.arena_id = arenas.arena_id;

-- RIGHT JOIN
SELECT teams.team_name, arenas.arena_name 
FROM teams 
RIGHT JOIN arenas ON teams.arena_id = arenas.arena_id;

-- FULL OUTER JOIN (via UNION)
SELECT teams.team_name, arenas.arena_name 
FROM teams 
LEFT JOIN arenas ON teams.arena_id = arenas.arena_id
UNION 
SELECT teams.team_name, arenas.arena_name 
FROM teams 
RIGHT JOIN arenas ON teams.arena_id = arenas.arena_id;

-- Self Join
SELECT p1.first_name AS player1, p2.first_name AS player2, p1.team_id 
FROM players p1 
JOIN players p2 ON p1.team_id = p2.team_id AND p1.player_id <> p2.player_id;

-- 4. Triggers (MySQL)

DELIMITER //
CREATE TRIGGER update_age_before_insert
BEFORE INSERT ON users
FOR EACH ROW
BEGIN
  SET NEW.age = TIMESTAMPDIFF(YEAR, NEW.birthday, CURDATE());
END;//
DELIMITER ;

-- 5. Views

CREATE VIEW player_team_view AS
SELECT p.first_name, p.last_name, t.team_name
FROM players p
JOIN teams t ON p.team_id = t.team_id;

-- 6. Indexes

CREATE INDEX idx_team_name ON teams(team_name);
CREATE INDEX idx_match_date ON matches(date);

-- 7. PL/SQL Procedure (for SQL*Plus)

SET SERVEROUTPUT ON;
CREATE OR REPLACE PROCEDURE transfer_funds(
  p_Amount IN NUMBER
) IS
BEGIN
  DBMS_OUTPUT.PUT_LINE('Transaction successful. Amount transferred: ' || p_Amount);
EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END transfer_funds;
/