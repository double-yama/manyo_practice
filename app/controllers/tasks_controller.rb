class TasksController < ApplicationController
  protect_from_forgery :except => [:read]
  helper_method :sort_column, :sort_order

  def index
    @q = Task.new
    @tasks = Task.all.order(sort_column + ' ' + sort_order).includes([:user, task_labels: :label]).page(params[:page]).per(10)
    unless params[:q].nil?
      @tasks = Task.search_tasks_by_queries(params_word).page(params[:page]).per(10)
    end
    @period_ended_tasks = Task.period_expired.includes(:user).order('period ASC')
    @deadline_in_three_days = Task.deadline_in_three_days.includes(:user).order('period ASC')
  end

  # public_methods.grep(/status)

  def new
    @task = Task.new
  end

  def show
    @id = params[:id]
    @task = Task.find(@id)
  end

  def read
    @id = params[:read_id]
    @task = Task.find(@id)
    @task.read_flg = 1
    @task.save
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
      render 'new'
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
    redirect_back(fallback_location: root_path)
  end

  def mypage
    @my_tasks = Task.my_task(current_user.id).page(params[:page]).per(10)
  end

  private

  def task_params
    params.require(:task).permit(
      :name,
      :detail,
      :status,
      :period,
      :priority,
      :label_text
    )
  end

  def params_word
    if params[:q].present?
      params.require(:q).permit(
          # :username,
          :name,
          :status,
          :label
      )
    end
  end

  def sort_order
    %w[asc desc].include?(params[:order]) ?  params[:order] : t('params.desc')
  end

  def sort_column
    Task.column_names.include?(params[:sort]) ? params[:sort] : t('params.updated_at')
  end
end
