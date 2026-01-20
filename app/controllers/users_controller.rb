class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def index
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

  def show
    @user = User.find_by(id: params[:id])

    if @user.nil?
      flash[:danger] = "User not found. Please sign up."
      redirect_to signup_url # Or render "new" as you had it
    end
    if logged_in?
      if @user != current_user
        flash[:danger] = "You can only view your own profile."
        redirect_to root_url
      end
      @user = current_user
    else
      flash[:danger] = "Please log in.To see the User."
      redirect_to login_url
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
