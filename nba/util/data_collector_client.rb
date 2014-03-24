require_relative 'command_line_parser'
require 'pp'

#REFACTOR: use a builder
module NBA
  class DataCollectorClient
    include NBA::CommandLineParser

    def initialize provider, table, opts = {} 
      @provider = provider
      @table = table
      @opts = opts
    end

    def run argv
      command = get_command argv
      opts = parse_opts(get_opts(argv))

      case command
      when "dry-run" then 
      when "load" then @opts.merge! :persist => true
      else
        raise "Unknown command: #{command}"
      end

      collector = DataCollector.new @provider, @table, @opts
      collector.collect
    end

    def parse_opts flags
      flags.inject({}) { |opts, flag| opts.merge parse_flag(flag) }
    end

    def parse_flag flag
      case flag
        when "-q" then {:quiet => true}
      end
    end

  end
end
