class LikesController < ApiController
  before_action :set_like, only: [:destroy]

  # GET /likes
  def index
    likes = Like.all
    render :json => likes.to_json
  end

  # POST /likes
  def create
    content = like_params[:content_type].constantize.find(like_params[:content_id])
    like = content.likes.new(like_params)
    if like.save!
      render :json => like.to_json, status: :created
    else
      render :json => like.errors, status: :unprocessable_entity
    end
  rescue NoMethodError, NameError, ActiveRecord::RecordNotFound
    head :unprocessable_entity
  end

  # DELETE /likes/1
  def destroy
    @like.destroy
    render json: 'Like was successfully destroyed.', status: :ok
  end

  private

  def set_like
    @like = Like.find(params[:id])
  end

  def like_params
    params.permit(:user_id, :content_id, :content_type)
  end
end
