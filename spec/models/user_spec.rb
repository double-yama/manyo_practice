require 'rails_helper'
RSpec.describe User, type: :model do
  describe 'バリデーション' do # validation設定してるならいらない
    context '適切な名前とパスワードを与えると' do
      before do
        @user = FactoryGirl.create(:user)
      end
      it "バリデーション通過" do
        expect(@user).to be_valid
      end
    end

    context '不適切な名前を与えると' do
      before do
        @user = FactoryGirl.build(:user,
                                  username: nil
        )
        @user.save
      end

      it "バリデーションエラー" do
        expect(@user).not_to be_valid
      end

      it "特定のエラーメッセージが出力される" do
        expect(@user.errors.full_messages).to include("Usernameを入力してください")
      end
    end

    context '不適切なパスワードを与えると' do
      before do
        @user = FactoryGirl.build(:user,
                                  password: nil
        )
        @user.save
      end

      it "バリデーションエラー" do
        expect(@user).not_to be_valid
      end

      it "特定のエラーメッセージが出力される" do
        expect(@user.errors.full_messages).to include("Passwordを入力してください")
      end
    end
  end
end