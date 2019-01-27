class UsersController < ApplicationController

  def index
    @users = User.paginate(page: params[:page])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.organization = @current_user.organization
    if @user.save
      flash[:notice] = 'The user user was successfully created.'
      redirect_to staff_users_path
    else
      render('new')
    end
  end

  def edit
    @user = @current_user
  end

  def update
    @user = @current_user
    if @user.update(user_params)
      flash[:notice] = 'The user user was successfully updated.'
      redirect_to root_path
    else
      render('edit')
    end
  end

  private

    def user_params
      params.require(:user).permit(
        :email,
        :email_confirmation,
        :first_name,
        :last_name,
        :password,
        :password_confirmation,
        :previous_password,
        :username
      )
    end

end
