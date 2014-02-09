require_relative 'clients/nba_stats'
require_relative 'util/db_manager'
require 'sequel'

DB = NBA::DBManager.create_connection

team_table = DB[:team]

c = NBAStats.new "Season" => "2013-14", "LeagueID" => "00", "SeasonType" => "Regular Season"
teams = c.get_stat("commonteamyears")
teams.select!{|team| team.abbreviation != nil }

teams.each do |team|
	info = c.get_stat("teaminfocommon", {"TeamID" => team.team_id}).first

	puts "Inserting #{info.team_name}"
	pp info
	pp team

	team_table.insert(
	{
		:city => info.team_city, 
		:name => info.team_name, 
		:abbreviation => info.team_abbreviation, 
		:code => info.team_code, 
		:min_year => team.min_year,
		:max_year => team.max_year,
		:nba_stats_id => team.team_id
	})
end