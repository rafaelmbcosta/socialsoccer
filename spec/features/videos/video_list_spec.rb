require "rails_helper"

RSpec.feature "Listing Videos" do

  before do
    page.driver.header 'Accept-Language', :en
    I18n.locale = :en
    @user = User.create!(email: "user@gmail.com", password: "123456", password_confirmation: "123456")
    @videos = FactoryGirl.create_list(:video, 2)
  end

  scenario "User should be redirected to login if unauthorized" do
    visit videos_url
    expect(page).to have_content(I18n.t('devise.links.sign_in'))
    expect(page).not_to have_content(I18n.t('helpers.titles.list', :model => Video.model_name.human.titleize))
    expect(current_path).to eq(new_user_session_path)
  end

  scenario "User see the list of videos" do
    @videos = FactoryGirl.create_list(:video, 2)
    login_as @user
    visit videos_url
    expect(page).to have_content(I18n.t('content.reports.titles.videos'))
    expect(page).to have_content(I18n.l(@videos[0].date))
    expect(page).to have_content(@videos[0].url)
    expect(page).to have_content(I18n.l(@videos[1].date))
    expect(page).to have_content(@videos[1].url)
  end

  scenario "User click on 'New Video'" do
    login_as @user
    visit videos_url
    click_link I18n.t("helpers.links.new")
    expect(current_path).to eq(new_video_path)
    expect(page).to have_content('New Video')
  end
end
