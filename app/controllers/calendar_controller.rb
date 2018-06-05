# frozen_string_literal: true
class CalendarController < ApplicationController
  def index
    @my_tasks = current_user.tasks.incomplete
    @today = Date.today
    @day = @today.at_beginning_of_month.at_beginning_of_week(:sunday)


  end

  def show
    @my_tasks = current_user.tasks.incomplete
    param = params[:year_month].scan(/.{1,4}/)
    year = param[0].to_i
    month = param[1].to_i
    @date = Date.new(year, month)
    @today = Date.today
    @d = @date.at_beginning_of_month.at_beginning_of_week(:sunday)
  end
end
