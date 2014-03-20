module NBA
  module Helpers
    module Team
    
      def get_team_by_abv teams, abv
        team = teams.select { |t| t[:abbreviation] == abv }
        team.empty? ? nil : team.first
      end
    end

    module Player
      
      def get_player_by_name name, db
        db[:players].where(:name => name).to_a
      end

    end

  end
end
