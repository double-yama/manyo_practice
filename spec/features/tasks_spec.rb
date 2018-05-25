require 'rails_helper'
require_relative '../support/login'

# describe ... type: :featureの代わりにfeature
# beforeの代わりに、background
# itの代わりに、scenario
# letの代わりにgiven

RSpec.feature "Tasks", type: :feature do
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

    # support/login.rbにまとめる

    feature '新規タスク追加' do
      context 'ラベル以外を入力、かつ全て有効値であるならば' do
        background do
          login
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

        scenario 'タスクは登録され、タスク一覧ページへ遷移する' , js: true do

          expect(page).to have_content 'タスク作成に成功しました'
          # これはトースタのテスト
          # そのタスクが登録されたかどうか、正確なURLに飛んだかのテストもいる
          # Modelのタスク数を調べる
          # Pathも
        end
      end

      context 'ラベル以外を入力、かつ名前が空であるならば' do
        background do
          fill_in '名前', with: nil
          fill_in 'task_detail', with: 'テスト説明文'
          find('option[value="high"]').select_option
          select @today.year, from: 'task_period_1i'
          select @today.month, from: 'task_period_2i'
          select @today.day, from: 'task_period_3i'
          find('option[value="completed"]').select_option
          click_button '登録'
        end

        scenario 'タスクは登録されず、バリデーションエラーが発生する', js: true do
          expect(page).to have_content "Name cannot be blank"
        end
        # OPTIMIZE
        # 高橋氏「capybara.rbにてデフォルトで見えないものを見えるようにしている」
      end

      context 'ラベル以外を入力、かつ説明文が空であるならば' do
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
          # トースタのテストだけになってるけどそれでいい
        end
      end

      context 'ラベル以外を入力、かつ期限が昨日のものであるならば' do
        background do
          fill_in 'task_name', with: @task.name
          fill_in 'task_detail', with: @task.detail
          find('option[value="high"]').select_option
          select @today.year, from: 'task_period_1i'
          select @today.month, from: 'task_period_2i'
          select @today.day - 1, from: 'task_period_3i'
          find('option[value="completed"]').select_option
          click_button '登録'
        end

        scenario 'タスクは登録されず、バリデーションエラーが発生する', js: true do
          expect(page).to have_content "今日以前の日付を入力してください"
        end
      end
      # 今日のテストもする
      # やらなくていい
      # Modelでやってるなら重複させなくていい
    end

    feature 'タスク削除' do
      background do
        1.upto(4) do
          FactoryGirl.create(:task,
                             user_id: @user.id,
                             period: @today + 1.day
          )
        end
      end

      context '一番上の削除ボタンを押下すると' do
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

    # feature '完了化' , js: true do
    #   background do
    #     1.upto(4) do
    #       FactoryGirl.create(:task,
    #                          user_id: @user.id,
    #                          period: @today + 1.day
    #       )
    #     end
    #     visit mypage_tasks_path
    #     page.save_screenshot '~/Desktop/test3a.png'
    #     page.all('table tbody tr')[1].all('a')[0].click
    #     # click_link #{@task.name} + 1.to_s
    #   end
    #   scenario '個別のタスク画面に遷移する' do
    #     expect(page).to have_content '詳細'
    #   end
    # end

    feature '検索' do
      background do
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
