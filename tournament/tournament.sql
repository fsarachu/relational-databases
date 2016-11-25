-- Table definitions for the tournament project.
--
-- Put your SQL 'create table' statements in this file; also 'create view'
-- statements if you choose to use it.
--
-- You can write comments in this file by starting them with two dashes, like
-- these lines here.

DROP TABLE IF EXISTS players CASCADE;

CREATE TABLE players (
  id   SERIAL,
  name VARCHAR(255),
  PRIMARY KEY (id)
);


DROP TABLE IF EXISTS matches CASCADE;

CREATE TABLE matches (
  id       SERIAL,
  player_1 INT REFERENCES players (id),
  player_2 INT REFERENCES players (id),
  winner   INT REFERENCES players (id),
  PRIMARY KEY (id)
);