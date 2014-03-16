require 'sequel'

module NBA
  module DBManager

    DEFAULT = {:adapter=>'postgres', :database=>'nba', :user=>'postgres'}

    def self.create_connection opts = {}
      Sequel.connect(DEFAULT.merge(opts))
    end

  end
end
