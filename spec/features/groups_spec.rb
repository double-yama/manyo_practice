require 'rails_helper'
require 'capybara'

# describe ... type: :featureの代わりにfeature
# beforeの代わりに、background
# itの代わりに、scenario
# letの代わりにgiven

RSpec.feature "Groups", type: :feature do
  given(:uri) { URI.parse(current_url) }

  background do
    @today = Date.today
    @user = FactoryGirl.create(:user)
    @task = FactoryGirl.create(:task,
                               user_id: @user.id,
                               period: @today + 1.day
    )
    visit root_path
    fill_in 'session[username]', with: @user.username
    fill_in 'session[password]', with: @user.password
    click_button 'ログイン'
    visit tasks_path
  end
  
  scenario 'ログインされているか確かめる' do
    expect("#{uri.path}").to eq(tasks_path)
  end


  feature 'グループ作成', js: true do

    context '新規グループ作成ボタンを押下すると' do
      background do
        visit new_group_path
        fill_in 'group[name]', with: 'グループ名'
        fill_in 'group[description]', with: 'グループ説明'
        choose 'group_user_ids_1'
        click '新規作成'
      end

      scenario '「グループを作成しました」がトースタとして表示される', js: true do
        expect(page).to have_content "グループを作成しました"
      end

      scenario 'グループが一個追加される' do
        expect(page.all('a.btn.btn-primary').size).to eq(1)
      end
    end
  end

    context 'グループ名を空欄にして、グループ作成ボタンを押下すると' do
      background do
        fill_in 'task_name', with: 'テスト名前'
        fill_in 'task_detail', with: nil
        find('option[value="high"]').select_option
        select @today.year, from: 'task_period_1i'
        select @today.month, from: 'task_period_2i'
        select @today.day, from: 'task_period_3i'
        find('option[value="completed"]').select_option
        click_button '登録'
      end

      scenario '「Detail cannot be blank」がトースタとして表示される', js: true do
        expect(page).to have_content "Detail cannot be blank"
      end
    end

    context 'グループ一覧画面にて、削除ボタンを押下すると' do
      background do
        visit mypage_tasks_path
        page.all('.btn-danger')[0].click
        # page.all('table tbody tr')[1].first('.btn.btn-danger').click
        page.driver.browser.switch_to.alert.accept
      end

      scenario '1件のタスクが削除され、4件の削除ボタンが表示される' do
        expect(page.all('a.btn.btn-danger').size).to eq(4)
      end
    end

end
