# frozen_string_literal: true
class CalendarController < ApplicationController
  def index
    @tasks_for_user = Task.my_task_without_params_and_completed(current_user.id).includes([:user, task_labels: :label])
    @today = Date.today
    @month = @today.strftime('%m')
    @d = @today.at_beginning_of_month.at_beginning_of_week(:sunday)
    define_next_and_previous(@today)
  end

  def show
    @tasks_for_user = Task.my_task_without_params_and_completed(current_user.id).includes([:user, task_labels: :label])
    param = params[:id].scan(/.{1,4}/)
    year = param[0].to_i
    month = param[1].to_i
    @today = Date.today
    @date = Date.new(year, month)
    @month = @date.strftime('%m')
    @year = @date.strftime('%y')
    @d = @date.at_beginning_of_month.at_beginning_of_week(:sunday)
    define_next_and_previous(@date)
  end

  private

  def define_next_and_previous(date)
    next_year = date.next_month.strftime('%Y')
    next_month = date.next_month.strftime('%m')
    @next = next_year + next_month

    previous_year = date.prev_month.strftime('%Y')
    previous_month = date.prev_month.strftime('%m')
    @previous = previous_year + previous_month
  end
end
