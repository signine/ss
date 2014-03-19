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
      pp response
      raise "Resource: \"#{resource}\" returned code: #{response.code}"
    end
  end

  def get_stat(resource, opts = {})
    response = JSON.parse get_stat_raw(resource, opts)
    response = extract_data response, opts  
    convert_to_struct(resource, response, opts)
  end

  private
  def convert_to_struct(resource, response, opts)
    struct_name = opts[:result_set] ? opts[:result_set] : NBAStatsResources::RESOURCES[resource][:result_set].first[:name]
    response.map! {|data| eval "Struct::#{struct_name}.new(*data)"}
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

  def extract_data(response, opts)
    if opts[:result_set]
      response["resultSets"].select { |r| r["name"] == opts[:result_set] }.first["rowSet"]
    else
      response["resultSets"].first["rowSet"]
    end
  end
end
