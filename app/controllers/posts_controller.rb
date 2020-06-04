class PostsController < ApplicationController
  before_action :authenticate_user!, only: %i[new create]

  # GET /posts

  def index
    @posts = Post.all
  end

  # GET /posts/new
  def new
    @post = Post.new
  end


  def create
    @post = current_user.posts.build(post_params)
    respond_to do |format|
      if @post.save
        format.html { redirect_to posts_path, notice: 'Post was successfully created.' }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end


  private

  def post_params
    params.require(:post).permit(:title, :body)
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_post
    @post = Post.find(params[:id])
  end
end
