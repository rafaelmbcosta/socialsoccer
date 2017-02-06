require "rails_helper"

RSpec.feature "Listing Players" do

  before do
    @user = User.create!(email: "user@gmail.com", password: "123456", password_confirmation: "123456")
  end

  scenario "User should be redirected to login if unauthorized" do
    visit players_url
    expect(page).to have_content(I18n.t('devise.links.sign_in'))
    expect(page).not_to have_content(I18n.t('helpers.titles.list', :model => Player.model_name.human.titleize))
    expect(current_path).to eq(new_user_session_path)
  end

  scenario "User see the list of players" do
    players = FactoryGirl.create_list(:player, 3)
    login_as @user
    visit players_url
    expect(page).to have_content(I18n.t('helpers.titles.list', :model => Player.model_name.human.titleize))
    expect(page).to have_content(players[0].name)
    expect(page).to have_content(players[1].name)
    expect(page).to have_content(players[2].name)
  end

end
