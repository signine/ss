require_relative '../clients/nba_stats'
require_relative '../collectors/boxscore.rb'
require 'pp'

DB = NBA::DBManager.create_connection

def get_game_events
  game_date = Date.today.prev_day.strftime("%m/%d/%Y") 
  c = NBAStats.new "LeagueID" => "00", "DayOffset" => 0, "gameDate" => game_date 

  games = c.get_stat("scoreboard")
  events = []
  games.each do |game|
    events <<
            {
             :date => game_date,
             :nba_stats_game_id => game.game_id,
             :home_team => DB[:team].select(:code).where(:nba_stats_id => game.home_team_id.to_s).to_a.first[:code],
             :visitor_team => DB[:team].select(:code).where(:nba_stats_id => game.visitor_team_id.to_s).to_a.first[:code],
             :home_team_nba_stats_id => game.home_team_id,
             :visitor_team_nba_stats_id => game.visitor_team_id,
            }
  end

  events.each do |e|
    b = Boxscore.new e
    b.work
  end

end
get_game_events
=begin
e = get_game_events
b = Boxscore.new e.first
pp b.work
=end
