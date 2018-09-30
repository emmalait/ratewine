require 'rails_helper'

describe "Wineries page" do
    it "should not have any before been created" do
        visit wineries_path
        expect(page).to have_content 'Wineries'
        expect(page).to have_content 'Number of wineries: 0'
    end
    
    describe "when wineries exist" do
    
        before :each do
            @wineries = ["PrimeWine", "Barefoot", "Casa Rojo"]
            year = 1896
            @wineries.each do |winery_name|
                FactoryBot.create(:winery, name: winery_name, year: year += 1)
            end

            visit wineries_path
        end

        it "lists the existing wineries and their total count" do
            expect(page).to have_content "Number of wineries: #{@wineries.count}"
            @wineries.each do |winery_name|
                expect(page).to have_content winery_name
            end
        end

        it "allows user to navigate to page of a Winery" do  
            click_link "PrimeWine"
    
            expect(page).to have_content "PrimeWine"
            expect(page).to have_content "Established in 1897"
        end
    end
end