class Winery < ApplicationRecord
  has_many :wines, dependent: :destroy
  has_many :ratings, through: :wines

  validates :name, presence: true
  validates :year, numericality: {  greater_than_or_equal_to: 1040,
                                    less_than_or_equal_to: ->(_) { Time.now.year },
                                    only_integer: true }

  scope :active, -> { where active: true }
  scope :retired, -> { where active: [nil, false] }

  include RatingAverage

  def average
    return 0 if ratings.empty?

    ratings.map(&:score).sum / ratings.count.to_f
  end

  def self.top(number)
    sorted_by_rating_in_desc_order = Winery.all.sort_by{ |w| -(w.average_rating || 0) }
    top = sorted_by_rating_in_desc_order.take(number)
    top
  end
end
