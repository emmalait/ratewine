class Winery < ApplicationRecord
  has_many :wines, dependent: :destroy
  has_many :ratings, through: :wines

  validates :name, presence: true
  validates :year, numericality: {  greater_than_or_equal_to: 1040,
                                    less_than_or_equal_to: ->(_) { Time.now.year },
                                    only_integer: true }

  include RatingAverage
end
