require 'rails_helper'
RSpec.describe Label, type: :model do
  describe 'バリデーション' do
    context '適切な名前とパスワードを与えると' do
      before do
        @label = FactoryGirl.create(:label)
      end
      it "バリデーション通過" do
        expect(@label).to be_valid
      end
    end

    context 'ラベル名を空欄にすると' do
      before do
        @label = FactoryGirl.build(:label,
                                   name: nil
        )
        @label.save
      end

      it "バリデーションエラー" do
        expect(@label).not_to be_valid
      end
    end
  end
end