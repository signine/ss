require_relative '../clients/espn'
require_relative '../util/db_manager'
require 'sequel'

TABLE = :players
COLUMNS = [:name, :wt, :ht, :college, :bplace, :bdate, :draft_year, :draft_round, :draft_pick, :draft_team, :espn_id]
DB = NBA::DBManager.create_connection

loader = 
Proc.new do 
  c = NBA::ESPN.new
  teams = DB[:team].select(:abbreviation).to_a
  # espn has different abbreviation from nba_stats
  teams.select { |t| t[:abbreviation] == "UTA" }.first[:abbreviation] = "UTH"
  teams.select { |t| t[:abbreviation] == "NOP" }.first[:abbreviation] = "NO"
  players = []

  teams.each do |team|
    puts team[:abbreviation]
    roster = c.get_roster team[:abbreviation]
    roster.each do |p| 
      player =  c.get_player(p[:espn_id]) 
      players << player 

      pp player
    end
  end

  players
end

collector = NBA::DataCollector.new loader, TABLE, COLUMNS
collector.run ARGV
