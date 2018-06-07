class LabelsController < ApplicationController
  before_action :ensure_admin_user

  def index
    @labels = set_for_index
    @label = Label.new
  end

  def show
    @label = Label.find(params[:id])
  end

  def create
    @labels = set_for_index
    @label = Label.new(label_params)
    if @label.save
      flash[:notice] = t('flash.new_label_added')
      redirect_to labels_path
    else
      set_for_index
      render 'index'
    end
  end

  def edit
    @label = Label.find(params[:id])
    # if @label.save
    #   flash[:notice] = t('flash.new_label_added')
    #   redirect_to labels_path
    #   # format.html
    #   # format.js
    # else
    #   @labels = Label.all.order(created_at: :desc).page(params[:page]).per(10)
    #   render :index
    # end
    # ajaxを用いて新規登録するため、編集もajaxでやりたい
    # UI的に、一覧表示のHTMLタグがfield_tagなのはどうなのか？
  end

  def update
    @label = Label.find(params[:id])
    if @label.update(label_params)
      flash[:notice] = t('flash.task_updated')
      redirect_to labels_path
    else
      render 'edit'
    end
  end

  def destroy
    @label = Label.find(params[:id])
    @label.destroy
    redirect_to labels_path
  end

  def label_params
    params.require(:label).permit(:name)
  end

  private

  def set_for_index
    Label.all.order(created_at: :desc).page(params[:page]).per(10)
  end
end
