require_relative 'clients/nba_stats'
require_relative 'util/db_manager'
require 'sequel'
require 'nokogiri'
require 'open-uri'

wins = -> (text) { text.split("-").first }
losses = -> (text) { text.split("-").last }

DEFAULTS = {:season_year => "2013-14", :season_type => "regular"}
DB = NBA::DBManager.create_connection

TABLE = :team_standings_timeline
COLUMNS = [:season_year, :season_type, :team, :team_conference, :team_division, :conf_rank, :div_rank, :pct, :gb, :conf_wins, :conf_losses, :div_wins, :div_losses, :home_wins, :home_losses, :road_wins, :road_losses, :wins, :losses, :total_games, :last_10_wins, :last_10_losses, :streak]

loader =
Proc.new do
  teams = DB[:team].all

  c = NBAStats.new "Season" => "2013-14", "LeagueID" => "00", "SeasonType" => "Regular Season"
  conf_data = []
  teams.each {|t| conf_data << c.get_stat("teaminfocommon", "TeamID" => t[:nba_stats_id]).first}

  page = Nokogiri::HTML(open("http://www.nba.com/standings/team_record_comparison/conferenceNew_Std_Alp.html"))
  p = page.css('div#nbaFullContent table.genStatTable tr')
  rows = p.css(".odd").to_a.concat p.css(".even").to_a

  data = []

  rows.each do |r|
    team = {}.merge DEFAULTS
    columns = r.css('td')
    code = columns[0].css("a")[0]["href"].gsub(/\//, '')
    info = conf_data.select {|t| t.team_code == code}.first

    team[:team] = code
    team[:team_conference] = info.team_conference
    team[:team_division] = info.team_division
    team[:conf_rank] = info.conf_rank
    team[:div_rank] = info.div_rank
    team[:pct] = columns[3].text.to_f
    team[:gb] = columns[4].text.to_f
    team[:conf_wins] = wins.call columns[5].text
    team[:conf_losses] = losses.call columns[5].text
    team[:div_wins] = wins.call columns[6].text
    team[:div_losses] = losses.call columns[6].text
    team[:home_wins] = wins.call columns[7].text
    team[:home_losses] = losses.call columns[7].text
    team[:road_wins] = wins.call columns[8].text
    team[:road_losses] = losses.call columns[8].text
    team[:wins] = info.w
    team[:losses] = info.l
    team[:total_games] = info.w = info.l
    team[:last_10_wins] = wins.call columns[9].text
    team[:last_10_losses] = losses.call columns[9].text
    team[:streak] = columns[10].text

    data << team
    pp team
  end
  data
end

collector = NBA::DataCollector.new loader, TABLE, COLUMNS

collector.run ARGV
