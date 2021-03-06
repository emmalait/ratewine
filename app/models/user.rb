class User < ApplicationRecord
  has_many :ratings, dependent: :destroy
  has_many :wines, through: :ratings
  has_many :memberships
  has_many :wine_clubs, through: :memberships

  include RatingAverage

  has_secure_password

  validates :username,  uniqueness: true,
                        length: { minimum: 3,
                                  maximum: 30 }
  validates :password,  length: { minimum: 4 },
                        format: {
                          with: /\A(?=.*[a-z]+)(=?.*[A-Z]+)(=?.*[1-9]+)\z/,
                          message: "must include at least one capital letter and one number."
                        }

  def self.top(number)
    sorted_by_ratings_in_desc_order = User.all.sort_by{ |u| u.ratings.count }
    top = sorted_by_ratings_in_desc_order.reverse!.take(number)
    top
  end

  def favourite_wine
    return nil if ratings.empty?

    ratings.order(score: :desc).limit(1).first.wine
  end

  def average_of(ratings)
    ratings.sum(&:score).to_f / ratings.count
  end

  def favourite_style
    return nil if ratings.empty?

    style_ratings = ratings.group_by{ |r| r.wine.style }
    averages = style_ratings.map do |style, ratings|
      { style: style, score: average_of(ratings) }
    end

    averages.max_by{ |r| r[:score] } [:style]
  end

  def favourite_winery
    return nil if ratings.empty?

    style_ratings = ratings.group_by{ |r| r.wine.winery }
    averages = style_ratings.map do |winery, ratings|
      { winery: winery, score: average_of(ratings) }
    end

    averages.max_by{ |r| r[:score] }[:winery]
  end
end
