describe "POST#create" do
  context "with valid attributes" do
    before do
      # ユーザを作成する
      User.create!(username: 'testname', password: '123456')
    end

    it "ログインされること" do
      visit login
      fill_in 'username', with: 'testname'
      fill_in 'password', with: '123456'
      click_on 'ログイン'
      expect(page).to have_content 'タスク一覧'
    end

    it "redirects to articles#index" do
      post :create, user: FactoryGirl.attributes_for(:user)
      expect(response).to redirect_to tasks_path
    end
  end
end