FactoryGirl.define do
  factory :task do
    name 'hoge'
    detail 'hogehoge'
    priority 2
    user_id 1
    period '2018-04-28'
  end
end
