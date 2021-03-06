class PostsController < ApplicationController
load_and_authorize_resource




  def index
    if params[:search].blank?
      posts = Post.latest
      @posts = Kaminari.paginate_array(posts).page(params[:page]).per(10)
    else
      @posts = Post.search(params)
    end

    respond_to do |format|
      format.html
      format.json { render json: @posts }
    end
  end

  def show
    @post = Post.includes(:user).find(params[:id])
  end

  def new
    @post = Post.new

    respond_to do |format|
      format.html
      format.json { render json: @post }
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def create
    @post = Post.new(params[:post])
    @post.user_id = current_user.id

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: t(:success) }
        format.json { render json: @post, status: :created, location: @post }
      else
        format.html { render action: "new" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @post = Post.find(params[:id])

    respond_to do |format|
      if @post.update_attributes(params[:post])
        format.html { redirect_to @post, notice: t(:success) }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    respond_to do |format|
      format.html { redirect_to posts_url }
      format.json { head :no_content }
    end
  end

  def unapproved
    @posts = Post.unapproved
  end

  def approve
    @post = Post.find(params[:id])
    if current_user.role == 1
      @post.approved = 1
      @post.save
      expire_fragment('blog_posts')
      UserMailer.delay(priority: 60).new_post_notifier(@post)
      redirect_to :back
    end
  end

end
