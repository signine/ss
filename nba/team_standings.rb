require_relative 'clients/nba_stats'
require_relative 'util/db_manager'
require 'sequel'
require 'nokogiri'
require 'open-uri'

DB = NBA::DBManager.create_connection
$teams = DB[:team]
# teams.each do |team|
# 	puts team[:code]
# end

# standings = DB[:team_standings_timeline]


#c = NBAStats.new "Season" => "2013-14", "LeagueID" => "00", "SeasonType" => "Regular Season"a
def get_code team_name
	$teams.select(:code).where(:city => team_name).first
end

page = Nokogiri::HTML(open("http://www.nba.com/standings/team_record_comparison/conferenceNew_Std_Alp.html"))
p = page.css('div#nbaFullContent table.genStatTable tr')
rows = p.css(".odd").to_a.concat p.css(".even").to_a

rows.each do |r|
	team = {} 
	coulms = r.css('td')
	code = coulms[0].css("a")[0]["href"].gsub(/\//, '')
	p code
end



