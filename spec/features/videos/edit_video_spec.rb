require "rails_helper"

RSpec.feature "Editing a Video" do

  before do
    page.driver.header 'Accept-Language', :en
    I18n.locale = :en
    @user = User.create!(email: "user@gmail.com", password: "123456", password_confirmation: "123456")
    @video = FactoryBot.create(:video)
  end

  scenario "User should be redirected to login if unauthorized" do
    visit edit_video_url(@video.id)
    expect(page).to have_content(I18n.t('devise.links.sign_in'))
    expect(page).not_to have_content(I18n.t('helpers.titles.list', :model => Video.model_name.human.titleize))
    expect(current_path).to eq(new_user_session_path)
  end

  scenario "User edits a video" do
    login_as @user
    visit videos_url
    click_link @video.id
    click_link 'Edit'
    expect(page.current_path).to eq(edit_video_path(@video.id))
    new_url = Faker::Internet.url
    new_description = Faker::Lorem.sentence
    fill_in 'video_url', with: new_url
    fill_in 'video_description', with: new_description
    click_button 'Update Video'
    expect(page).to have_content("Video was successfully updated.")
    expect(page).to have_content(new_url)
    expect(page).to have_content(new_description)
  end
end
