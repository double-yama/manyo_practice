FactoryGirl.define do
  # factory :contact do
  #   sequence(name)  { |n| "Person #{n}" }
  #   sequence(password_digest) { |n| "password_#{n}"}
  # end

  factory :user do
    id 1
    username 'takahashi'
    password_digest 'keishi'
    # super 0
  end
end
