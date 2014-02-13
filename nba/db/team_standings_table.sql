CREATE TABLE team_standings_timeline
(
	id SERIAL NOT NULL PRIMARY KEY,
	team VARCHAR(20) NOT NULL,
	date TIMESTAMP WITHOUT TIME ZONE DEFAULT now(),
	season_year VARCHAR(20) NOT NULL,
	season_type VARCHAR(100) NOT NULL,
	team_conference VARCHAR(100) NOT NULL,
	team_division VARCHAR(100) NOT NULL,
	conf_rank int NOT NULL,
	div_rank int NOT NULL,
	conf_wins int,
	conf_losses int,
	div_wins int, 
	div_losses int,
	home_wins int,
	home_losses int,
	road_wins int,
	road_losses int,
	total_games int,
	last_10_wins int,
	last_10_losses int,
	wins int NOT NULL,
	losses int NOT NULL,
	pct float NOT NULL,
	gb float,
	streak varchar(10)
);