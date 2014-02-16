CREATE TABLE standings
(
	id SERIAL NOT NULL PRIMARY KEY,
	team VARCHAR(20) NOT NULL,
	season_year VARCHAR(20) NOT NULL,
	season_type VARCHAR(100) NOT NULL,
	team_conference VARCHAR(100) NOT NULL,
	team_division VARCHAR(100) NOT NULL,
	conf_rank int NOT NULL,
	div_rank int NOT NULL,
	wins int NOT NULL,
	losses int NOT NULL,
	pct float NOT NULL,
	won_champ boolean DEFAULT false
);

