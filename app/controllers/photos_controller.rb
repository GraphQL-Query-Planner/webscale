class PhotosController < ApiController
  before_action :set_photo, only: [:show, :edit, :update, :destroy]

  # GET /photos
  def index
    photos = Photo.all
    render :json => photos.to_json
  end

  # GET /photos/1
  def show
    render :json => photo.to_json
  end

  # POST /photos
  def create
    photo = Photo.new(photo_params)
    if photo.save
      render :json => photo.to_json, status: :created
    else
      render :json => photo.errors, status: :created
    end
  end

  # PATCH/PUT /photos/1
  def update
    if photo.update(photo_params)
      render :json => photo.to_json
    else
      render json: photo.errors, status: :unprocessable_entity
    end
  end

  # DELETE /photos/1
  def destroy
    photo.destroy
    render json: 'Photo was successfully destroyed.', status: :ok
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_photo
      photo = Photo.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def photo_params
      params.permit(:post_id, :photo_url)
    end

end
