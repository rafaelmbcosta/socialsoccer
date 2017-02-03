require "rails_helper"

RSpec.feature "Listing Matches" do

  before do
    page.driver.header 'Accept-Language', :en
    I18n.locale = :en
    @season = FactoryGirl.create(:season)
    @match1 = FactoryGirl.create(:match, season: @season )
    @match2 = FactoryGirl.create(:match, season: @season )
  end

  scenario "User select 'Matches' from the main menu" do
    visit("/")
    click_link I18n.t('content.menu.matches')
    expect(page.current_path).to eq(reports_matches_path)
    expect(page).to have_content(I18n.t('content.reports.titles.matches'))
  end

  scenario "A user lists all matches" do
    visit reports_matches_url

    expect(page).to have_content(@match1.id)
    expect(page).to have_content(I18n.l(@match1.date, format: :default))
    expect(page).to have_content(@match2.id)
    expect(page).to have_content(I18n.l(@match2.date, format: :default))
  end
end
