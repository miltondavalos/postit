class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]
  before_action :require_same_user, only: [:edit, :update]

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

  def show
    #@user = User.find(params[:id])
    @posts = @user.posts
  end

  def edit
    #@user = User.find(params[:id])
  end

  def update
    #@user = User.find(params[:id])

    if @user.update(user_params)
      flash[:notice] = 'Updated successfully!'
      redirect_to user_path(@user)
    else
      render :edit
    end
  end

  private
  def user_params
    params.require(:user).permit(:username, :password)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def require_same_user
    if not current_user == @user
      flash[:error] = 'You cannot do that.'
      redirect_to root_path
    end
  end
end