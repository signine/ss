require 'pp'

module NBA
  class DataCollector
    
    DEFAULTS = { :batch_size => 100, :persist => false }

    def initialize provider, table_name, columns, opts = {}
      @provider = provider
      @table_name = table_name
      @columns = columns
      @default_opts = DEFAULTS.merge opts 
      @data = [] 
      @loaded = false
      @load_lock = Mutex.new
      @persist_lock = Mutex.new
    end

    def collect opts = {}
      opts = @default_opts.merge opts

      @load_lock.synchronize do
        if opts[:persist] == true
          @DB ||= NBA::DBManager.create_connection
          @DB.transaction { _collect opts }
        else
          _collect opts 
        end

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

    private
    def persist batch 
      @persist_lock.synchronize do
        @db ||= NBA::DBManager.create_connection
        table = @db[@table_name]

        batch.each_with_index do |data, i|
          puts "Inserting --> #{i+1}/#{batch.length}"
          table.insert data
        end
      end
    end

    def _collect opts
      batch_size = opts[:batch_size]
      batch_num = 0

      loop do 
         batch_num += 1
         batch = []

         batch_size.times do 
           batch << @provider.next
           pp batch.last
         end
         @data.concat batch

         persist batch if opts[:persist]
         puts "------- Batch: #{batch_num} Size: #{batch.length} -------"
      end
      puts "------- Batch: #{batch_num} Total: #{@data.length} -------"
    end

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
