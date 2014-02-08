require File.join(File.dirname(__FILE__), "clients/nba_stats")

c = NBAStats.new "Season" => "2013-14", "LeagueID" => "00", "SeasonType" => "Regular Season"
teams = c.get_stat("commonteamyears")
teams.select!{|team| team.abbreviation != nil }

teams.each do |team|
	pp c.get_stat("teaminfocommon", {"TeamID" => team.team_id})
end