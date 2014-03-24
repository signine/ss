require 'pp'

module NBA
  class DataCollector
    
    DEFAULTS = { :batch_size => 100, :persist => false, :at_most_once => true }

    def initialize provider, table_name, opts = {}
      @provider = provider
      @table_name = table_name
      @opts = DEFAULTS.merge opts 
      @data = [] 
      @loaded = false
      @load_lock = Mutex.new
      @persist_lock = Mutex.new
    end

    def collect
      @load_lock.synchronize do
        if @opts[:persist] == true
          @DB ||= NBA::DBManager.create_connection
          @DB.transaction { _collect }
        else
          _collect 
        end

        @loaded = true      
      end unless @loaded

      @data
    end

    private
    def persist batch
      @persist_lock.synchronize do
        if @opts[:at_most_once]
          _persist_idempotent batch
        else
          _persist batch
        end
      end
    end

    def _persist_idempotent batch 
      table = @DB[@table_name]
      batch.each_with_index do |record, i|
        if record_exists? record 
          puts "Updating --> #{i+1}/#{batch.length}"
          table.where(get_matching_params(record)).update record
        else
          puts "Inserting --> #{i+1}/#{batch.length}"
          table.insert record 
        end
      end
    end

    def record_exists? record
      records = @DB[@table_name].where(get_matching_params(record)).to_a
      !records.empty?
    end

    def get_matching_params record
      raise "Matching params missing" unless @opts[:match_params] && !@opts[:match_params].empty?
      record.reject { |k,v| !@opts[:match_params].include?(k) }
    end

    def _persist batch 
      table = @DB[@table_name]
      batch.each_with_index do |data, i|
        puts "Inserting --> #{i+1}/#{batch.length}"
        table.insert data
      end
    end

    def _collect
      batch_size = @opts[:batch_size]
      batch_num = 0

      loop do 
         batch_num += 1
         batch = []
         
         begin 
           batch_size.times do 
             batch << @provider.next
             pp batch.last
           end
         ensure 
           @data.concat batch

           persist batch if @opts[:persist]
           puts "------- Batch: #{batch_num} Size: #{batch.length} -------"
         end
      end
      puts "------- Total: #{@data.length} -------"
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
