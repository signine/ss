require_relative "../nba"
require 'sequel'

module NBA
  module DBManager

    DEFAULT = {:adapter=>'postgres', :database=>'nba'}

    def self.create_connection opts = {}
      Sequel.connect(DEFAULT.merge(opts))
    end

  end
end
