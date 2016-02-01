class Api::V1::PhotosController < ApiController
  before_action :set_photo, only: [:show, :edit, :update, :destroy]

  # GET /photos
  # GET /photos.json
  def index
    @photos = Photo.all
  end

  # GET /photos/1
  # GET /photos/1.json
  def show

  end

  # GET /photos/new
  def new
    @photo = Photo.new
  end

  # GET /photos/1/edit
  def edit
  end

  # POST /photos
  # POST /photos.json

  # POST /api/v1/photos?target=:id
  def create

    @photo = Photo.new

    # set the things of our photo since params arent gonna work
    @photo.photo = params[:photo]

    # set the target user (which is just player 2)
    @photo.target_user_id = params[:target_user_id]
    # set player one
    @photo.user = current_user

    if @photo.save
      # APNS.send_notification(@match.target_user.key, alert: 'You\'ve been challenged.', other: {type: 'match', id: @match.user.id } )

      thumb = URI.join(request.url, @photo.photo.url(:thumb))
      medium = URI.join(request.url, @photo.photo.url(:medium))

      APNS.send_notification("#{@photo.target_user.key}", alert: 'Is this you?', other: { type: 'image', medium: "#{medium}", thumb: "#{thumb}" } )
      render :show, status: :created
    else
      render json: @photo.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /photos/1
  # PATCH/PUT /photos/1.json
  def update
    if @photo.update(photo_params)
      render :show, status: :ok
    else
      render json: @photo.errors, status: :unprocessable_entity
    end
  end

  # DELETE /photos/1
  # DELETE /photos/1.json
  def destroy
    @photo.destroy
    respond_to do |format|
      format.html { redirect_to photos_url, notice: 'Photo was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_photo
      @photo = Photo.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def photo_params
      params.require(:photo).permit(:photo, :target_user_id)
    end
end
