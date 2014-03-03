CREATE TABLE team_roster
(
  id SERIAL NOT NULL PRIMARY KEY,
  season VARCHAR(20) NOT NULL,
  player_id VARCHAR(50) NOT NULL,
  team VARCHAR(50) NOT NULL,
  name VARCHAR(100) NOT NULL,
  jersey INTEGER,
  pos VARCHAR(10),
  age INTEGER,
  ht INTEGER,
  wt INTEGER,
  salary BIGINT
);
