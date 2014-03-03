CREATE TABLE players 
(
  id SERIAL NOT NULL PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  bdate DATE,
  bplace VARCHAR(50),
  wt INTEGER,
  ht VARCHAR(10),
  college VARCHAR(50),
  draft_year INTEGER,
  draft_round INTEGER,
  draft_pick INTEGER,
  draft_team VARCHAR(50),
  espn_id INTEGER
);
