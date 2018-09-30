require 'rails_helper'

include Helpers

describe "Rating" do
    let!(:winery) { FactoryBot.create :winery, name: "PrimeWine" }
    let!(:wine1) { FactoryBot.create :wine, name: "Prohibition Zinfandel", winery: winery }
    let!(:wine2) { FactoryBot.create :wine, name: "Prohibition Cabernet Sauvignon", winery: winery }
    let!(:user) { FactoryBot.create :user }

    before :each do
        sign_in(username: "Pekka", password: "Foobar1")
    end

    it "when given, is registered to the wine and user who is signed in" do
        visit new_rating_path
        select('Prohibition Zinfandel', from:'rating[wine_id]')
        fill_in('rating[score]', with:'15')

        expect{
            click_button "Create Rating"
        }.to change{Rating.count}.from(0).to(1)

        expect(user.ratings.count).to eq(1)
        expect(wine1.ratings.count).to eq(1)
        expect(wine1.average_rating).to eq(15.0)
    end

    it "should not have any before been created" do
        visit ratings_path
        expect(page).to have_content 'Ratings'
        expect(page).to have_content 'Number of ratings: 0'
    end

    describe "when ratings exist" do

        before :each do
            FactoryBot.create(:rating, wine: wine1, score: 15, user: user)
            FactoryBot.create(:rating, wine: wine2, score: 25, user: user)
            
            visit ratings_path
        end

        it "lists the existing ratings and their total count" do
            expect(page).to have_content "Number of ratings: #{Rating.count}"
            Rating.all.each do |rating_wine|
                expect(page).to have_content rating_wine
            end
        end
    end
end