class Staff::UserController < ApplicationController

  def index
    @users = User.all
  end

  def update
    if @user.update(user_params)
      # prevent the admin from locking themselves out
      head :ok
    else
      head :error
    end
  end

  private

  def user_params
    params.require(:user).permit(
      :enabled
    )
  end

end
