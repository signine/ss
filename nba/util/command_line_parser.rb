module NBA
  module CommandLineParser

  	def get_command argv
      argv.reverse.first
    end

    def get_opts argv
    	return [] if argv.length < 2
    	argv.slice(0, argv.length - 1).select {|c| option? c}
    end

    private
    def option? option
    	option.start_with? "-"
    end
  end
end