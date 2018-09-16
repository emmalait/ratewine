class Rating < ApplicationRecord
    belongs_to :wine

    def to_s
        "#{self.wine.name} #{self.score}"
    end
end
