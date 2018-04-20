require 'rails_helper'

feature 'feature' do

  scenario "scenario" do

    user = create(:user)

    visit root_path

    click_on 'Log in'
    find('#login_view').fill_in 'Email', with: user.email
    find('#login_view').fill_in 'Password', with: user.password
    click_button 'Log in'

    visit root_path

  end

end