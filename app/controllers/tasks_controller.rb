class TasksController < ApplicationController
  def index
    # @tasks = Task.all.includes(:user).page(params[:page]).per(10)
    @q = Task.new(word_params)
    @tasks = Task.search
    # 以下、プライベートメソッドにする
    # @tasks = @tasks.search_status(@q.status)
    # @tasks = @tasks.search_task(@q.name)
    # @tasks = @tasks.search_label(@q.label)
    @search_params = params[:search]
    # 上の検索と一緒にやりたい

    # @tasks = Task.order(params[:sort]).page(params[:page]).per(10) if params[:sort] == "period"
    # @tasks = Task.all.order(created_at: :desc).includes([:user, task_labels: :label]) unless
    @period_ended_tasks = Task.notice_period_ended_task
    @period_near_tasks = Task.period_near_task
  end

  def new
    @task = Task.new
    # いるのか？
    # @task.labels.build
  end

  def show
    @tasks = Task.find(params[:id])
    @tasks.read_flg = 1
    # REST的にまずい、RESTでは、ここはGETであり、保存はしない
    # jQueryでAjaxでとばす
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

  def word_params
    if @q
      params.require(:q).permit(
        :name,
        :status,
        :period,
        :label
      )
    end
  end

  def search
    @tasks = Task.all.includes(:user).page(params[:page]).per(10)
    @tasks = Task.where(['name LIKE ?', "%#{params[:search]}%"]).or(where(['detail LIKE ?', "%#{search}%"])) if @q.name
                                                                                                             .present?
    @tasks = Task.joins(:labels).where(['labels.name LIKE ?', "%#{search}%"]) if @q.label.present?
    @tasks = Task.where(['status = ?', search]) if @q.status.present?
    @tasks
  end
end
