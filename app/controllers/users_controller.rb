class UsersController < ApplicationController

  def show
    current_user
  end

  def new
    redirect_to '/posts' if current_user
    @user = User.new
  end

  def create
    @user = User.new(get_params)
    @user.save
    if @user.created_at
      flash[:notice] = 'Successfully created user account'
      session[:id] = @user.id
      redirect_to '/posts'
    # elsif
    #   !@user.is_email_valid?(params[:email])
    #   flash[:danger] = 'Invalid email'
    #   redirect_to '/users/new'
    elsif
      !@user[:first_name]
      flash[:danger] = 'First name is a required field'
      redirect_to '/users/new'
    else
      flash[:danger] = 'Please check submitted information'
      redirect_to '/users/new'
    end
  end

  private

  def get_params
    params.fetch(:user, {}).permit(:first_name, :last_name, :password, :password_confirmation, :email)
  end

end
