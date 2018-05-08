class TasksController < ApplicationController
  protect_from_forgery :except => [:read]
  helper_method :sort_column, :sort_order
  def index
    @q = Task.new
    @tasks = Task.all.order(sort_column + ' ' + sort_order).includes([:user, task_labels: :label]).page(params[:page]).per(10)
    @period_ended_tasks = Task.period_expired.page(params[:page]).per(5)
    @period_near_tasks = Task.period_close.page(params[:page]).per(5)
  end

  def more
    index
  end

  def search
  # @tasks = Task.all.includes([:user]).search_title_or_detail(@task.name)
  #              .search_label(params[:q][:label])
  #              .search_status(params[:q][:status])
  #              .page(params[:page]).per(10)
    @tasks = Task.search(params_word).page(params[:page]).per(10)
    @period_ended_tasks = Task.period_expired.page(params[:page]).per(5)
    @period_near_tasks = Task.period_close.page(params[:page]).per(5)
  end
  # public_methods.grep(/status)

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
    # GETなのにPOSTしてるのはダメ
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
    @my_tasks = Task.my_task(current_user.id).page(params[:page]).per(10)
  end

  def label
    @labels = Label.all
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
    if :q
      params.require(:q).permit(
          :name,
          :status,
          :label
      )
    end
  end

  def sort_order
    %w[asc desc].include?(params[:order]) ?  params[:order] : "asc"
  end

  def sort_column
    Task.column_names.include?(params[:sort]) ? params[:sort] : "status"
  end
end
