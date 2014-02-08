CREATE TABLE team 
(
  id SERIAL NOT NULL PRIMARY KEY,
  city varchar(100) NOT NULL,
  name varchar(100) NOT NULL,
  abbreviation varchar(20) NOT NULL,
  code varchar(100),
  min_year int,
  max_year int,
  nba_stats_id varchar(100)
);