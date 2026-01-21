class UsersController < ApplicationController
  before_action :logged_in_user, only: [ :index, :edit, :update, :destroy ]
  before_action :correct_user, only: [ :edit, :update ]
  before_action :admin_user, only: :destroy

  def new
    @user = User.new
  end

  def index
    @users = User.paginate(page: params[:page])
  end

  def create
    @user = User.new(user_params)
    if @user.save
      reset_session
      log_in @user
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      render "new", status: :unprocessable_entity
    end
  end

  def edit
      @user = User.find(params[:id])
  end

  def show
    @user = User.find_by(id: params[:id])

    if @user.nil?
      flash[:danger] = "User not found. Please sign up."
      redirect_to signup_url # Or render "new" as you had it
    end
    unless logged_in?
      flash[:danger] = "Please log in.To see the User."
      redirect_to login_url
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      # Handle a successful update.
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render "edit", status: :unprocessable_entity
    end
  end

  def destroy
    user = User.find(params[:id])
    if user && user.admin?
      flash[:danger] = "Admin users cannot be deleted. Contact DataBase Admin."
      redirect_to users_url, status: :see_other
      return
    end
    user.destroy
    flash[:success] = "User deleted"
    redirect_to users_url, status: :see_other
  end


  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  # Confirms a logged-in user.
  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = "Please log in."
      redirect_to login_url, status: :see_other
    end
  end

  # Confirms the correct user.
  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url, status: :see_other) unless current_user?(@user)
  end

  # Confirms an admin user.
  def admin_user
    redirect_to(root_url, status: :see_other) unless current_user.admin?
  end
end
