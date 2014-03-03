module NBA
  module Helpers
    module Team
    
      def get_team_by_abv teams, abv
        team = teams.select { |t| t[:abbreviation] == abv }
        team.empty? ? nil : team.first
      end
    end

  end
end
