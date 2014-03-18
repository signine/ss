class NBAStatsResources

  RESOURCES = 
  {"teaminfocommon"=>
  {:required=>["Season", "TeamID", "LeagueID", "SeasonType"],
   :result_set=>
    [{:name=>"TeamInfoCommon",
      :headers=>
       ["TEAM_ID",
        "SEASON_YEAR",
        "TEAM_CITY",
        "TEAM_NAME",
        "TEAM_ABBREVIATION",
        "TEAM_CONFERENCE",
        "TEAM_DIVISION",
        "TEAM_CODE",
        "W",
        "L",
        "PCT",
        "CONF_RANK",
        "DIV_RANK"]},
     {:name=>"TeamSeasonRanks",
      :headers=>
       ["LEAGUE_ID",
        "SEASON_ID",
        "TEAM_ID",
        "PTS_RANK",
        "PTS_PG",
        "REB_RANK",
        "REB_PG",
        "AST_RANK",
        "AST_PG",
        "OPP_PTS_RANK",
        "OPP_PTS_PG"]}]},
 "commonteamyears"=>
  {:required=>["LeagueID"],
   :result_set=>
    [{:name=>"TeamYears",
      :headers=>
       ["LEAGUE_ID", "TEAM_ID", "MIN_YEAR", "MAX_YEAR", "ABBREVIATION"]}]},
 "commonallplayers"=>
  {:required=>["Season", "IsOnlyCurrentSeason", "LeagueID"],
   :result_set=>
    [{:name=>"CommonAllPlayers",
      :headers=>
       ["PERSON_ID",
        "DISPLAY_LAST_COMMA_FIRST",
        "ROSTERSTATUS",
        "FROM_YEAR",
        "TO_YEAR",
        "PLAYERCODE"]}]},
 "scoreboard"=>
  {:required=>["LeagueID", "gameDate", "DayOffset"],
   :result_set=>
    [{:name=>"GameHeader",
      :headers=>
       ["GAME_DATE_EST",
        "GAME_SEQUENCE",
        "GAME_ID",
        "GAME_STATUS_ID",
        "GAME_STATUS_TEXT",
        "GAMECODE",
        "HOME_TEAM_ID",
        "VISITOR_TEAM_ID",
        "SEASON",
        "LIVE_PERIOD",
        "LIVE_PC_TIME",
        "NATL_TV_BROADCASTER_ABBREVIATION",
        "LIVE_PERIOD_TIME_BCAST",
        "WH_STATUS"]},
     {:name=>"LineScore",
      :headers=>
       ["GAME_DATE_EST",
        "GAME_SEQUENCE",
        "GAME_ID",
        "TEAM_ID",
        "TEAM_ABBREVIATION",
        "TEAM_CITY_NAME",
        "TEAM_WINS_LOSSES",
        "PTS_QTR1",
        "PTS_QTR2",
        "PTS_QTR3",
        "PTS_QTR4",
        "PTS_OT1",
        "PTS_OT2",
        "PTS_OT3",
        "PTS_OT4",
        "PTS_OT5",
        "PTS_OT6",
        "PTS_OT7",
        "PTS_OT8",
        "PTS_OT9",
        "PTS_OT10",
        "PTS",
        "FG_PCT",
        "FT_PCT",
        "FG3_PCT",
        "AST",
        "REB",
        "TOV"]},
     {:name=>"SeriesStandings",
      :headers=>
       ["GAME_ID",
        "HOME_TEAM_ID",
        "VISITOR_TEAM_ID",
        "GAME_DATE_EST",
        "HOME_TEAM_WINS",
        "HOME_TEAM_LOSSES",
        "SERIES_LEADER"]},
     {:name=>"LastMeeting",
      :headers=>
       ["GAME_ID",
        "LAST_GAME_ID",
        "LAST_GAME_DATE_EST",
        "LAST_GAME_HOME_TEAM_ID",
        "LAST_GAME_HOME_TEAM_CITY",
        "LAST_GAME_HOME_TEAM_NAME",
        "LAST_GAME_HOME_TEAM_ABBREVIATION",
        "LAST_GAME_HOME_TEAM_POINTS",
        "LAST_GAME_VISITOR_TEAM_ID",
        "LAST_GAME_VISITOR_TEAM_CITY",
        "LAST_GAME_VISITOR_TEAM_NAME",
        "LAST_GAME_VISITOR_TEAM_CITY1",
        "LAST_GAME_VISITOR_TEAM_POINTS"]},
     {:name=>"EastConfStandingsByDay",
      :headers=>
       ["TEAM_ID",
        "LEAGUE_ID",
        "SEASON_ID",
        "STANDINGSDATE",
        "CONFERENCE",
        "TEAM",
        "G",
        "W",
        "L",
        "W_PCT",
        "HOME_RECORD",
        "ROAD_RECORD"]},
     {:name=>"WestConfStandingsByDay",
      :headers=>
       ["TEAM_ID",
        "LEAGUE_ID",
        "SEASON_ID",
        "STANDINGSDATE",
        "CONFERENCE",
        "TEAM",
        "G",
        "W",
        "L",
        "W_PCT",
        "HOME_RECORD",
        "ROAD_RECORD"]}]}}


  def initialize
    register_structs
  end

  def self.get_headers(resource, result_set = '')
    if result_set.empty?
      RESOURCES[resource][:result_set].first[:headers]
    else
      RESOURCES[resource][:result_set].select { |r| r[:name] == result_set }[:headers]
    end
  end

=begin
  # broken
  def self.get_header_pos(resource, header)
    RESOURCES[resource][:headers].index(header)
  end 
=end

  private 
  def register_structs
    RESOURCES.each do |k, r|
      r[:result_set].each do |info|
        headers = info[:headers].map{|header| header.downcase.to_sym}
        name = info[:name]
        Struct.new(name, *headers) unless self.class.const_defined? name
     end
    end
  end

end
