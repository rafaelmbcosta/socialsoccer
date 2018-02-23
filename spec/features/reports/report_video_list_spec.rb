require "rails_helper"

RSpec.feature "Listing Videos" do

  before do
    page.driver.header 'Accept-Language', :en
    I18n.locale = :en
    @videos = FactoryBot.create_list(:video, 2)
  end

  scenario "User select 'Videos' from the main menu" do
    visit reports_videos_url
    expect(page).to have_content(I18n.t('content.reports.titles.videos'))
    expect(page).to have_content(@videos.first.description)
    expect(page).to have_content(@videos.first.date)
    expect(page).to have_css("a.video_#{@videos.first.id}")
    expect(page).to have_content(@videos.second.description)
    expect(page).to have_content(@videos.second.date)
    expect(page).to have_css("a.video_#{@videos.second.id}")
  end

  scenario "A user select a video and it shows in a modal" do
    visit reports_videos_url
    expect(page).to have_selector('#video_show', visible: false)
    find(".video_#{@videos.first.id}").click
    expect(page).to have_selector('#video_show', visible: true)
  end

end
