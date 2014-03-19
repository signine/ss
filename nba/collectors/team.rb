require_relative '../clients/nba_stats'
require_relative '../nba'
require 'sequel'

TABLE = :team
COLUMNS = [:city, :name, :abbreviation, :code, :min_year, :max_year, :nba_stats_id]

provider = 
Enumerator.new do |yielder| 
  c = NBAStats.new "Season" => "2013-14", "LeagueID" => "00", "SeasonType" => "Regular Season"
  teams = c.get_stat("commonteamyears")
  teams.select!{|team| team.abbreviation != nil }

  teams.each do |team|
    info = c.get_stat("teaminfocommon", {"TeamID" => team.team_id}).first

    yielder << 
    {
      :city => info.team_city, 
      :name => info.team_name, 
      :abbreviation => info.team_abbreviation, 
      :code => info.team_code, 
      :min_year => team.min_year,
      :max_year => team.max_year,
      :nba_stats_id => team.team_id
    }

  end  
end

collector = NBA::DataCollector.new provider, TABLE, :batch_size => 10
runner = NBA::DataCollectorClient.new collector
runner.run ARGV
