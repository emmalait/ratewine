class Membership < ApplicationRecord
  belongs_to :user
  belongs_to :wine_club
end
