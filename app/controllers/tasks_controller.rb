class TasksController < ApplicationController
  # helperはビューのためのもの
  helper_method :sort_column, :sort_order

  def index
    @task = Task.new
    set_for_index
  end

  # public_methods.grep(/status)

  def new
    @task = Task.new
  end

  def show
    @task = Task.find(params[:id])
  end

  def read
    @task = Task.find(params[:read_id])
    @task.read_flg = 1
    @task.save
  end

  def edit
    @task = Task.find(params[:id])
    # @task.label_text = @task.labels.pluck(:name).uniq.join(",")
    @task.label_text = @task.labels
  end

  def create
    @task = Task.new(task_params)
    @task.user_id = current_user.id
    if @task.save
      NoticeMailer.sendmail_confirm_task(@task.name).deliver
      flash[:notice] = t('flash.new_task_added')
      redirect_to tasks_path
    else
      set_for_index
      render 'index'
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
    if params[:q].present?
      @q = Task.new(params_word)
      @tasks_for_user = Task.my_task(current_user.id).search_tasks_by_queries(params_word).page(params[:page]).per(10)
      @tasks_count = Task.tasks_count_for_my_page(current_user.id)
    else
      @q = Task.new
      @tasks_for_user = Task.my_task_without_params_and_completed(current_user.id).order(sort_column + ' ' + sort_order).includes([:user, task_labels: :label]).page(params[:page]).per(10)
      @tasks_count = Task.tasks_count_for_my_page(current_user.id)
    end
  end

  def turn_complete
    @task = Task.find(params[:task_id])
    @task.status = "completed"
    @task.save
  end

  def download
    task = Task.find(params[:id])
    filepath = task.file.url
    p 'talahashistakahasthitakahashi'
    p filepath.class
    send_file(filepath,
              # :type => 'txt/pdf',
              :disposition => 'attachment',
              :filename => task.file,
              :status => 200)
    redirect_to tasks_path
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
      :file,
      :file_cache
    )
  end

  def params_word
    if params[:q].present?
      params.require(:q).permit(
          :name,
          :status,
          :label
      )
    end
  end

  def sort_order
    %w[asc desc].include?(params[:order]) ?  params[:order] : Task::SORT_NAME[:desc]
  end

  def sort_column
    Task.column_names.include?(params[:sort]) ? params[:sort] : Task::COLUMN_NAME[:updated_at]
  end

  def set_for_index
    @period_ended_tasks = Task.period_expired.includes(:user).order('period ASC')
    @deadline_closed_tasks = Task.deadline_close(3).includes(:user).order('period ASC')
    @tasks = Task.all.order(sort_column + ' ' + sort_order).includes([:user, task_labels: :label]).page(params[:page]).per(10)
  end
end
