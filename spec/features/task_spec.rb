require 'rails_helper'

# itの代わりにscenario
# describe ... type: :featureの代わりにfeature
# beforeの代わりに、background
# letの代わりにgiven

RSpec.feature "Tasks", type: :feature do
  feature '/tasks' do

  end

  background do
    @user = FactoryGirl.create(:user)
    @today = Date.today

    # visit login_path
    # fill_in 'username', with: 'takahashi'
    # fill_in 'password', with: 'keishi'
    # click_on 'ログイン'
    #
    # visit '/'
    login_as(@user, :scope => :user)
  end

  feature '/tasks/new' do
    context '全項目に適切な値を入力すると' do
      before do
        visit tasks_path
        click_link "新規タスク追加"
        fill_in "name", with: 'test_name'
        fill_in "detail", with: 'test_detail'
        fill_in "period", with: @today
        # fill_in "priority", with: user.priority
        # fill_in "status", with: user.status
        # fill_in "label_text", with: user.label_text
        click_button "登録"
      end

      scenario '登録に成功する' do

      end
    end

  end

end