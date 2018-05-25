class GroupsController < ApplicationController
  before_action :ensure_correct_user, only: %i[index destroy]

  def index
    @groups = Group.all.page(params[:page]).per(10)
  end

  def new
    @group = Group.new
  end

  def create
    group = Group.new(group_params)
    if group.save
      flash[:notice] = t('flash.group.new_group_added')
      param_user_ids = params[:group][:user_ids].select {|id| id.present?}
      param_user_ids.each do |user_id|
        group.group_users.create(user_id: user_id)
      end
      redirect_to groups_path
    else
      render 'new'
    end
  end

  def edit
    @group = Group.find(params[:id])
  end

  def update
    group = Group.find(params[:id])
    param_user_ids = params[:group][:user_ids].select {|id| id.present?}
    group.group_users.delete_all
    param_user_ids.each do |user_id|
      group.group_users.create(user_id: user_id)
    end

    #　これは複数返る
    if group.update(group_params)
      flash[:notice] = t('flash.group.new_group_added')
      redirect_to groups_path
    else
      p group.errors
    end
  end

  def destroy
    group = Group.find(params[:id])
    group.destroy
    redirect_to groups_path
  end

  def ensure_correct_user
    redirect_to tasks_path, flash[:notice] = t('flash.no_authority') unless current_user.super
  end

  private

  def group_params

    params.require(:group).permit(
        :name,
        :description,
        # user_ids:[
    )
  end
end
