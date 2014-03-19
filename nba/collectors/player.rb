require_relative '../clients/espn'
require_relative '../nba'
require 'sequel'

TABLE = :players
COLUMNS = [:name, :wt, :ht, :college, :bplace, :bdate, :draft_year, :draft_round, :draft_pick, :draft_team, :espn_id]
DB = NBA::DBManager.create_connection

provider = 
Enumerator.new do |yielder| 
  c = NBA::ESPN.new
  teams = DB[:team].select(:abbreviation).to_a
  # espn has different abbreviation from nba_stats

  teams.each do |team|
    roster = c.get_roster team[:abbreviation]
    roster.each do |p| 
      player =  c.get_player(p[:espn_id]) 
      yielder << player 

    end
  end
end

collector = NBA::DataCollector.new provider, TABLE, :batch_size => 10
runner = NBA::DataCollectorClient.new collector
runner.run ARGV
