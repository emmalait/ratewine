require 'rails_helper'

RSpec.describe Wine, type: :model do
  let(:winery) { Winery.create name: "PrimeWine", year: 1990 }
  let(:riesling) { Style.create name: "Riesling" }

  it "is created with valid input" do
    wine = Wine.create name: "testwine", style: riesling, winery: winery
    expect(wine).to be_valid
    expect(Wine.count).to eq(1)
  end

  it "is not saved without name" do
    wine = Wine.create style: riesling, winery: winery

    expect(wine).not_to be_valid
    expect(Wine.count).to eq(0)
  end

  it "is not saved without style" do
    wine = Wine.create name: "testwine", winery: winery

    expect(wine).not_to be_valid
    expect(Wine.count).to eq(0)
  end
end
