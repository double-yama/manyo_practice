FactoryGirl.define do
  factory :contact do
    sequence(name)  { |n| "Person #{n}" }
    sequence(password_digest) { |n| "password_#{n}"}
  end

  factory :user do
    username 'takahashi'
    password 'keishi'
    # password_digest 'keishi'
  end
end
