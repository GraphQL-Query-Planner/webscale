class PostsController < ApiController
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  # GET /posts
  def index
    posts = Post.all
    render :json => posts.to_json
  end

  # GET /posts/1
  def show
    render :json => @post.to_json
  end

  # POST /posts
  def create
    post = Post.new(post_params)
    if post.save
      render :json => post.to_json, status: :created
    else
      render :json => post.errors, status: :created
    end
  end

  # PATCH/PUT /posts/1
  def update
    if @post.update(post_params)
      render :json => @post.to_json
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  # DELETE /posts/1
  def destroy
    @post.destroy
    render json: 'Post was successfully destroyed.', status: :ok
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.permit(:body, :author_id, :receiver_id)
    end
end
