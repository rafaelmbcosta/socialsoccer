require "rails_helper"

RSpec.feature "Deleting a Video" do

  before do
    page.driver.header 'Accept-Language', :en
    I18n.locale = :en
    @user = User.create!(email: "user@gmail.com", password: "123456", password_confirmation: "123456")
    @video = FactoryGirl.create(:video)
  end

  scenario "User should be redirected to login if unauthorized" do
    visit video_url(@video.id)
    expect(page).to have_content(I18n.t('devise.links.sign_in'))
    expect(page).not_to have_content(I18n.t('helpers.titles.list', :model => Video.model_name.human.titleize))
    expect(current_path).to eq(new_user_session_path)
  end

  scenario "User deletes a video" do
    login_as @user
    visit videos_url
    click_link @video.id
    click_link 'Delete'
    expect(page).to have_content("Video was successfully destroyed.")
  end
end
