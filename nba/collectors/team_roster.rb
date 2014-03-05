require_relative '../clients/espn'
require_relative '../util/db_manager'
require 'sequel'

TABLE = :team_roster
SEASON = "2013-14"
COLUMNS = [:jersey, :pos, :age, :wt, :ht, :salary, :name, :team, :season, :player_id] 
DB = NBA::DBManager.create_connection
$c = NBA::ESPN.new

loader = 
Proc.new do
  players = []
  teams = DB[:team].all

  teams.each do |team|
    puts team[:abbreviation]
    roster = $c.get_roster team[:abbreviation]
    roster.map do |p| 
      p[:player_id] = find_player_id_by_name p
      p[:season] = SEASON
      p[:team] = team[:code] 
      p.delete :espn_id
    end
    players.concat roster

    pp roster
  end

  players
end

def find_player_id_by_name player
  ret = DB[:players].select(:id).where(:name => player[:name]).to_a
  if ret.empty?
    puts "No player found: #{player}"
    DB[:players].insert $c.get_player(player[:espn_id])
    return find_player_id_by_name player
  elsif ret.length > 1
    raise "Multiple players found for:  #{player}"
  end 
  
  ret.first[:id]
end

collector = NBA::DataCollector.new loader, TABLE, COLUMNS
collector.run ARGV
