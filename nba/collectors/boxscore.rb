require_relative '../clients/nba_stats'
require 'pp'
require 'open-uri'
require 'nokogiri'

class Boxscore
  
  SEASON = "2013-14"
  SEASON_TYPE = "regular"

  def initialize game
    @game = game
  end

  def work
    @nba_stats ||= NBAStats.new "GameID" => @game[:nba_stats_game_id], 
                                "RangeType" => 0, 
                                "StartRange" => 0, 
                                "EndRange" => 0, 
                                "StartPeriod" => 0, 
                                "EndPeriod"=> 0 
    ingest_boxscore
    #ingest_player_stats
    #ingest_player_tracking
  end

  private
  def ingest_boxscore
    game_info = @nba_stats.get_stat("boxscore", :result_set => "GameInfo").first
    line_score = @nba_stats.get_stat("boxscore", :result_set => "LineScore")

    boxscore = {}

    boxscore[:game_date] = @game[:date]
    boxscore[:season] = SEASON
    boxscore[:season_type] = SEASON_TYPE
    boxscore[:nba_stats_game_id] = @game[:nba_stats_game_id]
    boxscore[:home_team] = @game[:home_team]
    boxscore[:visitor_team] = @game[:visitor_team]
    boxscore[:home_team_score] = line_score.select { |t| t[:team_id] == @game[:home_team_nba_stats_id] }.first[:pts]
    boxscore[:visitor_team_score] = line_score.select { |t| t[:team_id] == @game[:visitor_team_nba_stats_id] }.first[:pts]
    boxscore[:winner] = boxscore[:home_team_score] > boxscore[:visitor_team_score] ? boxscore[:home_team] : boxscore[:visitor_team]
    boxscore[:loser] = boxscore[:home_team_score] > boxscore[:visitor_team_score] ? boxscore[:visitor_team] : boxscore[:home_team]
    boxscore[:attendance] = game_info[:attendance]
    boxscore[:duration] = game_time_to_min game_info[:game_time]
    
    collector = NBA::DataCollector.new [boxscore].to_enum, :game, :persist => true
    collector.collect

    boxscore
  end

  def ingest_player_stats


  end

  def game_time_to_min time
    time = time.split(':')
    hr = time.first.strip.to_i * 60
    min = time.last.strip.to_i

    hr + min
  end


end

=begin
d = {:date=>"03/18/2014",
    :nba_stats_game_id=>"0021301004",
      :home_team=>"hawks",
        :visitor_team=>"raptors",
          :home_team_nba_stats_id=>1610612737,
            :visitor_team_nba_stats_id=>1610612761}

c = Boxscore.new(d) 
c.work
=end
