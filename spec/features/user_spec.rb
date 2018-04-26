require 'rails_helper_stash'

# itの代わりにscenario
# describe ... type: :featureの代わりにfeature
# beforeの代わりに、background
# letの代わりにgiven

feature 'feature' do

  background do
    user = FactoryGirl.create(:user)
  end

  scenario "scenario" do

    visit login_path
    find('#login_view').fill_in 'username', with: user.name
    find('#login_view').fill_in 'password', with: user.password
    click_button 'Log in'
    tasks_path

  end
end