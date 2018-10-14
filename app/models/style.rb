class Style < ApplicationRecord
  has_many :wines
  has_many :ratings, through: :wines

  include RatingAverage

  def average
    return 0 if ratings.empty?

    ratings.map(&:score).sum / ratings.count.to_f
  end

  def self.top(number)
    sorted_by_rating_in_desc_order = Style.all.sort_by{ |w| -(w.average_rating || 0) }
    top = sorted_by_rating_in_desc_order.take(number)
    top
  end
end
