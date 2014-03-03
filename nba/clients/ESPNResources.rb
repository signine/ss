module NBA
  module ESPNResources
    RESOURCES = {
                  :roster => {
                               :url =>  "http://espn.go.com/nba/team/roster/_/name/%s",
                               :required => [:abbriviation],
                               :headers => [:jersey, :name, :pos, :age, :ht, :wt, :salary, :espn_player_id]
                             },
                  :player => { 
                               :url => "http://insider.espn.go.com/nba/player/_/id/%d",
                               :required => [:espn_player_id],
                               :headers => [
                                            :name,
                                            :bday,
                                            :bplace,
                                            :college,
                                            :ht,
                                            :wt,
                                            :draft_year,
                                            :draft_round,
                                            :draft_pick,
                                            :draft_team,
                                            :espn_id
                                           ]
                                           
                             }
                }

    ROSTER_TABLE =
    {
      :jersey => 0,
      :name => 1,
      :pos => 2,
      :age => 3,
      :ht => 4,
      :wt => 5,
      :salary => 7
    }
  end
end
