require 'rails_helper'

include Helpers

describe "User" do
    before :each do
        FactoryBot.create :user
    end

    describe "who has signed up" do
        it "can sign in with right credentials" do
            sign_in(username: "Pekka", password: "Foobar1")

            expect(page).to have_content 'Welcome back!'
            expect(page).to have_content 'Pekka'
        end

        it "is redirected back to signin form if wrong credentials given" do
            sign_in(username: "Pekka", password: "wrong")
    
            expect(current_path).to eq(signin_path)
            expect(page).to have_content 'Username and/or password mismatch'
        end

    end

    it "when signed up with good credentials, is added to the system" do
        visit signup_path
        fill_in('user_username', with:'Brian')
        fill_in('user_password', with:'Secret55')
        fill_in('user_password_confirmation', with:'Secret55')
    
        expect{
            click_button('Create User')
        }.to change{User.count}.by(1)
    end

end

describe "Users page" do
    let!(:winery) { FactoryBot.create :winery, name: "PrimeWine" }
    let!(:wine1) { FactoryBot.create :wine, name: "Prohibition Zinfandel", winery: winery }
    let!(:wine2) { FactoryBot.create :wine, name: "Prohibition Cabernet Sauvignon", winery: winery }
    let!(:user1) { FactoryBot.create :user }
    let!(:user2) { FactoryBot.create :user, username: "Laura" }

    describe "when user has ratings" do
        let!(:rating1) { FactoryBot.create(:rating, wine: wine1, score: 15, user: user1) }
        let!(:rating2) { FactoryBot.create(:rating, wine: wine2, score: 25, user: user1) }
        let!(:rating3) { FactoryBot.create(:rating, wine: wine2, score: 25, user: user2) }
        
        it "the ratings are shown" do
            visit user_path(user1)
            expect(page).to have_content "has made #{user1.ratings.count} ratings"
            user1.ratings.each do |rating|
                expect(page).to have_content rating
            end
        end

        it "a rating is deleted from the database when destroyed" do
            sign_in(username: "Pekka", password: "Foobar1")
            visit user_path(user1)

            find("a[href='#{ratings_path}/#{rating1.id}']").click

            expect(page).to have_content "has made #{user1.ratings.count} rating"
            user1.ratings.each do |rating|
                expect(page).to have_content rating
            end
            expect(user1.ratings.count).to eq(1)
        end
    end


    
end