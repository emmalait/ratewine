module RatingAverage
  extend ActiveSupport::Concern

  def average_rating
    if ratings.count.zero?
      0
    else
      ratings.average(:score)
    end
  end
end
