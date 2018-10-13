class Membership < ApplicationRecord
  belongs_to :user
  belongs_to :wine_club

  validates :wine_club, uniqueness: {
    scope: :user,
    message: "You are already a memeber!"
  }
end
