require 'rails_helper'

RSpec.feature "Users", type: :feature do
  background do
    @today = Date.today
    @user = FactoryGirl.create(:user)
    @task = FactoryGirl.create(:task,
                               user_id: @user.id,
                               period: @today + 1.day
    )
  end
  feature '新規登録' do
    context '新規登録画面へ遷移し、適切なデータを入れて新規登録ボタンを押すと' do
      # 適切なデータだと意味がわからない
      # ユーザ名を高橋、パスワードを1234を入力すると
      # 保留 by 高橋MGR
      scenario '新規登録に成功し、メインに遷移する' do
        visit root_path
        click_link "新規登録"
        fill_in 'user[username]', with: 'sakimura'
        fill_in 'user[password]', with: 'kazutaka'
        fill_in 'user[password_confirmation]', with: 'kazutaka'
        click_button '登録'
        expect(page).to have_content '期限切れタスク一覧'
      end
    end

    context '登録済みのユーザ名とパスワードを入力し、ログインボタンを押すと' do
      scenario 'メイン画面に遷移する' do
        visit root_path
        fill_in 'session[username]', with: @user.username
        fill_in 'session[password]', with: @user.password
        click_button 'ログイン'
        visit tasks_path
        expect(page).to have_content '期限切れタスク一覧'
      end
    end
  end

  # feature 'ログアウト' do
  #   background do
  #     visit root_path
  #     fill_in 'session[username]', with: @user.username
  #     fill_in 'session[password]', with: @user.password
  #     click_button 'ログイン'
  #     # 別のところでログインしておこう
  #   end
  #   scenario 'ログアウトボタンを押すと, ログアウトされ, ログイン画面へ遷移する' do
  #     click_link 'ログアウト'
  #     expect(page).to have_content 'ログアウトしました'
  #   end
  # end
end
