class Api::V1::UsersController < ApiController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users/1
  # freely visible to all
  def show

  end

  def check_valid
    target = User.find(params[:target_user_id])
    user = current_user
    response = (params[:response] == "1")
    APNS.send_notification(target.key, alert: 'You\'ve received a response.', other: { type: 'response', response: response } )
    render :json => {status: "ok"}.to_json, status: 200
  end

  def registration_check
    @user = current_user
    if @user
      render 'api/v1/users/show'
    else
      render :json => {error: "not found"}.to_json, status: 404
    end
  end

  # GET /users/new
  def new
    @user = User.new
  end


  # POST /users
  def create
    @user = User.new(params.require(:user).permit(:username, :photo))
    @user.key = request.headers[:key]

    #####

    #####

    if @user.save
      render 'api/v1/users/create'
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /users/1
  def update
    if @user == current_user
      if @user.update(user_params)
        render status: :ok
      else
        render json: @user.errors, status: :unprocessable_entity
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    if @user == current_user
      @user.destroy
      respond_to do |format|
        format.json { head :no_content }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:username, :photo)
    end
end
