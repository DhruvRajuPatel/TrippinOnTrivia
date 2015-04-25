class AdminController < ApplicationController
  before_filter :authenticate_user!
  before_filter do
    redirect_to "/", notice: 'You are not authorized to access that page.' unless current_user && current_user.admin? || current_user.reviewer?
  end
  def dashboard
      @users = User.all
      @questions = Question.all
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy!

    if @user.destroy
      redirect_to admin_dashboard_path, notice: 'User deleted.'
    end
  end

  def promote_admin
    @user = User.find(params[:id])
    @user.become_admin
    redirect_to admin_dashboard_path, notice: 'User promoted to admin.'
  end

  def demote_admin
    @user = User.find(params[:id])
    @user.update_attribute(:admin, false)
    redirect_to admin_dashboard_path, notice: 'User demoted from admin.'
  end

  def promote_reviewer
    @user = User.find(params[:id])
    @user.update_attribute(:reviewer, true)
    redirect_to admin_dashboard_path, notice: 'User promoted to reviewer.'
  end

  def demote_reviewer
    @user = User.find(params[:id])
    @user.update_attribute(:reviewer, false)
    redirect_to admin_dashboard_path, notice: 'User demoted from reviewer.'
  end
end