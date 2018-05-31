require 'rails_helper'

RSpec.feature "Sessions", type: :feature do

  given(:uri){URI.parse(current_url)}

  describe '未ログイン状態にて各ページへアクセス' do
    context '/tasksにアクセスすると' do
      before do
        visit tasks_path
      end
      scenario '/loginにリダイレクトされる' do
        expect("#{uri.path}").to eq(login_path)
      end
    end

    context '/mypageにアクセスすると' do
      before do
        visit mypage_tasks_path
      end
      scenario '/loginにリダイレクトされる' do
        expect("#{uri.path}").to eq(login_path)
      end
    end

    context '/groupにアクセスすると' do
      before do
        visit groups_path
      end
      scenario '/loginにリダイレクトされる' do
        expect("#{uri.path}").to eq(login_path)
      end
    end

    context '/labelにアクセスすると' do
      before do
        visit labels_path
      end
      scenario '/loginにリダイレクトされる' do
        expect("#{uri.path}").to eq(login_path)
      end
    end
  end

  describe 'ログイン' do
    before do
      @user = FactoryGirl.create(:user)
      visit login_path
    end

    context '適切なユーザ名とPWを入力し、ログインボタンを押下すると' do
      before do
        fill_in 'session[username]', with: @user.username
        fill_in 'session[password]', with: @user.password
        click_button 'ログイン'
      end
      scenario 'ログインされ、/tasksにリダイレクトされる' do
        expect("#{uri.path}").to eq(tasks_path)
      end
    end

    context '適切なユーザ名を入力しPWを空欄にして、ログインボタンを押下すると' do
      before do
        fill_in 'session[username]', with: @user.username
        fill_in 'session[password]', with: nil
        click_button 'ログイン'
      end
      scenario 'ログインに失敗し、ログイン画面にリダイレクトされる' do
        expect("#{uri.path}").to eq(login_path)
      end
    end

    context 'ユーザ名を空欄にし、適切なPWを入力し、ログインボタンを押下すると' do
      before do
        fill_in 'session[username]', with: nil
        fill_in 'session[password]', with: @user.password
        click_button 'ログイン'
      end
      scenario 'ログインに失敗し、ログイン画面にリダイレクトされる' do
        expect("#{uri.path}").to eq(login_path)
      end
    end
  end

  describe 'ログアウト' do
    before do
      @user = FactoryGirl.create(:user)
      visit login_path
      fill_in 'session[username]', with: @user.username
      fill_in 'session[password]', with: @user.password
      click_button 'ログイン'
    end
    context 'ログアウトボタンを押下すると' do
      before do
        click_link 'ログアウト'
      end
      scenario 'ログアウトされる' do
        expect("#{uri.path}").to eq(login_path)
      end
    end
  end

end
