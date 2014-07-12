class SessionsController < ApplicationController
  def new

  end

  def create
    user = User.find_by_username(params[:username])

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:notice] = "Hi #{current_user.username}! Welcome back!"
      redirect_to posts_path
    else
      flash[:error] = 'Invalid Name/Password'
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = "You've have logged out!"
    redirect_to root_path
  end
end