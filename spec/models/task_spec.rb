require 'rails_helper'
RSpec.describe Task, type: :model do
  before do
    @user = FactoryGirl.create(:user)
  end
  describe "check_period" do
    context "今日より前の日付を送信した場合" do
      it "validationによってエラーとなる" do
        task = FactoryGirl.build(:task,
          period: '2018-01-01',
          user_id: @user.id
        )
        p task
        expect(task).not_to be_valid
      end
    end

    context "今日から三日後の日付を送信した場合" do
      it "validation通過" do
      task = FactoryGirl.create(:task,
            user_id: @user.id,
            period: '2018-05-01'
        )
      expect(task).to be_valid
      end
    end
  end

  describe "period_expired(期限切れのチェック)" do
    context "今日以後の日付を入れた場合" do
      it "何も返されない" do
        # user = FactoryGirl.build(:user)
        task = FactoryGirl.create(:task,
            user_id: @user.id,
            period: '2018-04-28'
        )
        task.save(validate: false)
        expect(Task.period_expired).to be_empty
      end
    end

    context "今日以前の日付を入力した場合" do
      it "該当したオブジェクトが返される" do
        today = Date.today
        0.upto(3) do |n|
          task
        end
        1.upto 5 do |n|
          task = FactoryGirl.build(:task,
              user_id: @user.id,
              period: today - 2 + n,
              name: "taskname#{n}"
          )
        end

        # task1 = FactoryGirl.build(:task,
        #     user_id: @user.id,
        #     period: today - 1
        # )
        # task2 = FactoryGirl.build(:task,
        #                           user_id: @user.id,
        #                           period: today + 1
        # )
        # task3 = FactoryGirl.build(:task,
        #                           user_id: @user.id,
        #                           period: today + 2
        # )
        task1.save(validate: false)
        task2.save(validate: false)
        task3.save(validate: false)
        expect(Task.period_expired.count).to eq 1
      end
    end
  end

  describe "destroy_all_tasks" do
    context "今日以後の日付を入れた場合" do
      it "何も返されない" do

      end
    end
  end



  # describe "period_expired" do
  #   context "30個のタスクに対して" do
  #     it "期限切れのタスクの個数は10個" do
  #       30.times { FactoryGirl.create(:user, super: 0) }
  #     end
  #   end
  # end

        # priority: 'high',
        #     user_id: user.id,
        #     period: '2018-05-01'

  # it "is invalid with a method whose name is notice_period_ended_task" do
  #   user = FactoryGirl.build(:user)
  #   task2 = user.tasks.build(
  #       name: "RSpec Test",
  #       detail: "RSpec Detail",
  #       period: "2018-03-30"
  #   )
  #   expect(task2).to eq false
  # end
  #
  #
  # it "is invalid if past date is put in" do
  #   user = FactoryGirl.build(:user)
  #   task3 = user.tasks.build(
  #       name: "RSpec Test",
  #       detail: "RSpec Detail",
  #       period: "2014-03-23"
  #   )
  #   expect(task3).to eq false
  # end


end