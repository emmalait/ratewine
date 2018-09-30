require 'rails_helper'

RSpec.describe Wine, type: :model do
  it "has name set correctly" do
    wine = Wine.new name:"testwine"

    expect(wine.name).to eq("testwine")
  end

  it "is saved with name, style and winery" do
    winery = Winery.new name: "test", year: 2000
    wine = Wine.new name: "testwine", style: "teststyle", winery: winery
    wine.save

    expect(wine).to be_valid
    expect(Wine.count).to eq(1)
  end

  it "is not saved without name" do
    winery = Winery.new name: "test", year: 2000
    wine = Wine.new winery: winery
    wine.save

    expect(wine).not_to be_valid
    expect(Wine.count).to eq(0)
  end

  it "is not saved without style" do
    winery = Winery.new name: "test", year: 2000
    wine = Wine.new name:"testwine", winery: winery
    wine.save

    expect(wine).not_to be_valid
    expect(Wine.count).to eq(0)
  end
end

def create_wine_with_rating(object, score)
  wine = FactoryBot.create(:wine)
  FactoryBot.create(:rating, wine: wine, score: score, user: object[:user])
  wine
end
