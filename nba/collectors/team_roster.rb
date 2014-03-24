require_relative '../clients/espn'
require_relative '../nba'
require 'sequel'

TABLE = :team_roster
SEASON = "2013-14"
COLUMNS = [:jersey, :pos, :age, :wt, :ht, :salary, :name, :team, :season, :player_id] 
DB = NBA::DBManager.create_connection
$c = NBA::ESPN.new

provider = 
Enumerator.new do |yielder|
  teams = DB[:team].all

  teams.each do |team|
    puts team[:abbreviation]
    roster = $c.get_roster team[:abbreviation]
    roster.map do |p| 
      p[:player_id] = find_player_id_by_name p
      p[:season] = SEASON
      p[:team] = team[:code] 
      p.delete :espn_id

      if record_exists?(:team_roster, p)
        puts "Found player: #{p}"
        next
      end

      yielder << p
    end
  end
end

def record_exists? table, record
  ret = DB[table].where(record).to_a
  !ret.empty?
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

runner = NBA::DataCollectorClient.new provider, TABLE, :batch_size => 10, :match_params => [:season, :team, :name]
runner.run ARGV
