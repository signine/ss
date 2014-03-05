require_relative 'ESPNResources'
require 'nokogiri'
require 'open-uri'
require 'date'

module NBA
  class ESPN
    include NBA::ESPNResources    
     
    TEAM_ABV_OVERRIDE = 
      {
        "UTA" => "UTH",
        "NOP" => "NO"
      }

    def get_roster team_abv
      team_abv = check_overrides team_abv
      roster_url = RESOURCES[:roster][:url] % team_abv   
      page = Nokogiri::HTML(open(roster_url))

      # TODO: make this pretty
      d_table = page.css("table.tablehead")
      rows = d_table.first.css("tr.oddrow").to_a.concat(d_table.first.css("tr.evenrow").to_a)

      players = []
      rows.each do |r|
        r_data = r.css("td")
        players << make_player(r_data)
      end

      players
    end
    
    def get_player id
      url = RESOURCES[:player][:url] % id
      page = Nokogiri::HTML(open(url))
      player = {}
      player[:name] = parse_name page
      
      ht_wt_string = page.css("ul.general-info li")[1].text
      player[:wt] = parse_wt ht_wt_string
      player[:ht] = parse_ht ht_wt_string

      page = page.css("ul.player-metadata li")
      birth_string = find_info_string page, "Born"
      player.merge! parse_birth birth_string if birth_string

      draft_string = find_info_string page, "Drafted" 
      player.merge! parse_draft draft_string if draft_string
      
      college = find_info_string page, "College" 
      player[:college] = college if college 
      player[:espn_id] = id

      player
    end

    private
    def check_overrides abv
      return TEAM_ABV_OVERRIDE[abv] if TEAM_ABV_OVERRIDE.has_key? abv
      abv
    end

    def find_info_string page, info_type
      string = page.select { |p| p.text.start_with? info_type }.first
      if string
        string.text.gsub(/#{info_type}/, '')
      else
        nil
      end
    end

    def make_player row_data
      player = {}
      ROSTER_TABLE.each { |header, index|  player[header] = row_data[index].text }
      url = row_data[ROSTER_TABLE[:name]].css("a")[0]["href"]
      player[:jersey] = player[:jersey].to_i
      player[:age] = player[:age].to_i
      player[:wt] = player[:wt].to_i
      player[:ht] = convert_ht player[:ht].gsub!(/-/, "' ")
      player[:salary] = player[:salary].gsub!(/[$,]/, '')
      player[:espn_id] = get_player_id_from_url url

      player
    end

    def get_player_id_from_url url
      url.split("/")[-2].to_i
    end

    def parse_name page
      page.css("div.mod-content h1").text
    end

    def parse_wt string
      string.split(',').last.strip!.split.first.to_i
    end
    
    # Replace the middle space with '0' if inches is single digit
    # i.e 6' 3" -> 6'03"
    # If inches is double digit, replace space with ''
    # i.e 6' 10" -> 6'10"
    def parse_ht string
      raw = string.split(',').first.strip
      convert_ht raw
     end

    def convert_ht ht
      ht.chomp!('"')
      replace = ht.length == 4 ? '0' : '' 
      ht.gsub!(/ /, replace)

      ht
    end

    def parse_birth string
      info = {}
      tokens = string.split(" in ")
      info[:bdate] = Date.strptime(tokens.first, "%b %e, %Y")
      info[:bplace] = tokens.last.gsub!(/ \(.+\)/, '').strip
      
      info
    end

    def parse_draft string
      info = {}
      tokens = string.split(':')
      info[:draft_year] = tokens.first.strip.to_i

      round = /(\d*)/.match(tokens.last.split(",")[0].strip)
      info[:draft_round] = round.captures.first.to_i

      pick = /(\d*)/.match(tokens.last.split(",")[1].strip)
      info[:draft_pick] = pick.captures.first.to_i

      team = /([A-Z]*)$/.match(tokens.last.split(",")[1].strip)
      info[:draft_team] = team.captures.first

      info
    end

  end
end

#c = NBA::ESPN.new
#puts c.get_player 6590
#puts c.get_roster 'phx'
