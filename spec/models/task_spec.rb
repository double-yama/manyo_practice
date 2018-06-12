require 'rails_helper'

RSpec.describe Task, type: :model do
    let!(:user) { FactoryGirl.create(:user) }
    let!(:today) { Date.today }
    let!(:yesterday) { Date.today - 1.day }
    let!(:tomorrow) { Date.today + 1.day }

    describe 'バリデーションテスト' do
      context '名前のみ空にすると' do
        before do
          @task = FactoryGirl.build(:task,
                                    name: nil,
                                    detail: 'testtest',
                                    period: '2018/05/23',
                                    user_id: user.id
          )
          @task.save
        end

        it 'バリデーションに引っかかる' do
          expect(@task).not_to be_valid
        end
      end

      context '説明のみ空にすると' do
        before do
          @task = FactoryGirl.build(:task,
                                    detail: nil,
                                    period: today,
                                    user_id: user.id
          )
          @task.save
        end

        it 'バリデーションに引っかかる' do
          expect(@task).not_to be_valid
        end

        it '特定のエラーメッセージ「Detail cannot be blank」を返す' do
          expect(@task.errors.full_messages).to include 'Detail cannot be blank'
        end
      end

      context '期限のみ空にすると' do
        before do
          @task = FactoryGirl.build(:task,
                                    period: nil,
                                    user_id: user.id
          )
          @task.save
        end

        it 'バリデーションエラー' do
          expect(@task).not_to be_valid
        end

        it '特定のエラーメッセージ「Period cannot be blank」を返す' do
          expect(@task.errors.full_messages).to include 'Period cannot be blank'
        end
      end
    end

    describe "check_period" do
      context "前日の日付の場合" do
        before do
          @task = FactoryGirl.build(:task,
                                    period: yesterday,
                                    user_id: user.id
          )
          @task.save
        end
        it "validationによってエラーとなる" do
          expect(@task).not_to be_valid
        end

        it "「今日以降の日付を入力してください」というメッセージが表示される" do
          expect(@task.errors.full_messages).to include '今日以降の日付を入力してください'
        end
      end

      context "今日と同じ日付の場合" do
        before do
          @task = FactoryGirl.build(:task,
                                    period: today,
                                    user_id: user.id
          )
          @task.save
        end
        it "エラーなし, バリデーション通過" do
          expect(@task).to be_valid
        end
      end

      # いらない
      context "今日から1日後の日付の場合" do
        before do
          @task = FactoryGirl.build(:task,
                                    period: tomorrow,
                                    user_id: user.id
          )
          @task.save
        end
        it "エラーなし, バリデーション通過" do
          expect(@task).to be_valid
        end
      end
    end

    describe "period_expired" do
      context "データの日付が明日の場合" do
        before do
          @task = FactoryGirl.build(:task,
                                    user_id: user.id,
                                    period: tomorrow
          )
          @task.save(validate: false)
        end

        it "何も返されない" do
          expect(user.tasks.period_expired).to be_empty
        end
      end

      context "データの日付が今日の場合" do
        before do
          @task = FactoryGirl.build(:task,
                                    user_id: user.id,
                                    period: today
          )
          @task.save(validate: false)
        end
        it "何も返されない" do
          expect(user.tasks.period_expired).to be_empty
        end
      end

      context "データの日付が1日前の場合" do
        before do
          @task = FactoryGirl.build(:task,
                                    user_id: user.id,
                                    period: yesterday,
                                    status: 'doing'
          )

          @task.save(validate: false)
        end
        it "期限切れのため、データが1つ返される" do
          expect(user.tasks.period_expired.size).to eq 1
        end
      end
    end

    describe "period_closed" do
      context "データの日付が4日後の場合" do
        before do
          @task = FactoryGirl.build(:task,
                                    user_id: user.id,
                                    period: today + 4.day
          )
          @task.save(validate: false)
        end
        it "期限が3日以内でないため, 何も返されない" do
          expect(user.tasks.deadline_closed(3)).to be_empty
        end
      end

      context "データの日付が2日後の場合" do
        before do
          @task = FactoryGirl.build(:task,
                                    user_id: user.id,
                                    period: today + 2.day
          )
          @task.save(validate: false)
        end

        it "期限が2日以内のため、データが1つ返される" do
          expect(user.tasks.deadline_closed(3).count).to eq 1
        end
      end

      context "データの日付が明日の場合" do
        before do
          @task = FactoryGirl.build(:task,
                                    user_id: user.id,
                                    period: tomorrow
          )
          @task.save(validate: false)
        end
        it "期限が2日以内のため、データが1つ返される" do
          expect(user.tasks.deadline_closed(3).size).to eq 1
        end
      end

      context "データの日付が今日の場合" do
        before do
          @task = FactoryGirl.build(:task,
                                    user_id: user.id,
                                    period: today
          )
          @task.save(validate: false)
        end
        it "期限が2日以内のため、データが1つ返される" do
          expect(user.tasks.deadline_closed(3).size).to eq 1
        end
      end

      context "データの日付が1日前の場合" do
        before do
          @task = FactoryGirl.build(:task,
                                    user_id: user.id,
                                    period: yesterday
          )
          @task.save(validate: false)
        end
        it "期限が2日以内でないため, 何も返されない" do
          expect(user.tasks.deadline_closed(3)).to be_empty
        end
      end
    end

    before do
      @params = {}
    end

    describe "search" do
      context "検索ワード｢test｣が名前に含まれるものが3個,説明文に2個,そうでないものが4個あるとき" do
        before do
          @params[:name] = 'test'
          1.upto 3 do
            test_in_name = FactoryGirl.build(:task,
                                             name: 'aaa_test_bbb'
            )
            test_in_name.save(validate: false)
          end

          1.upto 2 do
            test_in_detail = FactoryGirl.build(:task,
                                               detail: 'aaa_test_bbb'
            )
            test_in_detail.save(validate: false)
          end

          1.upto 4 do
            no_test = FactoryGirl.build(:task,
                                        name: 'no_word',
                                        detail: 'aaa_bbb'
            )
            no_test.save(validate: false)
          end
        end
        it "該当したオブジェクトが5個返される" do
          expect(user.tasks.search_tasks_by_queries(@params).size).to eq 5
        end
      end

      context "検索ワード｢test｣が名前に含まれるものが3個,説明文に2個,そうでないものが4個あるとき" do
        it "該当したオブジェクトが5個返される" do

          @params[:name] = 'test'
          1.upto 3 do
            test_in_name = FactoryGirl.build(:task,
                                             name: 'aaa_test_bbb'
            )
            test_in_name.save(validate: false)
          end

          1.upto 2 do
            test_in_detail = FactoryGirl.build(:task,
                                               detail: 'aaa_test_bbb'
            )
            test_in_detail.save(validate: false)
          end

          1.upto 4 do
            no_test = FactoryGirl.build(:task,
                                        name: 'no_word',
                                        detail: 'aaa_bbb'
            )
            no_test.save(validate: false)
          end
          expect(user.tasks.search_tasks_by_queries(@params).size).to eq 5
        end
      end

      context "検索ワード｢未着手｣がラベルに含まれるタスクを与えたとき" do
        it "未着手を含むオブジェクトが返る" do
          @params[:status] = '未着手'
          no_test = FactoryGirl.build(:task,
                                      name: 'no_word',
                                      detail: 'aaa_bbb',
                                      status: 0
          )
          no_test.save(validate: false)
          expect(user.tasks.search_tasks_by_queries(@params).size).to eq 1
        end
      end
    end

    before do
      @user1 = FactoryGirl.create(:user,
                                  username: 'aaa'
      )
      @user2 = FactoryGirl.create(:user,
                                  username: 'bbb'
      )
    end

    describe "my_task" do
      context "user1のタスク数は1個, user2のタスク数は1個あるとき" do
        before do
          task = FactoryGirl.build(:task,
                                   user_id: @user1.id
          )
          task.save(validate: false)
        end

        it "user2のタスクの個数1が返される" do
          expect(@user1.tasks.size).to eq 1
        end
      end
    end

    describe "destroy_all_tasks" do
      context "user1のタスク数は1個, user2のタスク数は1個あるとき" do
        before do

          task = FactoryGirl.build(:task,
                                   user_id: @user1.id
          )
          task.save(validate: false)

          task = FactoryGirl.build(:task,
                                   user_id: @user2.id
          )
          task.save(validate: false)
        end

        it "消したタスク数は1, 残ったタスクの個数は1が返る" do
          expect(User.destroy_all_tasks(@user1.id).size).to eq 1
          expect(Task.where(user_id: @user2.id).size).to eq 1
        end
      end
    end

    describe "メール送信テスト" do
      context "タスクを10個作ると" do
        before do
          @task = FactoryGirl.build(:task,
                                    name: '三好ランドに行くことをやめること',
                                    detail: 'testtest',
                                    period: tomorrow,
                                    user_id: user.id
          )

          10.times{
            NoticeMailer::sendmail_confirm_task(@task.name).deliver
          }
        end
        it "メールも十回送信される" do
        end
      end
    end

end
