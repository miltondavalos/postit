class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :vote]
  before_action :require_user, except: [:index, :show]
  before_action :require_same_user, only: [:vote]

  def index
    @posts = Post.all
  end

  def show
    @comment = Comment.new
    #@post = Post.find(params[:id])  #look at before_action
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.creator = current_user
    if @post.save
      flash[:notice] = 'Your post was created successfully!'
      redirect_to posts_path
    else
      render :new
    end
  end

  def edit
    #@post = Post.find(params[:id]) #look at before_action
  end

  def update
    #@post = Post.find(params[:id]) #look at before_action
    if @post.update(post_params)
      flash[:notice] = 'Your post was updated successfully!'
      redirect_to post_path(@post)
    else
      render :edit
    end
  end

  def vote
    @vote = Vote.create(voteable: @post, creator: current_user, vote: params[:vote])

    if @vote.valid?
      flash[:notice] = 'Your vote was counted.'
    else
      flash[:error] = 'Your vote was not counted.'
    end
    redirect_to :back
  end

  private
  def post_params
    #params.require(:post).permit!
    params.require(:post).permit(:title, :url, :description, category_ids: [])
  end

  def set_post
    @post = Post.find(params[:id])
  end

  def require_same_user
    if not current_user == @post.creator
      flash[:error] = 'You cannot do that.'
      redirect_to root_path
    end
  end

end