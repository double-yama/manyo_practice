class TasksController < ApplicationController
  protect_from_forgery :except => [:read]
  def index
    @q = Task.new

    @tasks = Task.all.order(created_at: :desc).includes([:user, task_labels: :label]).page(params[:page]).per(10)
    @period_ended_tasks = Task.period_expired
    @period_near_tasks = Task.all.period_close
  end

  def search
    @tasks = Task.all
                 # .search_title_or_detail(params[:q][:name])
                 # .search_label(params[:q][:label])
                 # .search_status(params[:q][:status])
                 # .page(params[:page]).per(10)

    @tasks = Task.search(params_word).page(params[:page]).per(10)
    @period_ended_tasks = Task.period_expired
    @period_near_tasks = Task.period_close
    @params = params[:q]
  end

  def new
    @task = Task.new
  end

  def show
    @task = Task.find(params[:id])
  end

  def read
    @task = Task.find(params[:id])
    @task.read_flg = 1
    @task.save
    # ajaxを使うこと
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
    @my_tasks = Task.my_task(current_user.id)
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

  def params_word
    if :q
      params.require(:q).permit(
          :name,
          :status,
          :label
      )
    end
  end
end
