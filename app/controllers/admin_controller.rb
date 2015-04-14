class AdminController < ApplicationController
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
end