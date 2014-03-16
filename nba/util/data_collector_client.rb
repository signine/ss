require_relative 'command_line_parser'
require 'pp'

module NBA
  class DataCollectorClient
    include NBA::CommandLineParser

    def initialize collector 
      @collector = collector
    end

    def run argv
      command = get_command argv
      opts = parse_opts(get_opts(argv))

      case command
      when "dry-run" then @collector.collect
      when "load" then @collector.collect :persist => true
      else
        raise "Unknown command: #{command}"
      end
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
