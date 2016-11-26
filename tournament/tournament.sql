-- Table definitions for the tournament project.
--
-- Put your SQL 'create table' statements in this file; also 'create view'
-- statements if you choose to use it.
--
-- You can write comments in this file by starting them with two dashes, like
-- these lines here.

DROP DATABASE IF EXISTS tournament;

CREATE DATABASE tournament;


DROP TABLE IF EXISTS players CASCADE;

CREATE TABLE players (
  id   SERIAL,
  name VARCHAR(255),
  PRIMARY KEY (id)
);


DROP TABLE IF EXISTS matches CASCADE;

CREATE TABLE matches (
  id     SERIAL,
  winner INT REFERENCES players (id),
  loser  INT REFERENCES players (id),
  PRIMARY KEY (id)
);

DROP VIEW IF EXISTS player_wins;

CREATE VIEW player_wins AS
  SELECT
    players.id            AS "id",
    players.name          AS "name",
    COUNT(matches.winner) AS "wins"
  FROM players
    LEFT JOIN matches
      ON players.id = matches.winner
  GROUP BY players.id;


DROP VIEW IF EXISTS player_matches;

CREATE VIEW player_matches AS
  SELECT
    players.id        AS "id",
    players.name      AS "name",
    COUNT(matches.id) AS "matches"
  FROM players
    LEFT JOIN matches
      ON players.id = matches.winner OR players.id = matches.loser
  GROUP BY players.id;


DROP VIEW IF EXISTS player_standings;

CREATE VIEW player_standings AS
  SELECT
    w.id      AS "id",
    w.name    AS "name",
    w.wins    AS "wins",
    m.matches AS "matches"
  FROM player_wins AS w
    JOIN player_matches AS m
      ON w.id = m.id
  ORDER BY wins DESC;