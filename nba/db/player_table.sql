CREATE TABLE players 
(
  id VARCHAR(100) NOT NULL PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  bday DATE,
  bplace VARCHAR(50),
  weight INTEGER,
  height INTEGER,
  college VARCHAR(50),
  draft_year INTEGER,
  draft_round INTEGER,
  draft_pick INTEGER,
  draft_team VARCHAR(50),
  espn_id INTEGER
);
