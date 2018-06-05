FactoryGirl.define do
  factory :task do
    name '三好ランドに行くのをやめること'
    detail 'hogehoge'
    priority 2
    user_id 1
    period '2018-04-28'
  end
end
