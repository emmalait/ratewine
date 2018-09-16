class Winery < ApplicationRecord
    has_many :wines, dependent: :destroy
    has_many :ratings, through: :wines

    def print_report
        puts self.name
        puts "established in year #{self.year}"
        puts "number of wines #{self.wines.count}"
    end

    def restart
        self.year = 2018
        puts "changed year to #{year}"
    end

    def average_rating
        self.ratings.average(:score)
    end

end
