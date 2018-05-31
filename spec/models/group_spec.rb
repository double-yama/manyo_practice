require 'rails_helper'
RSpec.describe Group, type: :model do
  describe 'バリデーション' do # validation設定してるならいらない
    context '適切な名前とパスワードを与えると' do
      before do
        @group = FactoryGirl.create(:group)
      end
      it "バリデーション通過" do
        expect(@group).to be_valid
      end
    end

    context '不適切な名前を与えると' do
      before do
        @group = FactoryGirl.build(:group,
                                  name: nil
        )
        @group.save
      end

      it "バリデーションエラー" do
        expect(@group).not_to be_valid
      end
    end

    context '説明文を空にすると' do
      before do
        @group = FactoryGirl.build(:group,
                                  description: nil
        )
        @group.save
      end

      it "バリデーションエラー" do
        expect(@group).not_to be_valid
      end
    end
  end
end