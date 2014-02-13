class NBAStatsResources

  RESOURCES =
    {"teaminfocommon"=>
      {:required => ["Season", "TeamID", "LeagueID", "SeasonType"],
       :headers =>
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
         "DIV_RANK"]
      },
     "commonteamyears"=>
      {:required => ["LeagueID"],
       :headers => ["LEAGUE_ID","TEAM_ID","MIN_YEAR","MAX_YEAR","ABBREVIATION"]
      }
    }

  def initialize
    register_structs
  end

  def self.get_headers(resource)
    RESOURCES[resource][:headers]
  end

  def self.get_header_pos(resource, header)
    RESOURCES[resource][:headers].index(header)
  end 

  private 
  def register_structs
    RESOURCES.each do |name, schema|
      headers = schema[:headers].map{|header| header.downcase.to_sym}
      Struct.new(name.capitalize, *headers) unless self.class.const_defined? name.capitalize
    end
  end
end