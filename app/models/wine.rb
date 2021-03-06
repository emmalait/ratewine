class Wine < ApplicationRecord
  belongs_to :winery, touch: true
  belongs_to :style
  has_many :ratings, dependent: :destroy
  has_many :raters, -> { distinct }, through: :ratings, source: :user

  include RatingAverage

  validates :name, presence: true
  validates :style, presence: true

  def average
    return 0 if ratings.empty?

    ratings.map(&:score).sum / ratings.count.to_f
  end

  def to_s
    "#{name} (#{winery.name})"
  end

  def self.top(number)
    sorted_by_rating_in_desc_order = Wine.all.sort_by{ |w| -(w.average_rating || 0) }
    top = sorted_by_rating_in_desc_order.take(number)
    top
  end
end
