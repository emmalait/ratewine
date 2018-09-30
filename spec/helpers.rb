module Helpers

  def sign_in(credentials)
    visit signin_path
    fill_in('username', with:credentials[:username])
    fill_in('password', with:credentials[:password])
    click_button('Log in')
  end

  def create_wine_with_rating(object, score)
    wine = FactoryBot.create(:wine)
    FactoryBot.create(:rating, wine: wine, score: score, user: object[:user])
    wine
  end
      
  def create_wines_with_many_ratings(object, *scores)
    scores.each do |score|
      create_wine_with_rating(object, score)
    end
  end

end