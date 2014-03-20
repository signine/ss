require_relative '../clients/nba_stats'
require 'pp'
require 'open-uri'
require 'nokogiri'

class Boxscore
  include NBA::Helpers::Player

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
    #ingest_boxscore
    #ingest_player_stats
    ingest_player_tracking
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
    
    #REFACTOR
    @winner = boxscore[:winner]
    @loser = boxscore[:loser]

    collector = NBA::DataCollector.new [boxscore].to_enum, :game, :persist => true
    collector.collect

    boxscore
  end

  def ingest_player_stats
    player_stats = @nba_stats.get_stat("boxscore", :result_set => "PlayerStats")
#    pp player_stats
    players = []

    player_stats.each do |stat|
      player = {}

      player[:player_name] = stat.player_name
      player[:player_id] = get_player_id player[:name]
      player[:did_not_play] = player_played? stat
      player[:team] = get_team_by_id(stat.team_id)[:code]
      player[:win] = player_win? player[:team]
      player[:game_date] = @game[:date]
      player[:game_id] = get_game()[:id]
      if player[:did_not_play] 
        players << player
        next
      end
      player[:min] = convert_min_to_sec stat.min
      player[:fgm] = stat.fgm
      player[:fga] = stat.fga
      player[:fg] = stat.fg_pct
      player[:fgm3] = stat.fg3m
      player[:fga3] = stat.fg3a
      player[:fg3] = stat.fg3_pct
      player[:ftm] = stat.ftm
      player[:fta] = stat.fta
      player[:ft] = stat.ft_pct
      player[:oreb] = stat.oreb
      player[:dreb] = stat.dreb
      player[:reb] = stat.reb
      player[:ast] = stat.ast
      player[:blk] = stat.blk
      player[:stl] = stat.stl
      player[:tov] = stat.to
      player[:pf] = stat.pf
      player[:pts] = stat.pts
      player[:plus_minus] = stat.plus_minus.to_i

      players << player
    end

    collector = NBA::DataCollector.new players.to_enum, :player_game_log, :persist => true
    collector.collect

    players
  end

  def ingest_player_tracking

  end

  def convert_min_to_sec min
    min = min.split(':')
    (min.first.to_i * 60) + min.last.to_i
  end


  def get_game
    @db ||= NBA::DBManager.create_connection
    game = @db[:game].where(:game_date => @game[:date], :home_team => @game[:home_team]).to_a

    puts "ERROR: No game found: #{@game}" if game.empty?
    puts "ERROR: Multiple games found: #{@game}" if game.length > 1

    game.first
  end

  def player_win? team
    team == @winner ? true : false
  end

  def get_team_by_id id
    @db ||= NBA::DBManager.create_connection
    team = @db[:team].where(:nba_stats_id => id.to_s).to_a

    team.first
  end

  def player_played? stat
    stat.comment.start_with? "DNP"
  end

  def get_player_id name
    @db ||= NBA::DBManager.create_connection
    player =  get_player_by_name name, @db
    puts "ERROR:  No player found with name: #{name}, Game: #{@game}" if player.empty? 
    puts "ERROR: Multiple players found with name: #{name}, Game: #{@game}" if player.length > 1

    player.first ? player.first[:id] : nil
  end

  def game_time_to_min time
    time = time.split(':')
    hr = time.first.strip.to_i * 60
    min = time.last.strip.to_i

    hr + min
  end


end

d = {:date=>"03/18/2014",
    :nba_stats_game_id=>"0021301004",
      :home_team=>"hawks",
        :visitor_team=>"raptors",
          :home_team_nba_stats_id=>1610612737,
            :visitor_team_nba_stats_id=>1610612761}

c = Boxscore.new(d) 
c.work
