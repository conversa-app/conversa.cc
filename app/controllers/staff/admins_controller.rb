class Staff::AdminsController < StaffController

  def index
    @admins = Admin.paginate(page: params[:page])
  end

  def new
    @admin = Admin.new
  end

  def create
    @admin = Admin.new(admin_params)
    if @admin.save
      flash[:primary] = 'The admin user was successfully created.'
      redirect_to staff_admins_path
    else
      render('new')
    end
  end

  def edit
    @admin = Admin.find(params[:id])
  end

  def update
    @admin = Admin.find(params[:id])
    if @admin.update(admin_params)
      # prevent the admin from locking themselves out
      flash[:primary] = 'The admin user was successfully updated.'
      redirect_to staff_admins_path
    else
      render('edit')
    end
  end

  def delete
    @admin = Admin.find(params[:id])
  end

  def destroy
    Admin.find(params[:id]).destroy
    flash[:primary] = 'The admin user was successfully deleted.'
    redirect_to staff_admins_path
  end

  private

  def admin_params
    params.require(:admin).permit(
      :access_type_id,
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
