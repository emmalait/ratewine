class Winery < ApplicationRecord
  include RatingAverage

  has_many :wines, dependent: :destroy
  has_many :ratings, through: :wines

  validates :name, presence: true
  validates :year, numericality: {  greater_than_or_equal_to: 1040,
                                    only_integer: true }
  validate :year_cannot_be_in_the_future

  def year_cannot_be_in_the_future
    if year > Time.now.year
      errors.add(:year, "can not be in the future.")
    end
  end

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
