class CalendarController < ApplicationController

  def index
    @tasks_for_user = Task.my_task_without_params(current_user.id).includes([:user, task_labels: :label])

  end
end
