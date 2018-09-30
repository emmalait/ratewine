require 'rails_helper'

describe "Wines page" do
    let!(:winery) { FactoryBot.create :winery, name: "PrimeWine" }
    let!(:user) { FactoryBot.create :user }

    it "can be used to add wine with a valid name" do
        sign_in(username: "Pekka", password: "Foobar1")
        visit wines_path
        click_link "New wine"

        fill_in('wine[name]', with:'Test')
        select('Riesling', from:'wine[style]')
        select('PrimeWine', from:'wine[winery_id]')

        expect{
            click_button "Create Wine"
        }.to change{Wine.count}.from(0).to(1)
    end

    it "can not be used to add wine without a valid name" do
        sign_in(username: "Pekka", password: "Foobar1")
        visit wines_path
        click_link "New wine"

        fill_in('wine[name]', with:'')
        select('Riesling', from:'wine[style]')
        select('PrimeWine', from:'wine[winery_id]')

        click_button "Create Wine"
        
        expect(Wine.count).to eq(0)
        expect(page).to have_content "Name can't be blank"
    end
    
end