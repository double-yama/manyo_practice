class GroupsController < ApplicationController
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
    # group_user = GroupUser.find_by(group_id: params[:id])

    #　これは複数返る
    if group.update(group_params)
      flash[:notice] = t('flash.group.new_group_added')
      # param_user_ids = params[:group][:user_ids].select {|id| id.present?}
      # param_user_ids.each do |user_id|
      #   group.group_users.update(user_id: user_id)
      # end
      redirect_to groups_path
    else
      p group.errors
      # flash[:notice]
    end
  end

  def destroy
    group = Group.find(params[:id])
    group.destroy
    redirect_to groups_path
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
