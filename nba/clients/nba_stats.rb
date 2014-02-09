require_relative "../nba"
require 'httparty'
require 'json'
require 'pp'
require_relative "NBAStatsResources"

class NBAStats
  include HTTParty

  base_uri "http://stats.nba.com/stats/"

  @api = NBAStatsResources.new
  @default_opts = {}

  def initialize(opts = {})
  	@default_opts = opts
  end

  def get_stat_raw(resource, opts = {})
  	raise "Resource: \"#{resource}\" not recognized" unless NBAStatsResources::RESOURCES.include? resource
  	res = NBAStatsResources::RESOURCES[resource]
  	
  	params = @default_opts.merge(opts)
  	check_params res[:required], params

  	response = self.class.get(urlize(resource), query: params)
  	if valid?(response)
  		response.body
  	else
  		raise "Resource: \"#{resource}\" returned code: #{response.code}"
  	end
 	end

  def get_stat(resource, opts = {})
  	response = JSON.parse get_stat_raw(resource, opts)
  	response = extract_data response	
  	convert_to_struct(resource, response)
  end

  private
  def convert_to_struct(resource, response)
  	response.map! {|data| eval "Struct::#{resource.capitalize}.new(*data)"}
  end

  def check_params(required, given)
  	not_found = required.select {|k, v| !given.include? k}
  	raise "Required params: #{not_found}" if not_found.length > 0 
  end

  def urlize(resource)
  	"/" + resource
  end

  def valid?(response)
  	response.code == 200
  end

  def extract_data(response)
  	response["resultSets"][0]["rowSet"]
  end
end