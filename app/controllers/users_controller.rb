class UsersController < ApplicationController
  def new
     @user =  User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = 'You have register successfully!'
      redirect_to root_path
    else
      #flash[:error] = 'Invalid username/password'   move to template
      render :new
    end
  end

  private
  def user_params
    params.require(:user).permit(:username, :password)
  end
end