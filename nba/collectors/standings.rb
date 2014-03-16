require_relative '../clients/nba_stats'
require_relative '../nba'
require 'sequel'

TABLE = :standings
COLUMNS = [:team, :season_type, :season_year, :team_conference, :team_division, :conf_rank, :div_rank, :wins, :losses, :pct]

DB = NBA::DBManager.create_connection
TEAMS = DB[:team].select(:nba_stats_id).all
SEASON_TYPES = ["Regular Season"]
SEASONS = NBA::SeasonString.get_seasons 1990, 2014
DEFAULTS = {"LeagueID" => "00"}

provider = 
Enumerator.new do |yielder|
	c = NBAStats.new DEFAULTS

	SEASONS.each do |season|
		SEASON_TYPES.each do |season_type|
			TEAMS.each do |team|
				opts = DEFAULTS.merge({"Season" => season, "SeasonType" => season_type, "TeamID" => team[:nba_stats_id]})
				info = c.get_stat("teaminfocommon", opts)
				if info.empty?
					next
				else 
					info = info.first
				end

				yielder <<
				{
					:team => info.team_code,
					:season_year => season,
					:season_type => season_type,
					:team_conference => info.team_conference,
					:team_division => info.team_division,
					:conf_rank => info.conf_rank,
					:div_rank => info.div_rank,
					:wins => info.w,
					:losses => info.l,
					:pct => info.pct,	
				}
			end
		end
	end
end

collector = NBA::DataCollector.new provider, TABLE, COLUMNS, :batch_size => 10
runner = NBA::DataCollectorClient.new collector
runner.run ARGV
