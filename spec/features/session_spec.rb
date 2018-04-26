require 'rails_helper'

# feature specをタスク機能に対して書きましょう
# 並び替えがうまく行っていることをfeature specで書いてみましょう
# 検索に対してmodel specを追加してみよう（feature specも拡充しておきましょう）
# feature specを拡充しましょう(優先順位を設定)

# itの代わりにscenario
# describe ... type: :featureの代わりにfeature
# beforeの代わりに、before
# letの代わりにgiven
# RSpec.feature "session", type: :feature do
#
#   background do
#     @user = FactoryGirl.create(:user)
#     @task = FactoryGirl.create(:task,
#                                 user_id: @user.id
#     )
#     @today = Date.today
#     visit root_path
#     fill_in 'session[username]', with: @user.username
#     fill_in 'session[password]', with: @user.password
#     click_button 'ログイン'
#     visit tasks_path
#   end
#
#   describe 'ログイン画面' do
#     context '新規タスク作成リンクを押下すると' do
#       scenario "タスク一覧画面に遷移する" , js: false do
#         expect(page).to have_content 'タスク一覧'
#       end
#     end
#   end
#
#   describe 'タスク画面から新規タスク追加' do
#     context 'ラベル以外を入力、かつ全て有効値であるならば' do
#       background do
#         visit tasks_path
#         click_link "新規タスク追加"
#         fill_in 'task_name', with: @task.name
#         fill_in 'task_detail', with: @task.detail
#         find('option[value="high"]').select_option
#         select @today.year, from: "task_period_1i"
#         select @today.month, from: "task_period_2i"
#         select @today.day, from: "task_period_3i"
#         find('option[value="completed"]').select_option
#         click_button '登録'
#       end
#
#       scenario "タスクは登録され、タスク一覧ページへ遷移する" , js: false do
#         expect(page).to have_content @task.name
#         expect(page).to have_content @task.detail
#         expect(page).to have_content @task.period
#         expect(page).to have_content '全タスク一覧'
#       end
#     end
#   end
# end
