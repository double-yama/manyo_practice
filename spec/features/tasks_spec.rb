require 'rails_helper'
# require_relative '../support/login'

# describe ... type: :featureの代わりにfeature
# beforeの代わりに、background
# itの代わりに、scenario
# letの代わりにgiven

RSpec.feature "Tasks", type: :feature do
    before do
      @today = Date.today
      @user = FactoryGirl.create(:user)
      @task = FactoryGirl.create(:task,
                                 user_id: @user.id,
                                 period: @today + 1.day
      )
      visit root_path
      fill_in 'session_username', with: @user.username
      fill_in 'session_password', with: @user.password
      click_button 'ログイン'
      visit tasks_path
    end

    describe '新規タスク追加' do
      context 'ラベル以外を入力、かつ全て有効値であるならば' do
        before do
          fill_in 'task_name', with: 'テストタスク'
          fill_in 'task_detail', with: 'テスト説明文'
          find('option[value="high"]').select_option
          select @today.year, from: 'task_period_1i'
          select @today.month, from: 'task_period_2i'
          select @today.day, from: 'task_period_3i'
          find('option[value="completed"]').select_option
          click_button '登録'
        end

        #文字数のテストを書くべき

        it 'タスクは登録され、タスク一覧ページへ遷移する' , js: true do

          expect(page).to have_content 'タスク作成に成功しました'
          # これはトースタのテスト
          # そのタスクが登録されたかどうか、正確なURLに飛んだかのテストもいる
          # Modelのタスク数を調べる
          # Pathも
        end
      end

      context 'ラベル以外を入力、かつ名前が空であるならば' do
        before do
          fill_in '名前', with: nil
          fill_in 'task_detail', with: 'テスト説明文'
          find('option[value="high"]').select_option
          select @today.year, from: 'task_period_1i'
          select @today.month, from: 'task_period_2i'
          select @today.day, from: 'task_period_3i'
          find('option[value="completed"]').select_option
          click_button '登録'
        end

        it 'タスクは登録されず、バリデーションエラーが発生する', js: true do
          expect(page).to have_content "Name cannot be blank"
        end
        # OPTIMIZE
        # 高橋氏「capybara.rbにてデフォルトで見えないものを見えるようにしている」
      end

      context 'ラベル以外を入力、かつ説明文が空であるならば' do
        before do
          fill_in 'task_name', with: 'テスト名前'
          fill_in 'task_detail', with: nil
          find('option[value="high"]').select_option
          select @today.year, from: 'task_period_1i'
          select @today.month, from: 'task_period_2i'
          select @today.day, from: 'task_period_3i'
          find('option[value="completed"]').select_option
          click_button '登録'
        end

        it '「Detail cannot be blank」がトースタとして表示される', js: true do
          expect(page).to have_content "Detail cannot be blank"
          # トースタのテストだけになってるけどそれでいい
        end
      end

      context 'ラベル以外を入力、かつ期限が昨日のものであるならば' do
        before do
          fill_in 'task_name', with: @task.name
          fill_in 'task_detail', with: @task.detail
          find('option[value="high"]').select_option
          select @today.year, from: 'task_period_1i'
          select @today.month, from: 'task_period_2i'
          select @today.day - 1, from: 'task_period_3i'
          find('option[value="completed"]').select_option
          click_button '登録'
        end

        it 'タスクは登録されず、バリデーションエラーが発生する', js: true do
          expect(page).to have_content "今日以前の日付を入力してください"
        end
      end
      # 今日のテストもする
      # やらなくていい
      # Modelでやってるなら重複させなくていい
    end

    describe 'タスク削除' do
      before do
        1.upto(4) do
          FactoryGirl.create(:task,
                             user_id: @user.id,
                             period: @today + 1.day
          )
        end
      end

      context '一番上の削除ボタンを押下すると' do
        before do
          visit my_page_tasks_path
          page.all('.btn-danger')[0].click
          # page.all('table tbody tr')[1].first('.btn.btn-danger').click
          page.driver.browser.switch_to.alert.accept
        end

        it '1件のタスクが削除され、4件の削除ボタンが表示される' do
          expect(page.all('a.btn.btn-danger').size).to eq(4)
        end
      end

    end

    describe '検索' do
      before do
        1.upto(4) do
          FactoryGirl.create(:task,
                             user_id: @user.id,
                             period: @today + 1.day
          )
          #　都度変えずにここで
          # アップデートの検証ではない
        end
      end

      context 'タイトル/説明文検索欄に「test」を入力すると' do
        before do
          visit my_page_tasks_path
          Task.first.update(name: 'test')
          fill_in 'q_name', with: 'test'
          click_button '検索'
        end

        it '5件中1件のみ表示される' do
          expect(page.all('.btn.btn-danger').size).to eq(1)
        end
      end

      context 'ステータス検索欄に「未着手」を選択すると' do
        before do
          visit my_page_tasks_path
          Task.last.update(status: 0)
          select '未着手', from: 'q[status]'
          click_button '検索'
        end

        it '5件中1件のみ表示される' do
          expect(page.all('.btn.btn-danger').size).to eq(1)
        end
      end

      context 'ステータス検索欄に「実行中」を選択すると' do
        before do
          visit my_page_tasks_path
          Task.last.update(status: 1)
          select '実行中', from: 'q[status]'
          click_button '検索'
        end

        it '5件中1件のみ表示される' do
          expect(page.all('.btn.btn-danger').size).to eq(1)
        end
      end

      context 'ステータス検索欄に「完了」を選択すると' do
        before do
          visit my_page_tasks_path
          Task.last.update(status: 2)
          select "完了", from: 'q[status]'
          click_button '検索'
        end

        it '5件中1件のみ表示される' do
          expect(page.all('.btn.btn-danger').size).to eq(1)
        end
      end
    end
end
