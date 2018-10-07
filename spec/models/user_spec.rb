require 'rails_helper'

include Helpers

RSpec.describe User, type: :model do
  it "has username set correctly" do
    user = User.new username:"Pekka"

    expect(user.username).to eq("Pekka")
  end

  it "is not saved without a password" do
    user = User.create username:"Pekka"

    expect(user).not_to be_valid
    expect(User.count).to eq(0)
  end

  it "is not saved with a password too short" do
    user = User.create username:"Pekka", password:"Sec", password_confirmation:"Sec"
    expect(user).not_to be_valid
    expect(User.count).to eq(0)
  end

  it "is not saved with a password without number" do
    user = User.create username:"Pekka", password:"Secret", password_confirmation:"Secret"
    expect(user).not_to be_valid
    expect(User.count).to eq(0)
  end

  describe "with a proper password" do
    let(:user){ FactoryBot.create(:user) }
    
    it "is saved" do
      expect(user).to be_valid
      expect(User.count).to eq(1)
    end

    it "and with two ratings, has the correct average rating" do
      FactoryBot.create(:rating, score: 10, user: user)
      FactoryBot.create(:rating, score: 20, user: user)

      expect(user.ratings.count).to eq(2)
      expect(user.average_rating).to eq(15.0)
    end
  end

  describe "favourite wine" do
    let(:user) { FactoryBot.create(:user) }
  
    it "has method for determining one" do
      expect(user).to respond_to(:favourite_wine)
    end

    it "without ratings does not have one" do
      expect(user.favourite_wine).to eq(nil)
    end

    it "is the only rated if only one rating" do
      wine = FactoryBot.create(:wine)
      rating = FactoryBot.create(:rating, score: 20, wine: wine, user: user)

      expect(user.favourite_wine).to eq(wine)
    end

    it "is the one with highest rating if several rated" do
      create_wines_with_many_ratings({user: user}, 10, 20, 15, 7, 9)
      best = create_wine_with_rating( { user: user }, 25 )

      expect(user.favourite_wine).to eq(best)
    end

  end

  describe "favourite style" do
    let(:user) { FactoryBot.create(:user) }
  
    it "has method for determining one" do
      expect(user).to respond_to(:favourite_style)
    end

    it "without ratings does not have one" do
      expect(user.favourite_style).to eq(nil)
    end

    it "is the style of the only rated if only one rating" do
      create_wine_with_rating({ user: user, style: 'Riesling' }, 25)

      expect(user.favourite_style).to eq('Riesling')
    end  
    
    it "is the style of with highest average if several rated" do
      create_wines_with_many_ratings({ user: user, style: 'Riesling' }, 10, 20, 15, 7, 9)
      create_wines_with_many_ratings({ user: user, style: 'Merlot' }, 25, 45 )
      create_wines_with_many_ratings({ user: user, style: 'Zinfandel' }, 50, 10, 8)

      expect(user.favourite_style).to eq('Merlot')
    end 

  end

  describe "favourite winery" do
    let(:user) { FactoryBot.create(:user) }
  
    it "has method for determining one" do
      expect(user).to respond_to(:favourite_winery)
    end

    it "without ratings does not have one" do
      expect(user.favourite_winery).to eq(nil)
    end

    it "is the style of the only rated if only one rating" do
      favourite = FactoryBot.create(:winery, name: 'PrimeWine')
      create_wine_with_rating({ user: user, winery: favourite }, 25)

      expect(user.favourite_winery).to eq(favourite)
    end  
    
    it "is the style of with highest average if several rated" do
      favourite = FactoryBot.create(:winery, name: 'PrimeWine')
      w1 = FactoryBot.create(:winery)
      w2 = FactoryBot.create(:winery)
      create_wines_with_many_ratings({ user: user, winery: w1 }, 10, 20, 15, 7, 9)
      create_wines_with_many_ratings({ user: user, winery: favourite }, 25, 45 )
      create_wines_with_many_ratings({ user: user, winery: w2 }, 50, 10, 8)

      expect(user.favourite_winery).to eq(favourite)
    end 

  end

end
