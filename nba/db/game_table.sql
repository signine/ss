CREATE TABLE game 
(
  id SERIAL NOT NULL,
  game_date DATE NOT NULL,
  season VARCHAR(10),
  season_type VARCHAR(10),
  home_team VARCHAR(50) NOT NULL,
  visitor_team VARCHAR(50) NOT NULL,
  home_team_score INTEGER,
  visitor_team_score INTEGER,
  winner VARCHAR(50),
  loser VARCHAR(50),
  attendance INTEGER,
  duration INTEGER,
  nba_stats_game_id VARCHAR(50)
);
