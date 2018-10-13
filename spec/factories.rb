FactoryBot.define do
    factory :user do
      username { "Pekka" }
      password { "Foobar1" }
      password_confirmation { "Foobar1" }
    end

    factory :winery do
        name { "anonymous" }
        year { 1990 }
    end

    factory :style do
        name { "Riesling" }
        description { "" }
    end

    factory :wine do
        name { "anonymous" }
        style
        winery
    end

    factory :rating do
        score { 10 }
        wine
        user
    end
    
  end