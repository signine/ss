require 'open-uri'
require 'nokogiri'

class Boxscore

  NBA_BOXSCORE_URL = "http://stats.nba.com/gameDetail.html?GameID=%d"
  
  def initialize game
    @game = game
  end

  def work
    page = Nokogiri::HTML(open(NBA_BOXSCORE_URL%(@game[:nba_stats_game_id].to_i)))
    pp page
  end

end
