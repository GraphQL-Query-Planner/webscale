class CommentsController < ApiController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]

  # GET /comments
  def index
    comments = Comment.all
    render :json => comments.to_json
  end

  # GET /comments/1
  def show
    render :json => @comment.to_json
  end

  # POST /comments
  def create
    content = comment_params[:content_type].constantize.find(comment_params[:content_id])
    comment = content.comments.new(comment_params)
    if comment.save!
      render :json => comment.to_json, status: :created
    else
      render :json => comment.errors, status: :unprocessable_entity
    end
  rescue NoMethodError, NameError, ActiveRecord::RecordNotFound
    head :unprocessable_entity
  end

  # PATCH/PUT /comments/1
  def update
    if @comment.update(comment_params)
      render :json => @comment.to_json
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  # DELETE /comments/1
  def destroy
    @comment.destroy
    render json: 'Comment was successfully destroyed.', status: :ok
  end

  private
    def set_comment
      @comment = Comment.find(params[:id])
    end

    def comment_params
      params.permit(:body, :author_id, :content_id, :content_type)
    end

end
