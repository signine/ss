require_relative '../clients/nba_stats'
require_relative '../collectors/boxscore.rb'
require 'pp'

DB = NBA::DBManager.create_connection

def get_game_events
  c = NBAStats.new "LeagueID" => "00", "DayOffset" => 0, "gameDate" => Date.today.prev_day.strftime("%m/%d/%Y") 
  games = c.get_stat("scoreboard")
  events = []
  games.each do |game|
    events <<
            {
             :date => game.game_date_est,
             :nba_stats_game_id => game.game_id,
             :home_team => DB[:team].select(:code).where(:nba_stats_id => game.home_team_id.to_s).to_a.first,
             :visitor_team => DB[:team].select(:code).where(:nba_stats_id => game.visitor_team_id.to_s).to_a.first,
             :home_team_nba_stats_id => game.home_team_id,
             :visitor_team_nba_stats_id => game.visitor_team_id,
            }
  end

  events
end

e = get_game_events
b = Boxscore.new e.first
pp b.work
