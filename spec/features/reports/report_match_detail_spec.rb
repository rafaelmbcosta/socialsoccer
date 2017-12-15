require "rails_helper"

RSpec.feature "Match detail" do

  before do
    page.driver.header 'Accept-Language', :en
    I18n.locale = :en
    @season = FactoryGirl.create(:season)
    @match1 = FactoryGirl.create(:match, season: @season )
    @match2 = FactoryGirl.create(:match, season: @season )
    @presences = FactoryGirl.create_list(:presence, 4,
      { player: FactoryGirl.create(:player), match: @match1 })
  end

  scenario "User see the match detail" do
    visit reports_match_detail_path(id: @match1.id)
    expect(page).to have_content(@match1.presences.first.player.name)
    expect(page).to have_content(@match1.presences.second.player.name)
  end

  scenario "Match detail doesnt include a docket" do
    visit reports_match_detail_path(id: @match1.id)
    expect(page).to have_content(I18n.t('content.reports.docket_not_found'))
  end
end
