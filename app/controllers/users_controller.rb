class UsersController < ApplicationController
  def new
     @user =  User.new
  end

  def create
    @user = User.new(params.require(:user).permit!)

    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = 'You have register successfully!'
      redirect_to root_path
    else
      render :new
    end
  end
end