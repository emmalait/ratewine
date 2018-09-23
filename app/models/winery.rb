class Winery < ApplicationRecord
  include RatingAverage

  has_many :wines, dependent: :destroy
  has_many :ratings, through: :wines

  validates :name, presence: true
  validates :year, numericality: {  greater_than_or_equal_to: 1040,
                                    less_than_or_equal_to: 2018,
                                    only_integer: true }

  def print_report
    puts name
    puts "established in year #{year}"
    puts "number of wines #{wines.count}"
  end

  def restart
    self.year = 2018
    puts "changed year to #{year}"
  end
end
