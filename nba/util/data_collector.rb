require_relative 'command_line_parser'
require 'thread'
require 'pp'

module NBA
  class DataCollector
  	include NBA::CommandLineParser

  	def initialize loader, table_name, columns, opts = {}
      @loader = loader
      @table_name = table_name
      @columns = columns
      @default_opts = opts
      @data = nil
      @loaded = false
      @load_lock = Mutex.new
      @persist_lock = Mutex.new
  	end

  	def run argv
  		command = get_command argv
  		opts = parse_opts(get_opts(argv))

  		case command
  		when "dry-run"
  			collect
  			print
  		when "load"
  			collect 
  			persist opts
  		else
  			raise "Unknown command: #{command}"
  		end
  	end

  	def collect
  		@load_lock.synchronize do
  	    @data = @loader.call
        @loaded = true			
  		end unless @loaded

  		@data
  	end

  	def print
  		collect unless @loaded

  		puts "COLUMNS: #{@columns}"
      @data.each {|data| pp data }
      puts "Total: #{@data.length}"
  	end

  	def persist opts = {}
      options = @default_opts.merge opts

      @persist_lock.synchronize do
      	collect unless @loaded
        db = NBA::DBManager.create_connection
        table = db[@table_name]

        @data.each_with_index do |data, i|
          log "Inserting #{data}\n --> #{i+1}/#{@data.length}", options
          table.insert data
        end
      end
  	end

  	private
  	def log msg, opts = {}
      puts msg unless opts.include?(:quiet) && opts[:quiet] == true
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