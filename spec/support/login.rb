
def set_data
  today = Date.today
  user = FactoryGirl.create(:user)
  task = FactoryGirl.create(:task,
                             user_id: user.id,
                             period: today + 1.day
  )

end

def login
  today = Date.today
  user = FactoryGirl.create(:user)
  task = FactoryGirl.create(:task,
                             user_id: user.id,
                             period: today + 1.day
  )
  visit root_path
  fill_in 'session[username]', with: user.username
  fill_in 'session[password]', with: user.password
  click_button 'ログイン'
  visit tasks_path
end