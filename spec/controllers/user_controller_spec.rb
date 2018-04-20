before do
  @user = create(:user)
  sign_in @user
end

after do
  sign_out @user
end