require 'rails_helper'

describe "Winelist page" do
  before :all do
    Capybara.register_driver :selenium do |app|
      capabilities = Selenium::WebDriver::Remote::Capabilities.chrome(
        chromeOptions: { args: ['headless', 'disable-gpu']  }
      )
  
      Capybara::Selenium::Driver.new app,
        browser: :chrome,
        desired_capabilities: capabilities      
    end
    WebMock.disable_net_connect!(allow_localhost: true) 
  end

  before :each do
    @winery1 = FactoryBot.create(:winery, name:"PrimeWine")
    @winery2 = FactoryBot.create(:winery, name:"Casa Rojo")
    @winery3 = FactoryBot.create(:winery, name:"Barefoot")
    @style1 = Style.create name:"Riesling"
    @style2 = Style.create name:"Merlot"
    @style3 = Style.create name:"Chardonnay"
    @wine1 = FactoryBot.create(:wine, name:"Kungfu Girl", winery: @winery1, style:@style1)
    @wine2 = FactoryBot.create(:wine, name:"Macho Man", winery:@winery2, style:@style2)
    @wine3 = FactoryBot.create(:wine, name:"Eve", winery:@winery3, style:@style3)
  end

  it "shows one known wine", js:true do
    visit winelist_path
    find('table').find('tr:nth-child(2)')
    save_and_open_page
    expect(page).to have_content "Kungfu Girl"
  end

  it "sorts wines by name", js:true do
    visit winelist_path
    click_link "Name"
    find('table').find('tr:nth-child(2)')
    save_and_open_page
    expect(find('table').find('tr:nth-child(2)')).to have_content "Eve"
    expect(find('table').find('tr:nth-child(3)')).to have_content "Kungfu Girl"
    expect(find('table').find('tr:nth-child(4)')).to have_content "Macho Man"
  end

  it "sorts wines by style", js:true do
    visit winelist_path
    click_link "Style"
    find('table').find('tr:nth-child(2)')
    save_and_open_page
    expect(find('table').find('tr:nth-child(2)')).to have_content "Chardonnay"
    expect(find('table').find('tr:nth-child(3)')).to have_content "Merlot"
    expect(find('table').find('tr:nth-child(4)')).to have_content "Riesling"
  end

  it "sorts wines by winery", js:true do
    visit winelist_path
    click_link "Winery"
    find('table').find('tr:nth-child(2)')
    save_and_open_page
    expect(find('table').find('tr:nth-child(2)')).to have_content "Barefoot"
    expect(find('table').find('tr:nth-child(3)')).to have_content "Casa Rojo"
    expect(find('table').find('tr:nth-child(4)')).to have_content "PrimeWine"
  end
end