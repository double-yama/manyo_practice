FactoryGirl.define do

  factory :task do
    name 'hoge'
    detail 'hogehoge'
    priority 'completed'
    user_id 1
    period '2018-04-28'
  end
end