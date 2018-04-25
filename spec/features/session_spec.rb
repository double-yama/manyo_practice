require 'rails_helper'

# itの代わりにscenario
# describe ... type: :featureの代わりにfeature
# beforeの代わりに、background
# letの代わりにgiven
RSpec.feature "session", type: :feature do

feature 'feature' do

  background do
    user = FactoryGirl.create(:user)
    visit login_path
    find('#login_view').fill_in 'username', with: user.username
    find('#login_view').fill_in 'password', with: user.password
    click_button 'Log in'
    tasks_path
  end

  scenario "scenario"  , js: true do
    expect(page).to have_content user.username
  end
end
end
