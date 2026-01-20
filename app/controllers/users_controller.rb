class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def index
  end

  def create
    @user = User.new(user_params)
    if @user.save
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
    # debugger
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
