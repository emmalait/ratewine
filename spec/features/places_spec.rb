require 'rails_helper'

describe "Places" do
  it "if one is returned by the API, it is shown on the page" do
    allow(BeermappingApi).to receive(:places_in).with("kumpula").and_return(
      [ Place.new( name:"Oljenkorsi", id: 1 ) ]
    )

    allow(ApixuApi).to receive(:weather_in).with("kumpula").and_return(
      {"last_updated_epoch"=>1539464421,
        "last_updated"=>"2018-10-14 00:00",
        "temp_c"=>"12.0",
        "temp_f"=>53.6,
        "is_day"=>0,
        "condition"=>{"text"=>"Clear", "icon"=>"//cdn.apixu.com/weather/64x64/night/113.png", "code"=>1000},
        "wind_mph"=>10.5,
        "wind_kph"=>16.9,
        "wind_degree"=>200,
        "wind_dir"=>"SSW",
        "pressure_mb"=>1023.0,
        "pressure_in"=>30.7,
        "precip_mm"=>0.0,
        "precip_in"=>0.0,
        "humidity"=>94,
        "cloud"=>0,
        "feelslike_c"=>10.2,
        "feelslike_f"=>50.3,
        "vis_km"=>7.0,
        "vis_miles"=>4.0}
    )
    
    visit places_path
    fill_in('city', with: 'kumpula')
    click_button "Search"

    expect(page).to have_content "Oljenkorsi"
  end

  it "if more than one are returned by the API, they are shown on the page" do
    allow(BeermappingApi).to receive(:places_in).with("kumpula").and_return(
      [ Place.new( name:"Oljenkorsi", id: 1 ), Place.new( name:"Olotila", id: 2 ) ]
    )

    allow(ApixuApi).to receive(:weather_in).with("kumpula").and_return(
      {"last_updated_epoch"=>1539464421,
        "last_updated"=>"2018-10-14 00:00",
        "temp_c"=>"12.0",
        "temp_f"=>53.6,
        "is_day"=>0,
        "condition"=>{"text"=>"Clear", "icon"=>"//cdn.apixu.com/weather/64x64/night/113.png", "code"=>1000},
        "wind_mph"=>10.5,
        "wind_kph"=>16.9,
        "wind_degree"=>200,
        "wind_dir"=>"SSW",
        "pressure_mb"=>1023.0,
        "pressure_in"=>30.7,
        "precip_mm"=>0.0,
        "precip_in"=>0.0,
        "humidity"=>94,
        "cloud"=>0,
        "feelslike_c"=>10.2,
        "feelslike_f"=>50.3,
        "vis_km"=>7.0,
        "vis_miles"=>4.0}
    )

    visit places_path
    fill_in('city', with: 'kumpula')
    click_button "Search"

    expect(page).to have_content "Oljenkorsi"
    expect(page).to have_content "Olotila" 
  end

  it "if no places are found, page displays notification" do
    allow(BeermappingApi).to receive(:places_in).with("123").and_return([])
  
    visit places_path
    fill_in('city', with: '123')
    click_button "Search"

    expect(page).to have_content "No locations in 123"
  end
end