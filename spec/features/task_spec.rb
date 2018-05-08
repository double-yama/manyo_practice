require 'rails_helper'

RSpec.feature 'task', type: :feature do

  background do
    @user = FactoryGirl.create(:user)
    @task = FactoryGirl.create(:task,
                               user_id: @user.id
    )
    @today = Date.today
    visit root_path
    fill_in 'session[username]', with: @user.username
    fill_in 'session[password]', with: @user.password
    click_button 'ログイン'
    visit tasks_path
  end

  describe 'ログイン画面' do
    context '新規タスク作成リンクを押下すると' do
      scenario 'タスク一覧画面に遷移する' , js: false do
        expect(page).to have_content 'タスク一覧'
      end
    end
  end

  describe 'タスク画面から新規タスク追加' do
    context 'ラベル以外を入力、かつ全て有効値であるならば' do
      background do
        visit tasks_path
        click_link '新規タスク追加'
        fill_in 'task_name', with: @task.name
        fill_in 'task_detail', with: @task.detail
        find('option[value="high"]').select_option
        select @today.year, from: 'task_period_1i'
        select @today.month, from: 'task_period_2i'
        select @today.day, from: 'task_period_3i'
        find('option[value="completed"]').select_option
        click_button '登録'
      end

      scenario 'タスクは登録され、タスク一覧ページへ遷移する' , js: false do
        expect(page).to have_content @task.name
        expect(page).to have_content @task.detail
        expect(page).to have_content @task.period
        expect(page).to have_content '全タスク一覧'
        # expect {
        #   visit new_task_path '新規作成'
        #   fill_in 'タスク名', with: 'テストタスク'
        #   fill_in '説明文', with: 'this is a test'
        #   fill_in '期日', with: '2018-04-04'
        # click_button '登録'
        # }.to change(Task, :count).by(1)
      end
    end

    context 'ラベル以外を入力、かつ名前が空であるならば' do
      background do
        visit tasks_path
        click_link '新規タスク追加'
        fill_in 'task_name', with: nil
        fill_in 'task_detail', with: @task.detail
        find('option[value="high"]').select_option
        select @today.year, from: 'task_period_1i'
        select @today.month, from: 'task_period_2i'
        select @today.day, from: 'task_period_3i'
        find('option[value="completed"]').select_option
        click_button '登録'
      end

      scenario 'タスクは登録されず、バリデーションエラーが発生する', js: false do
        expect(page.find('h1').text).to eq '新規タスク追加'
        # expect(page).to have_content @task.detail
        # expect(page).to have_content @task.period
        # expect(page).to have_content '全タスク一覧'
      end
    end

    context 'ラベル以外を入力、かつ説明文が空であるならば' do
      background do
        visit tasks_path
        click_link '新規タスク追加'
        fill_in 'task_name', with: @task.name
        fill_in 'task_detail', with: nil
        find('option[value="high"]').select_option
        select @today.year, from: 'task_period_1i'
        select @today.month, from: 'task_period_2i'
        select @today.day, from: 'task_period_3i'
        find('option[value="completed"]').select_option
        click_button '登録'
      end

      scenario 'タスクは登録されず、バリデーションエラーが発生する', js: false do
        expect(page.find('h1').text).to eq '新規タスク追加'
      end
    end

    context 'ラベル以外を入力、かつ期限が昨日のものであるならば' do
      background do
        visit tasks_path
        click_link '新規タスク追加'
        fill_in 'task_name', with: @task.name
        fill_in 'task_detail', with: @task.detail
        find('option[value="high"]').select_option
        select @today.year, from: 'task_period_1i'
        select @today.month, from: 'task_period_2i'
        select @today.day - 1, from: 'task_period_3i'
        find('option[value="completed"]').select_option
        click_button '登録'
      end

      scenario 'タスクは登録されず、バリデーションエラーが発生する', js: false do
        expect(page.find('h1').text).to eq '新規タスク追加'
      end
    end
  end

  feature 'search' do
    background do
      1.upto(4) do
        FactoryGirl.create(:task,
        user_id: @user.id
        )
      end
      visit tasks_path
    end

    context 'タイトル/説明文検索欄に「test」を入力すると' do
      background do
        visit current_path
        Task.first.update(name: 'test')
        fill_in 'q_name', with: 'test'
        click_button 'Search'
      end

      scenario '5件分の削除ボタンが表示される' do
        # expect(page).to have_link '削除'
        expect(page.find('a.btn.btn-mini.btn-info').size).to eq(5)
      end

      scenario '5件中1件のみ表示される' do
        p Task.all
        expect(page).to have_content '削除'
        # expect(page.all('a.btn.btn-mini.btn-info').size).to eq(1)
        expect(page).to have_link '削除'
      end
    end

    context 'ステータス検索欄に「yet_start」を選択すると' do
      background do
        Task.last.update(status: 'yet_start')
        select 'yet_start', from: 'q_status'
        click_button 'Search'
      end

      scenario '5件中1件のみ表示される' do
        expect(page.all('.btn.btn-mini.btn-info').size).to eq(1)
      end
    end

    context 'ステータス検索欄に「doing」を選択すると' do
      background do
        Task.last.update(status: 'doing')
        select 'doing', from: 'q_status'
        click_button 'Search'
      end

      scenario '5件中1件のみ表示される' do
        expect(page.all('.btn.btn-mini.btn-info').size).to eq(1)
      end
    end

    context 'ステータス検索欄に「completed」を選択すると' do
      background do
        Task.last.update(status: "completed")
        select "completed", from: 'q_status'
        click_button 'Search'
      end

      scenario '5件中1件のみ表示される' do
        expect(page.all('.btn.btn-mini.btn-info').size).to eq(1)
      end
    end
  end
end