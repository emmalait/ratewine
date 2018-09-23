class User < ApplicationRecord
  include RatingAverage

  has_secure_password

  validates :username,  uniqueness: true,
                        length: { minimum: 3,
                                  maximum: 30 }
  validates :password,  length: { minimum: 4 },
                        format: { with: /\A(?=.*[a-z]+)(=?.*[A-Z]+)(=?.*[1-9]+)\z/,
                                  message: "must include at least one capital letter and one number." }

  has_many :ratings, dependent: :destroy
  has_many :wines, through: :ratings
end
