require 'rails_helper'
RSpec.describe User, type: :model do
  it "is valid with a right name and password" do
    user1 = FactoryGirl.build(:user,
                            username: "test",
                            password: "password",
                            password_confirmation: "password")
    expect(user1).to be_valid
  end

  it "is invalid without a name" do
    user1 = FactoryGirl.build(
        :user,
         username: nil
    )
    user1.valid?
    expect(user1.errors[:username]).to include("を入力してください")
  end

  it "is invalid without a password" do
    user1 = FactoryGirl.build(:user, password_digest: nil)
    user1.valid?
    expect(user1.errors[:password_digest]).to include("を入力してください")
  end

end

