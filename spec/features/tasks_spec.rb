require 'rails_helper'

RSpec.feature "Tasks", type: :feature do
  # pending "add some scenarios (or delete) #{__FILE__}"
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
      # session_helperにてsessionにログイン情報を入れる
      # cookie[:user_remember_token]とかを利用する
      # before (login_as user)
      # helper.rbに
      # RSpec.cinfigure do |config|
      # config.include SessinHelper
      # End
      # とかしてる
    end

    describe 'ログイン画面' do
      context '新規タスク作成リンクを押下すると' do
        scenario 'タスク一覧画面に遷移する' do
          expect(page).to have_content '期限切れタスク一覧'
        end
      end
    end

    describe 'タスク画面から新規タスク追加' do
      context 'ラベル以外を入力、かつ全て有効値であるならば' do
        background do
          visit tasks_path
          fill_in 'task_name', with: @task.name
          fill_in 'task_detail', with: @task.detail
          find('option[value="high"]').select_option
          select @today.year, from: 'task_period_1i'
          select @today.month, from: 'task_period_2i'
          select @today.day, from: 'task_period_3i'
          find('option[value="completed"]').select_option
          click_button '登録'
          sleep 3
        end

        scenario 'タスクは登録され、タスク一覧ページへ遷移する' , js: false do
          expect(page).to have_content 'タスク作成に成功しました'
          # expect(page).to have_content @task.detail
          # expect(page).to have_content @task.period
          # expect(page).to have_content '期限切れタスク一覧'
        end
      end

      context 'ラベル以外を入力、かつ名前が空であるならば' do
        background do
          visit tasks_path
          click_link '新規タスク追加'
          fill_in '名前', with: nil
          fill_in 'task_detail', with: @task.detail
          find('option[value="high"]').select_option
          select @today.year, from: 'task_period_1i'
          select @today.month, from: 'task_period_2i'
          select @today.day, from: 'task_period_3i'
          find('option[value="completed"]').select_option
          click_button '登録'
        end

        scenario 'タスクは登録されず、バリデーションエラーが発生する', js: false do
          expect(page).to have_content "Name cannot be blank"
        end
      end

      context 'ラベル以外を入力、かつ説明文が空であるならば' do
        background do
          visit tasks_path
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
          expect(page).to have_content "Detail cannot be blank"
        end
      end

      context 'ラベル以外を入力、かつ期限が昨日のものであるならば' do
        background do
          visit tasks_path
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
          expect(page).to have_content "有効な日付を入力してください"
        end
      end
    end

    feature 'search' do
      background do
        1.upto(4) do
          FactoryGirl.create(:task,
                             user_id: @user.id,
                             period: @today + 1.day
          )
        end
        visit tasks_path
      end

      context 'タイトル/説明文検索欄に「test」を入力すると' do
        background do
          visit mypage_tasks_path
          Task.first.update(name: 'test')
          fill_in 'q_name', with: 'test'
          click_button '検索'
        end

        scenario '1件分の削除ボタンが表示される' do
          expect(page.all('a.btn.btn-danger').size).to eq(1)
        end

        scenario '5件中1件のみ表示される' do
          expect(page.all('.btn.btn-danger').size).to eq(1)
        end
      end

      context 'ステータス検索欄に「未着手」を選択すると' do
        background do
          visit mypage_tasks_path
          Task.last.update(status: 'yet_start')
          select '未着手', from: 'q[status]'
          click_button '検索'
        end

        scenario '5件中1件のみ表示される' do
          expect(page.all('.btn.btn-primary').size).to eq(1)
        end
      end

      context 'ステータス検索欄に「実行中」を選択すると' do
        background do
          visit mypage_tasks_path
          Task.last.update(status: 1)
          select '実行中', from: 'q[status]'
          click_button '検索'
        end

        scenario '5件中1件のみ表示される' do
          expect(page.all('.btn.btn-primary').size).to eq(1)
        end
      end

      context 'ステータス検索欄に「完了」を選択すると' do
        background do
          visit mypage_tasks_path
          Task.last.update(status: 2)
          select "完了", from: 'q[status]'
          click_button '検索'
        end

        scenario '5件中1件のみ表示される' do
          expect(page.all('.btn.btn-primary').size).to eq(1)
        end
      end
    end
end
