class CalendarController < ApplicationController

  def index
    @tasks_for_user = Task.my_task_without_params_and_completed(current_user.id).includes([:user, task_labels: :label])
    @today = Date.today
    @month = @today.strftime('%m')
    @d = @today.at_beginning_of_month.at_beginning_of_week(:sunday)
  end

  def move_previous_month
    @today = Date.today
    @month = @today.strftime('%m')
    @year = @today.strftime('%y')
    if @month == '1'
      @month = '12'
      @year = @year.to_i - 1
    else
      @month = @month.to_i - 1
      @month = @month.to_s
    end
  end

  def move_next_month

  end
end
