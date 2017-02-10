require "rails_helper"

RSpec.feature "Creating Video" do

  before do
    page.driver.header 'Accept-Language', :en
    I18n.locale = :en
    @user = User.create!(email: "user@gmail.com", password: "123456", password_confirmation: "123456")
  end

  scenario "User should be redirected to login if unauthorized" do
    visit new_video_url
    expect(page).to have_content(I18n.t('devise.links.sign_in'))
    expect(page).not_to have_content(I18n.t('helpers.titles.list', :model => Video.model_name.human.titleize))
    expect(current_path).to eq(new_user_session_path)
  end

  scenario "User creates video" do
    video = FactoryGirl.build(:video)
    login_as @user
    visit new_video_url
    expect(page).to have_content('New Video')
    fill_in 'video_url', with: video.url
    fill_in 'video_description', with: video.description
    select video.date.day, from: 'video_date_3i'
    select video.date.strftime("%B"), from: 'video_date_2i'
    select video.date.year, from: 'video_date_1i'
    click_button 'Create Video'
    expect(page).to have_content("Video was successfully created.")
  end

  scenario "User fails to create a video" do
    video = FactoryGirl.build(:video)
    login_as @user
    visit new_video_url
    expect(page).to have_content('New Video')
    fill_in 'video_url', with: nil
    fill_in 'video_description', with: nil
    click_button 'Create Video'
    expect(page).to have_content("Description can't be blank")
    expect(page).to have_content("Url can't be blank")
    expect(page.current_path).to eq(videos_path)
  end
end
