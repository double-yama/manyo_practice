# frozen_string_literal: true.
class TasksController < ApplicationController
  helper_method :sort_column, :sort_order

  def index
    @task = Task.new
    set_for_index
  end

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
      flash[:notice] = t('flash.delete_task') + @task.name + t('flash.is_added')
      redirect_to tasks_path
    else
      set_for_index
      render 'index'
    end
  end

  def update
    task = Task.find(params[:id])
    param_label_ids = params[:task][:label_ids].select { |id| id.present? }
    task.task_labels.delete_all
    param_label_ids.each do |label_id|
      task.task_labels.create(label_id: label_id)
    end

    if task.update(task_params)
      flash[:notice] = t('flash.task_updated')
      redirect_to tasks_path
    else
      flash[:notice] = t('flash.task_updated')
      redirect_to tasks_path
      # render 'edit'
    end
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    redirect_back(fallback_location: root_path)
  end

  def my_page
    if params[:q].present?
      @q = Task.new(params_word)
      @my_tasks = my_tasks.search_tasks_by_queries(params_word).page(params[:page]).per(10)
    else
      @q = Task.new
      @my_tasks = my_tasks.incomplete.order(sort_column + ' ' + sort_order).include_label.include_users.page(params[:page]).per(10)
    end
  end

  def my_groups
    @tasks_of_my_group = my_tasks.incomplete.order(sort_column + ' ' + sort_order).include_label.include_user.page(params[:page]).per(10)
  end

  def tasks_for_group
    @tasks = Task.where(group_id: params[:id])
  end

  def turn_complete
    @task = Task.find(params[:task_id])
    @task.status = 'completed'
    @task.save
  end

  def download
    task = Task.find(params[:id])
    filepath = task.file.url
    send_file(filepath,
              disposition: 'attachment',
              filename: task.filename,
              status: 200)
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
      # :label_text,
      :file,
      :file_cache,
      :group_id
    )
  end

  def params_word
    params.require(:q).permit(
      :name,
      :status,
      :label
    )
  end

  def sort_order
    %w[asc desc].include?(params[:order]) ? params[:order] : Task::SORT_NAME[:desc]
  end

  def sort_column
    Task.column_names.include?(params[:sort]) ? params[:sort] : Task::COLUMN_NAME[:updated_at]
  end

  def set_for_index
    @my_period_expired_tasks = my_tasks.period_expired.include_users.incomplete.order('period ASC')
    @deadline_closed_tasks = my_tasks.deadline_closed(3).include_users.incomplete.order('period ASC')
    @tasks = Task.all.order(sort_column + ' ' + sort_order).include_label.page(params[:page]).per(10)
  end

  def my_tasks
    current_user.tasks
  end
end
