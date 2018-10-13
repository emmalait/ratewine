require 'rails_helper'

include Helpers

describe "Wines page" do
    before :each do
        FactoryBot.create(:winery)
        FactoryBot.create(:user)
        FactoryBot.create(:style)
        sign_in(username: "Pekka", password: "Foobar1")    
    end

    it "can be used to add wine with a valid name" do
        visit new_wine_path

        fill_in('wine[name]', with:'Test')

        expect{
            click_button "Create Wine"
        }.to change{Wine.count}.from(0).to(1)
    end

    it "can not be used to add wine without a valid name" do
        visit new_wine_path

        expect{
            click_button "Create Wine"
        }.to change{Wine.count}.by(0)

        expect(page).to have_content "Name can't be blank"
    end 
end