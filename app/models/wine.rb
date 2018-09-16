class Wine < ApplicationRecord
    include RatingAverage

    belongs_to :winery
    has_many :ratings, dependent: :destroy
    
    def to_s
        "#{self.name} (#{self.winery.name})"
    end
end
