CREATE TABLE team_game_log 
(
  id SERIAL NOT NULL,
  team VARCHAR(20),
  win BOOLEAN,
  game_date DATE,
  game_id BIGINT,
  min INTEGER,
  fgm SMALLINT,
  fga SMALLINT,
  fg FLOAT,
  fgm3 SMALLINT,
  fga3 SMALLINT,
  fg3 FLOAT,
  ftm SMALLINT,
  fta SMALLINT,
  ft FLOAT,
  oreb SMALLINT,
  dreb SMALLINT,
  reb SMALLINT,
  ast SMALLINT,
  stl SMALLINT,
  blk SMALLINT,
  tov SMALLINT,
  pf SMALLINT,
  pts SMALLINT,
  plus_minus SMALLINT
);