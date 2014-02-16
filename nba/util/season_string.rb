module NBA
  module SeasonString 
    def self.get_seasons first, last
      seasons = []

      (first...last).each do |i|
        next_ = (i + 1).to_s
        seasons << "#{i}-#{next_[(next_.length-2)..next_.length-1]}"
      end 

      seasons
    end
  end
end