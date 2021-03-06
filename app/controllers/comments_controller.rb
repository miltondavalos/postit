class CommentsController < ApplicationController
  #before_action :require_user

  def create
    @post = Post.find_by(slug: params[:post_id])
    @comment = @post.comments.build(comments_params)
    @comment.creator = current_user

    if @comment.save
      flash[:notice] = 'Your comment was added successfully!'
      redirect_to post_path(@post)
    else
      #flash.now[:error] = "Body can't be blank" if params[:body].nil?
      render 'posts/show'
    end
  end

  def vote
    @comment = Comment.find(params[:id])
    #@comment = comment
    @vote = Vote.create(voteable: @comment, creator: current_user, vote: params[:vote])

    respond_to do |format|
      format.html do
        if @vote.valid?
          flash[:notice] = 'Your vote was counted.'
        else
          flash[:error] = 'Your can only vote once for it.'
        end
        redirect_to :back
      end
      format.js
    end
  end

  private
  def comments_params
    params.require(:comment).permit(:body, :id)
  end
end