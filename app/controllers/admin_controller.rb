class AdminController < ApplicationController
  def dashboard
      @users = User.all
  end

  def destroy
    User.find(params[:id]).destroy!

    if @user.destroy
      redirect_to admin_dashboard_path, notice: 'User deleted.'
    end
  end
end