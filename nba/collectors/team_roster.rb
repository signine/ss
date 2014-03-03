require_relative '../clients/nba_stats'
require_relative '../util/db_manager'
require 'sequel'
require 'nokogiri'
require 'open-uri'

include NBA::Helpers::Team

# column name to position
COLUMNS =
  {
    :jersey => 0,
    :name => 1,
    :pos => 2,
    :age => 3,
    :ht => 4,
    :wt => 5,
    :college => 6,
    :salary => 7
  }

SEASON = "2013-14"
ESPN_ROSTER_URL = "http://espn.go.com/nba/team/roster/_/name/%s"
DB = NBA::DBManager.create_connection
teams = DB[:team].all

teams.each { |t|
  puts get_team_by_abv teams, t[:abbreviation]
}

teams.each do |team|
  players = []
  puts team[:abbreviation]
  page = Nokogiri::HTML(open(ESPN_ROSTER_URL % [team[:abbreviation]]))

  # TODO: make this pretty
  d_table = page.css("table.tablehead")
  rows = d_table.first.css("tr.oddrow").to_a.concat(d_table.first.css("tr.evenrow").to_a)
  rows.each do |r|
  r_data = r.css("td")
    
  player << {
               :team => team[:code],
               :season => SEASON,
               :player_id => 
               :
            }
  end
end
