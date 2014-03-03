require_relative '../clients/espn'
require_relative '../util/db_manager'
require 'sequel'


DB = NBA::DBManager.create_connection
c = NBA::ESPN.new
teams = DB[:team].select(:abbreviation)
players = []
teams.each do |team|
  puts team[:abbreviation]
  roster = c.get_roster team[:abbreviation]
  roster.each { |p| players << c.get_player(p[:espn_id]) }
end

puts players.length
puts players.last
