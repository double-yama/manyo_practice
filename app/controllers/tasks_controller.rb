class TasksController < ApplicationController
  def index
    @tasks = Task.search_status(params[:status_word]).page(params[:page]).per(10)
    @tasks = Task.search_task(params[:task_word]).page(params[:page]).per(10) if params[:task_word]
    @tasks = Task.search_label(params[:label_word]).page(params[:page]).per(10) if params[:label_word]
    @params = params[:search]
    @tasks = Task.order(params[:sort]).page(params[:page]).per(10) if params[:sort] == "period"
@tasks = Task.all.order(created_at: :desc).includes([:user, task_labels: :label]) unless
    @period_ended_tasks = Task.notice_period_ended_task
    @period_near_tasks = Task.period_near_task
  end

  def new
    @task = Task.new
    @task.labels.build
  end

  def show
    @tasks = Task.find(params[:id])
    @tasks.read_flg = 1
    @tasks.save
  end

  def edit
    @task = Task.find(params[:id])
  end

  def create
    @task = Task.new(task_params)
    @task.user_id = current_user.id
    if @task.save
      flash[:notice] = t('flash.new_task_added')
      redirect_to tasks_path
    else
      render new_task_path
    end
  end

  def update
    @task = Task.find(params[:id])
    if @task.update(task_params)
      flash[:notice] = t('flash.task_updated')
      redirect_to tasks_path
    else
      render 'edit'
    end
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    redirect_to tasks_path
  end

  def mypage
    @my_task = Task.my_task(current_user.id)
  end

  private

  def task_params
    params.require(:task).permit(
      :name,
      :detail,
      :status,
      :period,
      :priority,
      :label_text,
    )
  end
end
